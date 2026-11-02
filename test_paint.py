"""Tests for paint.py. Stdlib only: `python3 -m unittest -v`."""
import os
import subprocess
import tempfile
import unittest
from datetime import date, timedelta
from unittest import mock

import paint
from paint import WAVE, commits_for, days_between, days_to_fill, gh_weekday, level, mismatches, sunday_week


class Level(unittest.TestCase):
    def test_hand_computed_anchors(self):
        # 2007-12-30 is the Sunday origin: week 0, row 0 -> WAVE[0] (the blank trough)
        self.assertEqual(level(date(2007, 12, 30)), 0)
        # 2008-01-01 is a Tuesday in week 0 -> row 2 -> phase 0 + 2*2 = 4 -> WAVE[4]
        self.assertEqual(level(date(2008, 1, 1)), 4)
        # 2008-01-06 is the next Sunday: week 1, row 0 -> WAVE[1]
        self.assertEqual(level(date(2008, 1, 6)), 1)

    def test_blank_only_in_troughs(self):
        # every shade appears, and blank is exactly 1 day in 8 (the trough), never more
        days = days_between(date(2008, 1, 1), date(2060, 12, 31))
        levels = [level(d) for d in days]
        self.assertEqual(set(levels), {0, 1, 2, 3, 4})
        self.assertAlmostEqual(levels.count(0) / len(levels), 1 / 8, places=3)
        for d in days:
            if level(d) == 0:   # a trough is flanked by the lightest green on both sides
                self.assertEqual((level(d - timedelta(7)), level(d + timedelta(7))), (1, 1))

    def test_deterministic(self):
        d = date(2031, 7, 14)
        self.assertEqual({level(d) for _ in range(5)}, {level(d)})

    def test_columns_are_sunday_aligned(self):
        sunday = date(2026, 11, 1)
        self.assertEqual(gh_weekday(sunday), 0)
        week = [sunday + timedelta(i) for i in range(7)]
        self.assertEqual({sunday_week(d) for d in week}, {sunday_week(sunday)})
        self.assertEqual(sunday_week(sunday + timedelta(7)), sunday_week(sunday) + 1)

    def test_every_column_steps_through_the_wave_without_jumps(self):
        # The old Tuesday-origin bug broke columns mid-week; here each column is the wave rotated.
        for sunday in (date(2008, 1, 6) + timedelta(7 * k) for k in range(0, 2800, 37)):
            col = [level(sunday + timedelta(r)) for r in range(7)]
            start = sunday_week(sunday) % len(WAVE)
            self.assertEqual(col, [WAVE[(start + 2 * r) % len(WAVE)] for r in range(7)])

    def test_diagonals_are_constant(self):
        # two weeks right and one row up lands on the same phase: straight 26.6-degree waves
        for d in days_between(date(2020, 1, 6), date(2020, 3, 1)):
            if gh_weekday(d) > 0:
                self.assertEqual(level(d), level(d + timedelta(14) - timedelta(1)))

    def test_commit_counts_scale_with_multiplier(self):
        d = date(2008, 1, 1)
        self.assertEqual(commits_for(d, 25), 100)
        self.assertEqual(commits_for(d, 1), 4)


class Ranges(unittest.TestCase):
    def test_same_day_rerun_is_noop(self):
        self.assertEqual(days_to_fill(date(2026, 11, 2), date(2026, 11, 2)), [])

    def test_gap_across_year_boundary(self):
        days = days_to_fill(date(2026, 12, 30), date(2027, 1, 2))
        self.assertEqual(days, [date(2026, 12, 31), date(2027, 1, 1), date(2027, 1, 2)])

    def test_last_day_in_future_is_noop(self):
        self.assertEqual(days_to_fill(date(2026, 11, 5), date(2026, 11, 2)), [])

    def test_mismatches_flags_wrong_and_missing_days(self):
        days = [date(2026, 11, 1), date(2026, 11, 2), date(2026, 11, 3)]
        counts = {days[0]: commits_for(days[0]), days[1]: commits_for(days[1]) + 1}
        bad = mismatches(counts, days)
        self.assertEqual([b[0] for b in bad], [days[1], days[2]])


class FastImportStream(unittest.TestCase):
    def test_empty_range_gives_empty_stream(self):
        self.assertEqual(paint.fast_import_stream([], "main", None), "")

    def test_parent_only_on_first_commit(self):
        s = paint.fast_import_stream([date(2008, 1, 1)], "main", parent="abc123", multiplier=2)
        self.assertEqual(s.count("commit refs/heads/main"), level(date(2008, 1, 1)) * 2)
        self.assertEqual(s.count("from abc123"), 1)


def git(cwd, *args):
    return subprocess.run(["git", *args], cwd=cwd, check=True, capture_output=True, text=True).stdout.strip()


class EndToEnd(unittest.TestCase):
    """Generate, extend and verify against a real throwaway git repo."""

    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.repo = self.tmp.name
        git(self.repo, "init", "-q", "-b", "main")
        self.cwd = os.getcwd()
        os.chdir(self.repo)

    def tearDown(self):
        os.chdir(self.cwd)
        self.tmp.cleanup()

    def counts(self):
        out = subprocess.run(["git", "log", "--format=%ad", "--date=format-local:%Y-%m-%d"],
                             cwd=self.repo, check=True, capture_output=True, text=True,
                             env={**os.environ, "TZ": "UTC"}).stdout.split()
        c = {}
        for line in out:
            c[line] = c.get(line, 0) + 1
        return c

    def test_generate_then_extend_keeps_files_and_matches_wave(self):
        self.assertEqual(paint.main(["--multiplier", "2", "generate", "--start", "2026-10-25", "--end", "2026-10-28"]), 0)
        git(self.repo, "checkout", "-q", "main")
        # add a tracked file on top, like the real repo's paint.py / workflow
        with open("keep.txt", "w") as f:
            f.write("x")
        git(self.repo, "add", "keep.txt")
        git(self.repo, "-c", "user.name=t", "-c", "user.email=t@t", "commit", "-q", "-m", "setup")

        with mock.patch.object(paint, "utc_today", return_value=date(2026, 11, 1)):
            self.assertEqual(paint.main(["--multiplier", "2", "extend"]), 0)
            self.assertEqual(paint.main(["--multiplier", "2", "extend"]), 0)   # rerun: no-op
            self.assertEqual(paint.main(["--multiplier", "2", "verify", "7"]), 0)

        self.assertTrue(os.path.exists("keep.txt"), "extend must keep the repo's files")
        c = self.counts()
        for d in days_between(date(2026, 10, 25), date(2026, 11, 1)):
            self.assertEqual(c.get(d.isoformat(), 0), commits_for(d, 2), d)
        self.assertEqual(paint.last_art_day(), date(2026, 11, 1))

    def test_verify_fails_on_wrong_day(self):
        paint.main(["--multiplier", "2", "generate", "--start", "2026-10-26", "--end", "2026-11-01"])
        git(self.repo, "checkout", "-q", "main")
        git(self.repo, "-c", "user.name=t", "-c", "user.email=t@t", "commit", "-q", "--allow-empty",
            "-m", "art", "--date=2026-11-01T12:00:00+0000")   # one stray extra art commit
        with mock.patch.object(paint, "utc_today", return_value=date(2026, 11, 1)):
            self.assertEqual(paint.main(["--multiplier", "2", "verify", "7"]), 1)


if __name__ == "__main__":
    unittest.main()
