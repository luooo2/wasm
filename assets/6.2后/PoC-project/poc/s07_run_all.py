#!/usr/bin/env python3
"""Run the full PoC experiment loop over every selected program.

For each program, benchmark all strategies (raw / O2 / O3 / random /
llm_static / llm_static_perf), check correctness, and record results to
results/results.csv. A run log is streamed to stdout.

Prereqs (run in order):
  python3 s02_extract_features.py
  python3 s03_make_prompts.py
  # author work/llm_responses/<prog>.<variant>.json (or use --provider openai)
  python3 s04_llm_select.py --provider manual
  python3 s07_run_all.py --repeats 15 --warmup 3
"""

from __future__ import annotations

import argparse
import csv
import json
import time
from pathlib import Path

from common import RESULTS_DIR, WORK_DIR, check_tools, load_allowed_passes, load_programs
from s05_strategies import STRATEGIES
from s06_evaluate import evaluate_program

FIELDS = [
    "program",
    "category",
    "strategy",
    "passes",
    "build_ok",
    "validate_ok",
    "correct",
    "native_median_ms",
    "wasm_median_ms",
    "wasm_native_ratio",
    "speedup_vs_raw",
    "speedup_vs_O3",
    "accepted",
    "diagnosis",
    "error",
]


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--repeats", type=int, default=15)
    ap.add_argument("--warmup", type=int, default=3)
    ap.add_argument("--timeout", type=int, default=300)
    ap.add_argument("--seed", type=int, default=42)
    ap.add_argument("--programs", default="", help="optional comma-separated subset")
    ap.add_argument("--strategies", default=",".join(STRATEGIES))
    ap.add_argument("--selections", default=str(WORK_DIR / "selections.json"))
    ap.add_argument("--out", default=str(RESULTS_DIR / "results.csv"))
    args = ap.parse_args()

    missing = check_tools()
    if missing:
        raise SystemExit(f"missing tools on PATH: {missing}")

    programs = load_programs()
    subset = {s.strip() for s in args.programs.split(",") if s.strip()}
    if subset:
        programs = [p for p in programs if p.name in subset]
    strategies = [s.strip() for s in args.strategies.split(",") if s.strip()]
    allowed = load_allowed_passes()

    sel_path = Path(args.selections)
    selections = json.loads(sel_path.read_text(encoding="utf-8")) if sel_path.exists() else {}
    if not selections:
        print(f"[warn] no selections at {sel_path}; llm_* strategies will be empty")

    all_rows = []
    t_start = time.time()
    for i, prog in enumerate(programs, 1):
        if not prog.raw_wasm.exists() or not prog.native_bin.exists():
            print(f"[skip] {prog.name}: missing build artifacts")
            continue
        print(f"\n=== [{i}/{len(programs)}] {prog.name} ({prog.category}) ===")
        rows = evaluate_program(
            prog,
            selections=selections,
            allowed=allowed,
            repeats=args.repeats,
            warmup=args.warmup,
            timeout=args.timeout,
            global_seed=args.seed,
            strategies=strategies,
        )
        for r in rows:
            tag = "ACCEPT" if r["accepted"] else ("OK" if r["correct"] else "BAD")
            print(
                f"  {r['strategy']:<16} ratio={str(r['wasm_native_ratio']):<8} "
                f"vsRaw={str(r['speedup_vs_raw']):<8} vsO3={str(r['speedup_vs_O3']):<8} "
                f"[{tag}] {r['error']}"
            )
        all_rows.extend(rows)

    RESULTS_DIR.mkdir(parents=True, exist_ok=True)
    with Path(args.out).open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=FIELDS)
        w.writeheader()
        w.writerows(all_rows)
    print(f"\n[ok] wrote {len(all_rows)} rows to {args.out} in {time.time()-t_start:.1f}s")


if __name__ == "__main__":
    main()
