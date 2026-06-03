#!/usr/bin/env python3
"""Evaluate one program across all strategies: build, validate, diff-test, bench.

Acceptance criterion (same as O2 PoC but now against O0 raw):
  Accept iff wasm-validate ok AND output matches native reference AND
  median runtime improves by >= MIN_SPEEDUP (3%) versus the O0 raw baseline.

Since the O0 baseline has much more redundancy than O2, even modest pass
selections are expected to yield >10% speedup on most programs.
"""

from __future__ import annotations

from typing import Dict, List, Optional

from common import (
    CAND_DIR,
    BenchResult,
    Program,
    bench_native,
    bench_wasm_aot,
    get_reference_output,
    normalize_output,
    wasm_validate,
)
from s05_strategies import STRATEGIES, build_candidate

MIN_SPEEDUP = 0.03  # >= 3% median improvement required to "accept"


def evaluate_program(
    prog: Program,
    selections: Dict[str, dict],
    allowed: List[str],
    repeats: int,
    warmup: int,
    timeout: int,
    global_seed: int = 42,
    strategies: Optional[List[str]] = None,
) -> List[dict]:
    strategies = strategies or STRATEGIES
    rows: List[dict] = []

    reference = get_reference_output(prog, timeout=timeout)
    nb = bench_native(prog, repeats=repeats, warmup=warmup, timeout=timeout)
    native_ms = nb.internal.get("median", 0.0) if nb.ok else 0.0

    raw_ms: Optional[float] = None

    for strat in strategies:
        row = {
            "program": prog.name,
            "category": prog.category,
            "strategy": strat,
            "passes": "",
            "build_ok": 0,
            "validate_ok": 0,
            "correct": 0,
            "native_median_ms": round(native_ms, 4),
            "wasm_median_ms": "",
            "wasm_native_ratio": "",
            "speedup_vs_raw": "",
            "speedup_vs_O3": "",
            "accepted": 0,
            "diagnosis": "",
            "error": "",
        }
        if strat in ("llm_static", "llm_static_perf"):
            v = "static" if strat == "llm_static" else "static_perf"
            sel = selections.get(f"{prog.name}::{v}", {})
            row["diagnosis"] = sel.get("diagnosis", "")

        cand, passes, berr = build_candidate(prog, strat, selections, allowed, global_seed)
        row["passes"] = " ".join(passes)
        if cand is None:
            row["error"] = f"build failed: {berr}"
            rows.append(row)
            continue
        row["build_ok"] = 1

        vok, verr = wasm_validate(cand)
        row["validate_ok"] = int(vok)
        if not vok:
            row["error"] = f"validate failed: {verr}"
            rows.append(row)
            continue

        wasmu = CAND_DIR / f"{prog.name}.{strat}.wasmu"
        br: BenchResult = bench_wasm_aot(cand, wasmu, repeats=repeats, warmup=warmup, timeout=timeout)
        if not br.ok:
            row["error"] = f"bench failed: {br.error}"
            rows.append(row)
            continue

        correct = reference is not None and normalize_output(br.sample_output) == reference
        row["correct"] = int(correct)
        if not correct:
            row["error"] = "output mismatch vs native reference"

        wasm_ms = br.internal.get("median", 0.0)
        row["wasm_median_ms"] = round(wasm_ms, 4)
        if native_ms > 0:
            row["wasm_native_ratio"] = round(wasm_ms / native_ms, 4)

        if strat == "raw":
            raw_ms = wasm_ms
        if raw_ms and wasm_ms > 0:
            row["speedup_vs_raw"] = round((raw_ms - wasm_ms) / raw_ms, 4)

        rows.append(row)

    # second pass: fill speedup_vs_O3 and accept/reject
    o3_ms = next(
        (r["wasm_median_ms"] for r in rows if r["strategy"] == "O3" and r["wasm_median_ms"] != ""),
        None,
    )
    for r in rows:
        wm = r["wasm_median_ms"]
        if wm == "" or not r["correct"] or not r["validate_ok"]:
            continue
        if o3_ms not in (None, "") and o3_ms > 0:
            r["speedup_vs_O3"] = round((o3_ms - wm) / o3_ms, 4)
        if r["strategy"] != "raw" and raw_ms and wm > 0:
            if (raw_ms - wm) / raw_ms >= MIN_SPEEDUP:
                r["accepted"] = 1
    return rows
