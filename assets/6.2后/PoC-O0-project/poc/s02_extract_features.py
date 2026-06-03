#!/usr/bin/env python3
"""Extract static features from O0 wasm + LLVM IR, and load O0 perf summary.

Differences vs the O2 PoC version:
  - BUILD_DIR and PERF_CSV point to O0 build/perf directories.
  - Features are extracted from -O0 compiled wasm, which has markedly different
    structural properties (more locals, more blocks, no DCE, unoptimized CF).
  - An additional set of O0-specific derived metrics is computed:
      local_bloat      = local_op_count / total_expr_count   (O0 redundancy proxy)
      block_density    = basic_block_count / total_expr_count
  - Perf data is optional; if perf/collect_perf_o0.sh has not been run yet,
    the perf_ratios field will be empty and the static-only prompt variant
    is still fully functional.

Outputs:
  work/features.json        per-program static features + buckets + perf ratios
  work/perf_summary.csv     flat table of wasm/native perf ratios (O0 wasm)
"""

from __future__ import annotations

import csv
import json
import re
import statistics
import subprocess
from collections import defaultdict
from pathlib import Path
from typing import Dict, List

from common import (
    BUILD_DIR,
    PERF_CSV,
    REPO_ROOT,
    WASM_OPT,
    WORK_DIR,
    Program,
    load_programs,
)

# raw perf event code -> human name (same mapping as O2 project)
EVENT_NAMES = {
    "r81d0": "all_loads_retired",
    "r82d0": "all_stores_retired",
    "r00c4": "branches_retired",
    "r01c4": "conditional_branches",
    "r1c0": "instructions_retired",
    "cpu-cycles": "cpu_cycles",
    "L1-icache-load-misses": "l1_icache_load_misses",
    "branch-misses": "branch_misses",
}

METRIC_RE = re.compile(r"^\s*\[?([A-Za-z_-]+)\]?\s*:\s*([0-9]+)\s*$")


def wasm_metrics(wasm: Path) -> Dict[str, int]:
    p = subprocess.run(
        [WASM_OPT, "--metrics", str(wasm), "-o", "/dev/null"],
        capture_output=True,
        text=True,
    )
    out: Dict[str, int] = {}
    for line in (p.stdout + "\n" + p.stderr).splitlines():
        m = METRIC_RE.match(line)
        if m:
            out[m.group(1)] = int(m.group(2))
    return out


def ir_counts(ll: Path) -> Dict[str, int]:
    if not ll.exists():
        return {"ir_define_count": 0, "ir_line_count": 0}
    defines = 0
    instr_like = 0
    for line in ll.read_text(encoding="utf-8", errors="ignore").splitlines():
        s = line.strip()
        if s.startswith("define "):
            defines += 1
        if s.startswith("%") and "=" in s:
            instr_like += 1
        elif s.startswith(("br ", "ret", "switch", "call", "store", "load")):
            instr_like += 1
    return {"ir_define_count": defines, "ir_line_count": instr_like}


def derive(metrics: Dict[str, int], irc: Dict[str, int]) -> Dict[str, float]:
    g = lambda k: float(metrics.get(k, 0))
    funcs = g("funcs") or 1.0
    total = g("total") or 1.0
    loops = g("Loop")
    blocks = g("Block")
    branches = g("Break") + g("Switch") + g("Select")
    calls = g("Call") + g("CallIndirect")
    mem = g("Load") + g("Store")
    local_ops = g("LocalGet") + g("LocalSet")
    compute = g("Binary") + g("Unary") + g("Const")
    return {
        "function_count": funcs,
        "total_expr_count": total,
        "loop_count": loops,
        "basic_block_count": blocks,
        "branch_count": branches,
        "call_count": calls,
        "mem_access_count": mem,
        "local_op_count": local_ops,
        "compute_instr_count": compute,
        "vars_count": g("vars"),
        "avg_func_size": total / funcs,
        "branch_density": branches / total,
        "call_density": calls / total,
        "loop_density": loops / total,
        "memory_access_density": mem / total,
        "compute_density": compute / total,
        # O0-specific metrics
        "local_bloat": local_ops / total,          # redundant local ops from O0
        "block_density": blocks / total,           # unmerged basic blocks from O0
        "ir_function_count": float(irc.get("ir_define_count", 0)),
        "ir_instruction_count": float(irc.get("ir_line_count", 0)),
    }


