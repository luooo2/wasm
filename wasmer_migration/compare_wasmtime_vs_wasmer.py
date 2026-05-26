#!/usr/bin/env python3
"""
Quick wasmtime vs wasmer (cranelift) diff for the LLVM direct-run subset.

Inputs (defaults):
  - data/results/labels_llvm_direct_from_runnable.csv          (wasmtime)
  - data/results/wasmer/labels_llvm_direct_from_runnable_wasmer_cranelift.csv

Output:
  - data/results/wasmer/runtime_comparison_summary.csv         (per-program)
  - data/results/wasmer/runtime_comparison_report.md           (high-level)

The report contains:
  * Per-mode (jit, aot) label confusion matrices (wasmtime x wasmer).
  * Per-mode aggregate stats of wasm/native median ratios:
        wasmtime median, wasmer median, delta, |delta|/wasmtime.
  * Per-program side-by-side ratios and label changes (CSV).
"""

from __future__ import annotations

import argparse
import csv
import statistics
from pathlib import Path
from typing import Dict, List, Tuple

LABELS = ["wasm-better", "similar", "native-better", "run-failed"]


def load(path: Path) -> Dict[str, Dict[str, str]]:
    rows = list(csv.DictReader(path.open("r", encoding="utf-8", newline="")))
    return {r["program"]: r for r in rows}


def fnum(x: str) -> float:
    try:
        return float(x)
    except (TypeError, ValueError):
        return 0.0


def confusion(rows_t: Dict[str, Dict[str, str]],
              rows_w: Dict[str, Dict[str, str]],
              key: str) -> List[List[int]]:
    mat = [[0 for _ in LABELS] for _ in LABELS]
    for prog, rt in rows_t.items():
        if prog not in rows_w:
            continue
        lt = rt.get(key, "")
        lw = rows_w[prog].get(key, "")
        try:
            i = LABELS.index(lt)
            j = LABELS.index(lw)
        except ValueError:
            continue
        mat[i][j] += 1
    return mat


def fmt_matrix(mat: List[List[int]]) -> str:
    header = "wasmtime\\\\wasmer | " + " | ".join(LABELS) + " | total"
    sep = "|".join(["---"] * (len(LABELS) + 2))
    lines = [f"| {header} |", f"|{sep}|"]
    for i, row_label in enumerate(LABELS):
        total = sum(mat[i])
        cells = " | ".join(str(x) for x in mat[i])
        lines.append(f"| {row_label} | {cells} | {total} |")
    col_totals = [sum(mat[i][j] for i in range(len(LABELS))) for j in range(len(LABELS))]
    grand = sum(col_totals)
    lines.append(f"| total | " + " | ".join(str(x) for x in col_totals) + f" | {grand} |")
    return "\n".join(lines)


