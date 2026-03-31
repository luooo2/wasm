#!/usr/bin/env python3
"""
Build dataset_all.csv by merging:
- V2 features (micro + polybench)
- JIT labels
- AOT labels
"""

import csv
from pathlib import Path
from typing import Dict, List

ROOT = Path(__file__).parent.parent
RES = ROOT / "data" / "results"

FEATURE_FILES = [
    RES / "features.csv",
    RES / "features_polybench.csv",
]

LABEL_JIT = RES / "labels_all_jit_30.csv"
LABEL_AOT = RES / "labels_all_aot_30.csv"
OUT = RES / "dataset_all.csv"

FEATURE_COLS = [
    "ir_instruction_count",
    "basic_block_count",
    "compute_density",
    "memory_access_density",
    "load_count",
    "store_count",
    "branch_instr_count",
    "call_instr_count",
    "max_loop_depth",
    "hostcall_count",
    "hostcall_density",
    "time_call_count",
    "alloc_call_count",
    "avg_bb_size",
    "compute_to_memory_ratio",
    "load_store_ratio",
    "call_to_bb_ratio",
    "hostcall_per_bb",
]


def read_rows(path: Path) -> List[Dict[str, str]]:
    with path.open("r", encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def load_features() -> Dict[str, Dict[str, str]]:
    feat_map: Dict[str, Dict[str, str]] = {}
    for path in FEATURE_FILES:
        rows = read_rows(path)
        for r in rows:
            feat_map[r["program"]] = r
        print(f"features loaded: {path.name} -> {len(rows)}")
    return feat_map


def index_labels(path: Path) -> Dict[str, Dict[str, str]]:
    rows = read_rows(path)
    print(f"labels loaded:   {path.name} -> {len(rows)}")
    return {r["program"]: r for r in rows}


def main() -> None:
    feat_map = load_features()
    jit_map = index_labels(LABEL_JIT)
    aot_map = index_labels(LABEL_AOT)

    programs = sorted(set(feat_map) & set(jit_map) & set(aot_map))
    print(f"intersection programs: {len(programs)}")

    OUT.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = [
        "program",
        *FEATURE_COLS,
        "native_median_ms_jit",
        "wasm_median_ms_jit",
        "ratio_wasm_over_native_jit",
        "label_jit",
        "native_median_ms_aot",
        "wasm_median_ms_aot",
        "ratio_wasm_over_native_aot",
        "label_aot",
        "ratio_delta_aot_minus_jit",
    ]

    out_rows: List[Dict[str, str]] = []
    for p in programs:
        f = feat_map[p]
        j = jit_map[p]
        a = aot_map[p]
        rj = float(j.get("ratio_wasm_over_native", "0") or 0.0)
        ra = float(a.get("ratio_wasm_over_native", "0") or 0.0)

        row: Dict[str, str] = {"program": p}
        for c in FEATURE_COLS:
            row[c] = f.get(c, "0")
        row["native_median_ms_jit"] = j.get("native_median_ms", "")
        row["wasm_median_ms_jit"] = j.get("wasm_median_ms", "")
        row["ratio_wasm_over_native_jit"] = j.get("ratio_wasm_over_native", "")
        row["label_jit"] = j.get("label", "")
        row["native_median_ms_aot"] = a.get("native_median_ms", "")
        row["wasm_median_ms_aot"] = a.get("wasm_median_ms", "")
        row["ratio_wasm_over_native_aot"] = a.get("ratio_wasm_over_native", "")
        row["label_aot"] = a.get("label", "")
        row["ratio_delta_aot_minus_jit"] = f"{(ra - rj):.6f}"
        out_rows.append(row)

    with OUT.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames)
        w.writeheader()
        w.writerows(out_rows)

    print(f"wrote rows: {len(out_rows)}")
    print(f"output: {OUT}")


if __name__ == "__main__":
    main()

