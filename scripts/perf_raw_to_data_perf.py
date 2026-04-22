#!/usr/bin/env python3
"""
Pivot perf_raw_events.csv (long: one row per hardware event) into data_perf.csv
(one row per measured run with event names as columns).

Upstream collection runs a single `perf stat -e <comma-separated-events>` per
run; perf emits one CSV line per counter, which collect_perf_metrics.sh maps to
one output row each.
"""

from __future__ import annotations

import argparse
import csv
from collections import defaultdict
from pathlib import Path


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    p.add_argument(
        "--input",
        type=Path,
        default=Path(__file__).resolve().parent.parent
        / "data/results/perf/perf_raw_events.csv",
        help="Long-format perf CSV (default: data/results/perf/perf_raw_events.csv)",
    )
    p.add_argument(
        "--output",
        type=Path,
        default=Path(__file__).resolve().parent.parent
        / "data/results/perf/data_perf.csv",
        help="Wide-format output path (default: data/results/perf/data_perf.csv)",
    )
    p.add_argument(
        "--only-ok",
        action="store_true",
        help="Drop runs where status is not 'ok'",
    )
    return p.parse_args()


def event_column_order(events: set[str]) -> list[str]:
    preferred = [
        "cycles",
        "instructions",
        "branches",
        "branch-misses",
        "L1-dcache-loads",
        "L1-dcache-load-misses",
        "LLC-loads",
        "LLC-load-misses",
    ]
    ordered = [e for e in preferred if e in events]
    rest = sorted(e for e in events if e not in preferred)
    return ordered + rest


def main() -> None:
    args = parse_args()
    groups: dict[tuple[str, str, str, int], dict] = defaultdict(
        lambda: {
            "timestamp": "",
            "events": {},
            "statuses": set(),
            "notes": [],
        }
    )

    with args.input.open(newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        required = {
            "timestamp",
            "suite",
            "program",
            "mode",
            "run_index",
            "event",
            "value",
            "status",
        }
        if reader.fieldnames is None or not required.issubset(set(reader.fieldnames)):
            missing = required - set(reader.fieldnames or [])
            raise SystemExit(f"Unexpected CSV header; missing columns: {sorted(missing)}")

        for row in reader:
            if args.only_ok and row["status"].strip() != "ok":
                continue
            # One perf invocation => same (suite, program, mode, run_index) for all events.
            gkey = (
                row["suite"].strip(),
                row["program"].strip(),
                row["mode"].strip(),
                int(row["run_index"].strip()),
            )
            g = groups[gkey]
            if not g["timestamp"]:
                g["timestamp"] = row["timestamp"].strip()
            g["statuses"].add(row["status"].strip())
            note = (row.get("stderr_note") or "").strip()
            if note:
                g["notes"].append(note)
            ev = row["event"].strip()
            g["events"][ev] = int(row["value"].strip())

    all_events: set[str] = set()
    for g in groups.values():
        all_events.update(g["events"])
    metric_cols = event_column_order(all_events)

    fieldnames = [
        "timestamp",
        "suite",
        "program",
        "mode",
        "run_index",
        "status",
        "stderr_note",
    ] + metric_cols

    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="", encoding="utf-8") as out:
        w = csv.DictWriter(out, fieldnames=fieldnames)
        w.writeheader()
        for (suite, program, mode, run_index), g in sorted(
            groups.items(),
            key=lambda kv: (kv[0][0], kv[0][1], kv[0][2], kv[0][3]),
        ):
            statuses = g["statuses"]
            status = "ok" if statuses == {"ok"} else ";".join(sorted(statuses))
            row_out = {
                "timestamp": g["timestamp"],
                "suite": suite,
                "program": program,
                "mode": mode,
                "run_index": run_index,
                "status": status,
                "stderr_note": "; ".join(dict.fromkeys(g["notes"])),
            }
            for c in metric_cols:
                v = g["events"].get(c)
                row_out[c] = v if v is not None else ""
            w.writerow(row_out)

    print(f"Wrote {args.output} ({len(groups)} rows)")


if __name__ == "__main__":
    main()