def summarize_ratio_delta(
    rows_t: Dict[str, Dict[str, str]],
    rows_w: Dict[str, Dict[str, str]],
    mode: str,
) -> Tuple[Dict[str, float], List[Dict[str, object]]]:
    key_ok_t = f"{mode}_ok"
    key_ok_w = f"{mode}_ok"
    key_ratio = f"ratio_{mode}_over_native_internal"
    key_label = f"{mode}_label"

    ratios_t: List[float] = []
    ratios_w: List[float] = []
    deltas_abs: List[float] = []
    deltas_rel: List[float] = []
    per_prog_rows: List[Dict[str, object]] = []
    for prog, rt in rows_t.items():
        if prog not in rows_w:
            continue
        rw = rows_w[prog]
        ok_t = rt.get(key_ok_t, "0") == "1"
        ok_w = rw.get(key_ok_w, "0") == "1"
        ratio_t = fnum(rt.get(key_ratio, "0"))
        ratio_w = fnum(rw.get(key_ratio, "0"))
        label_t = rt.get(key_label, "")
        label_w = rw.get(key_label, "")
        if ok_t and ok_w:
            ratios_t.append(ratio_t)
            ratios_w.append(ratio_w)
            deltas_abs.append(ratio_w - ratio_t)
            if ratio_t > 0:
                deltas_rel.append(abs(ratio_w - ratio_t) / ratio_t)

        per_prog_rows.append(
            {
                "program": prog,
                "mode": mode,
                f"wasmtime_{key_ratio}": ratio_t,
                f"wasmer_{key_ratio}": ratio_w,
                f"delta_{mode}": round(ratio_w - ratio_t, 6),
                f"rel_delta_{mode}": round(abs(ratio_w - ratio_t) / ratio_t, 6) if ratio_t > 0 else 0.0,
                "wasmtime_label": label_t,
                "wasmer_label": label_w,
                "label_changed": int(label_t != label_w),
            }
        )

    def med(xs: List[float]) -> float:
        return statistics.median(xs) if xs else 0.0

    summary = {
        "n_pairs": float(len(ratios_t)),
        "wasmtime_median_ratio": round(med(ratios_t), 4),
        "wasmer_median_ratio": round(med(ratios_w), 4),
        "median_abs_delta": round(med([abs(d) for d in deltas_abs]), 4),
        "median_rel_delta": round(med(deltas_rel), 4),
        "frac_label_changed": (
            round(sum(1 for row in per_prog_rows if row["label_changed"]) / max(len(per_prog_rows), 1), 4)
        ),
    }
    return summary, per_prog_rows


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument(
        "--wasmtime-csv",
        default="data/results/labels_llvm_direct_from_runnable.csv",
    )
    ap.add_argument(
        "--wasmer-csv",
        default="data/results/wasmer/labels_llvm_direct_from_runnable_wasmer_cranelift.csv",
    )
    ap.add_argument(
        "--out-csv",
        default="data/results/wasmer/runtime_comparison_summary.csv",
    )
    ap.add_argument(
        "--out-md",
        default="data/results/wasmer/runtime_comparison_report.md",
    )
    args = ap.parse_args()

    t_rows = load(Path(args.wasmtime_csv))
    w_rows = load(Path(args.wasmer_csv))

    common = sorted(set(t_rows.keys()) & set(w_rows.keys()))
    only_t = sorted(set(t_rows.keys()) - set(w_rows.keys()))
    only_w = sorted(set(w_rows.keys()) - set(t_rows.keys()))

    jit_summary, jit_rows = summarize_ratio_delta(t_rows, w_rows, "jit")
    aot_summary, aot_rows = summarize_ratio_delta(t_rows, w_rows, "aot")

    jit_conf = confusion(t_rows, w_rows, "jit_label")
    aot_conf = confusion(t_rows, w_rows, "aot_label")

    out_csv = Path(args.out_csv)
    out_md = Path(args.out_md)
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    out_md.parent.mkdir(parents=True, exist_ok=True)

    per_prog: Dict[str, Dict[str, object]] = {}
    for r in jit_rows + aot_rows:
        prog = r["program"]
        per_prog.setdefault(prog, {"program": prog})
        per_prog[prog].update({k: v for k, v in r.items() if k != "program"})

    fieldnames = [
        "program",
        "wasmtime_ratio_jit_over_native_internal",
        "wasmer_ratio_jit_over_native_internal",
        "delta_jit",
        "rel_delta_jit",
        "wasmtime_ratio_aot_over_native_internal",
        "wasmer_ratio_aot_over_native_internal",
        "delta_aot",
        "rel_delta_aot",
        "jit_wasmtime_label",
        "jit_wasmer_label",
        "jit_label_changed",
        "aot_wasmtime_label",
        "aot_wasmer_label",
        "aot_label_changed",
    ]

    with out_csv.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(fieldnames)
        for prog in common:
            jr = next((r for r in jit_rows if r["program"] == prog), {})
            ar = next((r for r in aot_rows if r["program"] == prog), {})
            w.writerow(
                [
                    prog,
                    jr.get("wasmtime_ratio_jit_over_native_internal", ""),
                    jr.get("wasmer_ratio_jit_over_native_internal", ""),
                    jr.get("delta_jit", ""),
                    jr.get("rel_delta_jit", ""),
                    ar.get("wasmtime_ratio_aot_over_native_internal", ""),
                    ar.get("wasmer_ratio_aot_over_native_internal", ""),
                    ar.get("delta_aot", ""),
                    ar.get("rel_delta_aot", ""),
                    jr.get("wasmtime_label", ""),
                    jr.get("wasmer_label", ""),
                    jr.get("label_changed", ""),
                    ar.get("wasmtime_label", ""),
                    ar.get("wasmer_label", ""),
                    ar.get("label_changed", ""),
                ]
            )

    with out_md.open("w", encoding="utf-8") as f:
        f.write("# wasmtime vs wasmer (cranelift) - LLVM direct-run subset\n\n")
        f.write(f"- Common programs: **{len(common)}**\n")
        if only_t:
            f.write(f"- Only in wasmtime: {only_t}\n")
        if only_w:
            f.write(f"- Only in wasmer:   {only_w}\n")
        f.write("\n## JIT mode\n\n")
        f.write("**Aggregate** (over programs ok in both runtimes):\n\n")
        for k, v in jit_summary.items():
            f.write(f"- `{k}` = {v}\n")
        f.write("\n**Confusion matrix (jit_label, rows=wasmtime, cols=wasmer):**\n\n")
        f.write(fmt_matrix(jit_conf) + "\n\n")
        f.write("## AOT mode\n\n")
        f.write("**Aggregate** (over programs ok in both runtimes):\n\n")
        for k, v in aot_summary.items():
            f.write(f"- `{k}` = {v}\n")
        f.write("\n**Confusion matrix (aot_label, rows=wasmtime, cols=wasmer):**\n\n")
        f.write(fmt_matrix(aot_conf) + "\n\n")
        f.write("## Per-program detail\n\n")
        f.write(f"See `{out_csv}`.\n")

    print(f"summary written: {out_csv}")
    print(f"report  written: {out_md}")
    print("\n--- JIT summary ---")
    for k, v in jit_summary.items():
        print(f"  {k}: {v}")
    print("\n--- AOT summary ---")
    for k, v in aot_summary.items():
        print(f"  {k}: {v}")
    print("\n--- JIT confusion ---")
    print(fmt_matrix(jit_conf))
    print("\n--- AOT confusion ---")
    print(fmt_matrix(aot_conf))


if __name__ == "__main__":
    main()
