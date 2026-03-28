#!/usr/bin/env python3
"""
Build dataset_combined_v2.csv by merging V2 features with benchmark labels.

Inputs:
- data/results/features.csv
- data/results/features_polybench.csv
- data/results/labels_34_final.csv
- data/results/labels_polybench.csv

Output:
- data/results/dataset_combined_v2.csv
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

LABEL_FILES = [
    RES / "labels_34_final.csv",
    RES / "labels_polybench.csv",
]

LABEL_COLS = [
    "program",
    "native_median_ms",
    "wasm_median_ms",
    "ratio_wasm_over_native",
    "label",
]

V2_FEATURE_COLS = [
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

OUT_FILE = RES / "dataset_combined_v2.csv"


def read_rows(path: Path) -> List[Dict[str, str]]:
    with path.open("r", encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def main() -> None:
    all_features: List[Dict[str, str]] = []
    for p in FEATURE_FILES:
        rows = read_rows(p)
        all_features.extend(rows)
        print(f"features: {p.name} -> {len(rows)}")

    all_labels: List[Dict[str, str]] = []
    for p in LABEL_FILES:
        rows = read_rows(p)
        all_labels.extend(rows)
        print(f"labels:   {p.name} -> {len(rows)}")

    feat_map = {r["program"]: r for r in all_features}
    lab_map = {r["program"]: r for r in all_labels}

    programs = sorted(set(feat_map.keys()) & set(lab_map.keys()))
    miss_feat = sorted(set(lab_map.keys()) - set(feat_map.keys()))
    miss_lab = sorted(set(feat_map.keys()) - set(lab_map.keys()))

    if miss_feat:
        print(f"WARNING missing features for {len(miss_feat)} programs: {miss_feat}")
    if miss_lab:
        print(f"WARNING missing labels for {len(miss_lab)} programs: {miss_lab}")

    out_rows: List[Dict[str, str]] = []
    for prog in programs:
        frow = feat_map[prog]
        lrow = lab_map[prog]
        row: Dict[str, str] = {"program": prog}

        for c in V2_FEATURE_COLS:
            row[c] = frow.get(c, "0")

        for c in LABEL_COLS[1:]:
            row[c] = lrow.get(c, "")

        out_rows.append(row)

    OUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = ["program", *V2_FEATURE_COLS, *LABEL_COLS[1:]]
    with OUT_FILE.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames)
        w.writeheader()
        w.writerows(out_rows)

    print(f"\nmerged rows: {len(out_rows)}")
    print(f"output: {OUT_FILE}")


if __name__ == "__main__":
    main()
