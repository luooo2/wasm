#!/usr/bin/env python3
"""
extract_polybench_features.py

Extract V2 static features for selected PolyBench kernels.
Uses extract_one() from extract_features.py so both microbench + polybench
share identical V2 feature logic.
"""

import csv
import sys
from pathlib import Path

# Allow importing from src/
sys.path.insert(0, str(Path(__file__).parent))
from extract_features import extract_one

ROOT = Path(__file__).parent.parent

KERNEL_MAP = {
    "poly_gemm": "data/polybench-c-4.2.1-beta/linear-algebra/blas/gemm/gemm.c",
    "poly_gemver": "data/polybench-c-4.2.1-beta/linear-algebra/blas/gemver/gemver.c",
    "poly_gesummv": "data/polybench-c-4.2.1-beta/linear-algebra/blas/gesummv/gesummv.c",
    "poly_2mm": "data/polybench-c-4.2.1-beta/linear-algebra/kernels/2mm/2mm.c",
    "poly_atax": "data/polybench-c-4.2.1-beta/linear-algebra/kernels/atax/atax.c",
    "poly_jacobi_1d": "data/polybench-c-4.2.1-beta/stencils/jacobi-1d/jacobi-1d.c",
    "poly_jacobi_2d": "data/polybench-c-4.2.1-beta/stencils/jacobi-2d/jacobi-2d.c",
    "poly_floyd_warshall": "data/polybench-c-4.2.1-beta/medley/floyd-warshall/floyd-warshall.c",
}

FIELDNAMES = [
    "program",
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


def main() -> None:
    ir_dir = ROOT / "data" / "build"
    out_csv = ROOT / "data" / "results" / "features_polybench.csv"
    out_csv.parent.mkdir(parents=True, exist_ok=True)

    rows = []
    for stem, rel_c in KERNEL_MAP.items():
        c_path = ROOT / rel_c
        ll_path = ir_dir / f"{stem}.ll"

        if not c_path.exists():
            print(f"WARNING: source not found: {c_path}")
            continue
        if not ll_path.exists():
            print(f"WARNING: IR not found: {ll_path}")

        row = extract_one(c_path, ll_path)
        row["program"] = stem
        rows.append(row)
        print(f"extracted {stem}")

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=FIELDNAMES)
        writer.writeheader()
        writer.writerows(rows)

    print(f"\nextracted {len(rows)} kernels -> {out_csv}")


if __name__ == "__main__":
    main()
