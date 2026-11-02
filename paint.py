#!/usr/bin/env python3
"""Paint a smooth straight-wave pattern on a GitHub contribution graph.

The art is a pure function of the date (`level`), so any day's commits can be
computed independently: full history and daily top-ups always agree.

     ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓   Sun   (one column = one week; each wave runs
    ▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒   Mon    blank -> crest -> blank over 8 weeks and
    █▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░    Tue    each row shifts exactly 2 weeks: a
    ...                             perfectly regular 26.6-degree slope)

Commits are empty (no files change), dated 12:00 UTC on their day, and written
with `git fast-import`, which builds hundreds of thousands of commits in seconds.

Usage:
    paint.py generate --start 2008-01-01 --end 2026-11-02   # build history on a branch
    paint.py extend                                       # fill last art day + 1 .. today
    paint.py verify 7                                     # check the last 7 days match level()
"""
import argparse
import os
import subprocess
import sys
from datetime import date, datetime, timedelta, timezone

# GitHub's calendar columns start on Sunday. Counting weeks from a Sunday keeps every
# column a clean diagonal; the old script counted from Tuesday 2008-01-01, which made
# each column jump two rows down partway through.
WEEK_ORIGIN = date(2007, 12, 30)
WAVE = (0, 1, 2, 3, 4, 3, 2, 1)        # blank trough -> crest -> back: all 5 shades GitHub has
ROW_SHIFT = 2                          # weeks each row is offset: 1 = 45 deg, 2 = 26.6 deg (the
                                       # only clean angles on a week grid; others stair-step)
MULTIPLIER = 25                        # commits per shade; large enough to drown out real days
MESSAGE = "art"
COMMIT_HOUR_UTC = 12                   # midday UTC: same calendar date in any sane bucketing
AUTHOR_NAME = os.environ.get("PAINT_NAME") or "Vvkmnn"          # `or`: an unset Actions
AUTHOR_EMAIL = os.environ.get("PAINT_EMAIL") or "1954615+Vvkmnn@users.noreply.github.com"  # variable arrives as "" and would silently not count


def gh_weekday(day: date) -> int:
    """Row on the GitHub calendar: Sunday = 0 ... Saturday = 6."""
    return (day.weekday() + 1) % 7


def sunday_week(day: date) -> int:
    """Column index: whole weeks since the Sunday-aligned origin."""
    return (day - WEEK_ORIGIN).days // 7


def level(day: date) -> int:
    """Shade 0-4 for a day. 0 (blank) only in each wave's single-week trough."""
    return WAVE[(sunday_week(day) + ROW_SHIFT * gh_weekday(day)) % len(WAVE)]


def commits_for(day: date, multiplier: int = MULTIPLIER) -> int:
    return level(day) * multiplier


def days_between(start: date, end: date):
    """Inclusive range of days; empty when start > end."""
    return [start + timedelta(n) for n in range((end - start).days + 1)]


def days_to_fill(last_art_day: date, today: date):
    """Days still missing after the last painted day, up to and including today."""
    return days_between(last_art_day + timedelta(1), today)


def fast_import_chunks(days, branch: str, parent: str | None, multiplier: int = MULTIPLIER):
    """Yield a git fast-import stream of empty commits for `days`, one commit per chunk.

    Streaming keeps memory flat for full history (~470k commits). With `parent`, the
    first commit continues from it and every commit keeps the parent's tree
    (fast-import copies the tree when no files are modified), so the repo's files
    survive daily top-ups.
    """
    first = True
    for day in days:
        base = int(datetime(day.year, day.month, day.day, COMMIT_HOUR_UTC, tzinfo=timezone.utc).timestamp())
        for i in range(commits_for(day, multiplier)):
            ident = f"{AUTHOR_NAME} <{AUTHOR_EMAIL}> {base + i} +0000"   # +i s keeps order, same day
            parent_line = f"from {parent}\n" if first and parent else ""
            first = False
            yield (f"commit refs/heads/{branch}\nauthor {ident}\ncommitter {ident}\n"
                   f"data {len(MESSAGE)}\n{MESSAGE}\n{parent_line}\n")


def fast_import_stream(days, branch: str, parent: str | None, multiplier: int = MULTIPLIER) -> str:
    """Whole stream as one string (small ranges and tests)."""
    return "".join(fast_import_chunks(days, branch, parent, multiplier))