BUCKET_KEYS = [
    "function_count",
    "loop_count",
    "basic_block_count",
    "branch_density",
    "call_density",
    "memory_access_density",
    "compute_density",
    "avg_func_size",
    "local_bloat",   # O0-specific
    "block_density", # O0-specific
]


def bucketize(per_prog: Dict[str, Dict[str, float]]) -> Dict[str, Dict[str, str]]:
    """Assign low/medium/high by tercile across the cohort for each key."""
    buckets: Dict[str, Dict[str, str]] = defaultdict(dict)
    for key in BUCKET_KEYS:
        vals = sorted(d[key] for d in per_prog.values() if key in d)
        if len(vals) >= 3:
            lo = vals[len(vals) // 3]
            hi = vals[2 * len(vals) // 3]
        else:
            lo = hi = statistics.median(vals) if vals else 0.0
        for prog, d in per_prog.items():
            v = d.get(key, 0.0)
            if v <= lo:
                buckets[prog][key] = "low"
            elif v >= hi:
                buckets[prog][key] = "high"
            else:
                buckets[prog][key] = "medium"
    return buckets


def load_perf_ratios() -> Dict[str, Dict[str, float]]:
    """median(wasm-aot)/median(native) per event, per program, from O0 perf CSV."""
    if not PERF_CSV.exists():
        print(f"[info] O0 perf CSV not found ({PERF_CSV}); perf_ratios will be empty.")
        print("       Run perf/collect_perf_o0.sh first if you want static+perf prompts.")
        return {}
    values: Dict[str, Dict[str, Dict[str, List[float]]]] = defaultdict(
        lambda: defaultdict(lambda: defaultdict(list))
    )
    with PERF_CSV.open(newline="", encoding="utf-8") as f:
        for r in csv.DictReader(f):
            if r.get("status", "ok") != "ok":
                continue
            prog = r["program"].strip()
            mode = r["mode"].strip()
            ev = r["event"].strip()
            try:
                v = float(r["value"])
            except (ValueError, KeyError):
                continue
            values[prog][mode][ev].append(v)

    ratios: Dict[str, Dict[str, float]] = {}
    for prog, modes in values.items():
        native = modes.get("native", {})
        wasm = modes.get("wasm-aot", {}) or modes.get("wasm-jit", {})
        row: Dict[str, float] = {}
        for code, name in EVENT_NAMES.items():
            nv = native.get(code, [])
            wv = wasm.get(code, [])
            if nv and wv:
                nm = statistics.median(nv)
                wm = statistics.median(wv)
                if nm > 0:
                    row[f"ratio_{name}"] = round(wm / nm, 4)
        if row:
            ratios[prog] = row
    return ratios


def main() -> None:
    programs = load_programs()
    perf = load_perf_ratios()

    raw_feats: Dict[str, Dict[str, float]] = {}
    for prog in programs:
        if not prog.raw_wasm.exists():
            print(f"[warn] missing O0 wasm for {prog.name} — run s01_build_o0.py first")
            continue
        m = wasm_metrics(prog.raw_wasm)
        irc = ir_counts(prog.ll_file)
        raw_feats[prog.name] = derive(m, irc)

    buckets = bucketize(raw_feats)

    features: Dict[str, dict] = {}
    by_name = {p.name: p for p in programs}
    for name, feats in raw_feats.items():
        p = by_name[name]
        features[name] = {
            "program": name,
            "category": p.category,
            "note": p.note,
            "wasmer_aot_ratio": p.wasmer_aot_ratio,
            "wasmer_aot_wasm_ms": p.wasmer_aot_wasm_ms,
            "static_raw": {k: round(v, 4) for k, v in feats.items()},
            "static_bucket": buckets.get(name, {}),
            "perf_ratios": perf.get(name, {}),
        }

    out = WORK_DIR / "features.json"
    out.write_text(json.dumps(features, indent=2), encoding="utf-8")
    print(f"[ok] wrote {out} ({len(features)} programs)")

    perf_csv = WORK_DIR / "perf_summary.csv"
    perf_cols = [f"ratio_{n}" for n in EVENT_NAMES.values()]
    with perf_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["program"] + perf_cols)
        for name in features:
            pr = features[name]["perf_ratios"]
            w.writerow([name] + [pr.get(c, "") for c in perf_cols])
    print(f"[ok] wrote {perf_csv}")


if __name__ == "__main__":
    main()
