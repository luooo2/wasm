#!/usr/bin/env python3
"""Run the full O0 PoC experiment over every program and strategy.

For each program, benchmarks all strategies (raw / O3 / random /
llm_static / llm_static_perf), checks correctness, and records results to
results/results.csv. A run log is streamed to results/run_log.txt.

Prerequisites (run in order):
  python3 s01_build_o0.py
  python3 s02_extract_features.py
  python3 s03_make_prompts.py
  # fill work/llm_responses/<prog>.static.json and <prog>.static_perf.json
  # (or use --provider openai / --provider heuristic)
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
    ap = argparse.ArgumentParser(description="Run the O0 PoC benchmark experiment.")
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

    log_path = RESULTS_DIR / "run_log.txt"
    all_rows = []
    t_start = time.time()

    with log_path.open("w", encoding="utf-8") as log:
        def tee(msg: str) -> None:
            print(msg)
            log.write(msg + "\n")
            log.flush()

        tee(f"[O0 PoC run] {time.strftime('%Y-%m-%dT%H:%M:%S')}  "
            f"repeats={args.repeats}  warmup={args.warmup}  seed={args.seed}")
        tee(f"strategies: {strategies}")
        tee("")

        for i, prog in enumerate(programs, 1):
            if not prog.raw_wasm.exists() or not prog.native_bin.exists():
                tee(f"[skip] {prog.name}: missing O0 build artifacts")
                continue
            tee(f"=== [{i}/{len(programs)}] {prog.name} ({prog.category}) ===")
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
                msg = (
                    f"  {r['strategy']:<16} ratio={str(r['wasm_native_ratio']):<8} "
                    f"vsRaw={str(r['speedup_vs_raw']):<8} vsO3={str(r['speedup_vs_O3']):<8} "
                    f"[{tag}] {r['error']}"
                )
                tee(msg)
            all_rows.extend(rows)

        tee(f"\n[done] {len(all_rows)} rows in {time.time()-t_start:.1f}s")

    RESULTS_DIR.mkdir(parents=True, exist_ok=True)
    with Path(args.out).open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=FIELDS)
        w.writeheader()
        w.writerows(all_rows)
    print(f"[ok] wrote {len(all_rows)} rows to {args.out}")


if __name__ == "__main__":
    main()
