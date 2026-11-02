# paint

[![paint](https://github.com/Vvkmnn/paint/actions/workflows/paint.yml/badge.svg)](https://github.com/Vvkmnn/paint/actions/workflows/paint.yml)

Smooth, perfectly regular waves across the GitHub contribution graph, from 2008 to forever.

```
 ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█   Sun
▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒   Mon
█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░    Tue
▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒   Wed
 ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█   Thu
▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒   Fri
█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░    Sat
```

## How it works

- `level(day)` in [`paint.py`](paint.py) maps every date to a shade 0–4. Each wave runs blank → crest → blank over 8 weeks (blank only in the one-week trough), and each row shifts exactly 2 weeks, giving a clean 26.6° slope. Columns are counted from a Sunday, as GitHub's calendar is.
- Each day gets `level × 25` empty commits stamped 12:00 UTC, built with `git fast-import`.
- [`.github/workflows/paint.yml`](.github/workflows/paint.yml) runs daily at 12:30 UTC. It paints every day since the last art commit, pushes, then verifies the last 7 days. A failed run means something drifted, and GitHub emails the owner.
- Nothing else is read or touched. Real activity in other repos simply adds on top.

## Commands

```sh
python3 paint.py generate --start 2008-01-01   # build full history (empty repo)
python3 paint.py extend                        # paint last art day + 1 .. today
python3 paint.py verify 7                      # check the last 7 days
python3 -m unittest -v                         # tests (stdlib only)
```

Settings: repo variable `USER_EMAIL` sets the commit author email (it must be an email on the GitHub account, or the commits don't count). The default is the private GitHub no-reply address `1954615+Vvkmnn@users.noreply.github.com`, which keeps the real email out of public commits.