def git(*args: str) -> str:
    return subprocess.run(["git", *args], check=True, capture_output=True, text=True).stdout.strip()


def last_art_day() -> date | None:
    """Date of the newest art commit reachable from HEAD (None in an empty history)."""
    out = subprocess.run(["git", "log", "-1", f"--grep=^{MESSAGE}$", "--format=%ad",
                          "--date=format-local:%Y-%m-%d"],
                         capture_output=True, text=True, env={**os.environ, "TZ": "UTC"})
    return date.fromisoformat(out.stdout.strip()) if out.returncode == 0 and out.stdout.strip() else None


def art_counts_since(since: date) -> dict[date, int]:
    """Art commits per UTC day from `since` onward, read from git history."""
    out = subprocess.run(["git", "log", f"--grep=^{MESSAGE}$", "--format=%ad",
                          "--date=format-local:%Y-%m-%d", f"--since={since.isoformat()}T00:00:00Z"],
                         check=True, capture_output=True, text=True, env={**os.environ, "TZ": "UTC"})
    counts: dict[date, int] = {}
    for line in out.stdout.split():
        d = date.fromisoformat(line)
        counts[d] = counts.get(d, 0) + 1
    return counts


def mismatches(counts: dict[date, int], days, multiplier: int = MULTIPLIER):
    """Days whose recorded commit count differs from the art. Pure, so it is testable."""
    return [(d, counts.get(d, 0), commits_for(d, multiplier)) for d in days
            if counts.get(d, 0) != commits_for(d, multiplier)]


def run_fast_import(chunks) -> None:
    """Pipe stream chunks into git fast-import without holding them all in memory."""
    proc = subprocess.Popen(["git", "fast-import", "--quiet"], stdin=subprocess.PIPE, text=True)
    for chunk in chunks:
        proc.stdin.write(chunk)
    proc.stdin.close()
    if proc.wait() != 0:
        raise subprocess.CalledProcessError(proc.returncode, "git fast-import")


def utc_today() -> date:
    return datetime.now(timezone.utc).date()


def cmd_generate(args) -> int:
    days = days_between(date.fromisoformat(args.start), date.fromisoformat(args.end))
    run_fast_import(fast_import_chunks(days, args.branch, parent=None, multiplier=args.multiplier))
    print(f"generated {sum(commits_for(d, args.multiplier) for d in days):,} commits "
          f"over {len(days):,} days on {args.branch}")
    return 0


def cmd_extend(args) -> int:
    last = last_art_day()
    if last is None:
        print("no art commits found; run `generate` first", file=sys.stderr)
        return 1
    days = days_to_fill(last, utc_today())
    if not days:
        print(f"up to date (last art day {last})")
        return 0
    branch = git("rev-parse", "--abbrev-ref", "HEAD")
    head = git("rev-parse", "HEAD")
    run_fast_import(fast_import_chunks(days, branch, parent=head, multiplier=args.multiplier))
    git("reset", "--hard", f"refs/heads/{branch}")   # move the work tree onto the new tip
    print(f"painted {days[0]} .. {days[-1]} ({sum(commits_for(d, args.multiplier) for d in days)} commits)")
    return 0


def cmd_verify(args) -> int:
    today = utc_today()
    days = days_between(today - timedelta(args.days - 1), today)
    bad = mismatches(art_counts_since(days[0]), days, args.multiplier)
    for d, got, want in bad:
        print(f"MISMATCH {d}: {got} art commits, expected {want}", file=sys.stderr)
    if not bad:
        print(f"ok: last {args.days} days match the wave")
    return 1 if bad else 0


def main(argv=None) -> int:
    p = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    p.add_argument("--multiplier", type=int, default=MULTIPLIER)
    sub = p.add_subparsers(dest="cmd", required=True)
    g = sub.add_parser("generate", help="build history for a date range on a branch")
    g.add_argument("--start", required=True)
    g.add_argument("--end", default=utc_today().isoformat())
    g.add_argument("--branch", default="main")
    g.set_defaults(fn=cmd_generate)
    sub.add_parser("extend", help="paint from the last art day through today").set_defaults(fn=cmd_extend)
    v = sub.add_parser("verify", help="check the last N days against the wave")
    v.add_argument("days", type=int)
    v.set_defaults(fn=cmd_verify)
    args = p.parse_args(argv)
    return args.fn(args)


if __name__ == "__main__":
    sys.exit(main())
