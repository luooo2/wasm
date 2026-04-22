#!/usr/bin/env python3
"""
Generate tracking tables for llvm direct-run benchmarks.

Outputs:
- data/results/llvm_direct_tracking.csv
- data/results/llvm_direct_runnable.csv
"""

import argparse
import csv
from pathlib import Path
from typing import Dict, List


def read_csv(path: Path) -> List[Dict[str, str]]:
    if not path.exists():
        return []
    with path.open("r", encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--catalog", default="data/results/llvm_c_catalog.csv")
    ap.add_argument("--build-report", default="data/build/llvm_direct/build_report_llvm_direct.csv")
    ap.add_argument("--out-tracking", default="data/results/llvm_direct_tracking.csv")
    ap.add_argument("--out-runnable", default="data/results/llvm_direct_runnable.csv")
    args = ap.parse_args()

    catalog = read_csv(Path(args.catalog))
    report_rows = read_csv(Path(args.build_report))
    rep = {r["program"]: r for r in report_rows}

    tracking: List[Dict[str, str]] = []
    runnable: List[Dict[str, str]] = []

    for c in catalog:
        if c.get("class") != "direct-run":
            continue
        program = c["program"]
        rr = rep.get(program, {})
        n_ok = int(rr.get("native_ok", "0") or "0")
        w_ok = int(rr.get("wasm_ok", "0") or "0")
        runnable_now = int(n_ok == 1 and w_ok == 1)

        src = c.get("relative_path", "")
        native_err = rr.get("native_error", "")
        wasm_err = rr.get("wasm_error", "")
        err = f"{native_err}\n{wasm_err}"

        exclude_platform_specific = int(
            "aarch64" in src.lower() or "__aarch64_cpu_features" in err or "RUNTIME_INIT" in err
        )

        needs_source_patch = int(
            ("type specifier missing" in err)
            and ("implicit int" in err)
            and ("dhrystone/dry.c" in src.lower() or "dry.c" in src.lower())
        )

        needs_build_tweak = int(
            runnable_now == 0
            and exclude_platform_specific == 0
            and needs_source_patch == 0
        )

        row = {
            "program": program,
            "class": c.get("class", ""),
            "relative_path": src,
            "runnable_now": str(runnable_now),
            "needs_build_tweak": str(needs_build_tweak),
            "needs_source_patch": str(needs_source_patch),
            "exclude_platform_specific": str(exclude_platform_specific),
            "native_ok": str(n_ok),
            "wasm_ok": str(w_ok),
            "native_error": native_err,
            "wasm_error": wasm_err,
            "run_args_template": "",
            "input_profile": "none",
            "notes": "",
        }
        tracking.append(row)
        if runnable_now == 1:
            runnable.append(
                {
                    "program": program,
                    "relative_path": src,
                    "run_args_template": "",
                    "input_profile": "none",
                    "class": "direct-run",
                }
            )

    out_tracking = Path(args.out_tracking)
    out_runnable = Path(args.out_runnable)
    out_tracking.parent.mkdir(parents=True, exist_ok=True)

    with out_tracking.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(
            f,
            fieldnames=[
                "program",
                "class",
                "relative_path",
                "runnable_now",
                "needs_build_tweak",
                "needs_source_patch",
                "exclude_platform_specific",
                "native_ok",
                "wasm_ok",
                "native_error",
                "wasm_error",
                "run_args_template",
                "input_profile",
                "notes",
            ],
        )
        w.writeheader()
        w.writerows(tracking)

    with out_runnable.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(
            f,
            fieldnames=["program", "relative_path", "run_args_template", "input_profile", "class"],
        )
        w.writeheader()
        w.writerows(runnable)

    print(f"tracking rows: {len(tracking)}")
    print(f"runnable rows: {len(runnable)}")
    print(f"tracking: {out_tracking}")
    print(f"runnable: {out_runnable}")


if __name__ == "__main__":
    main()

