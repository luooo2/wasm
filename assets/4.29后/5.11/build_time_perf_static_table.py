#!/usr/bin/env python3
"""
Build main analysis table: all numeric static features + perf ratios + internal time ratio.

Reads (repo-relative defaults):
  - assets/4.29后/static_perf_join_llvm_direct.csv
  - data/results/labels_llvm_direct_from_runnable.csv

Writes under this script's directory (assets/4.29后/5.11/):
  - main_table_time_perf_static.csv
  - column_groups.json
  - spearman_static_vs_y_time_internal.csv
  - spearman_perf_ratio_vs_y_time_internal.csv
  - README.md
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import List, Sequence

import numpy as np
import pandas as pd
from scipy.stats import spearmanr


def repo_root_from_script() -> Path:
    # .../wasm/assets/4.29后/5.11/this.py -> parents[3] == wasm
    return Path(__file__).resolve().parents[3]


def labels_to_long(labels: pd.DataFrame) -> pd.DataFrame:
    rows = []
    for _, r in labels.iterrows():
        p = str(r.get("program", "")).strip()
        if not p:
            continue
        if int(r.get("jit_ok", 0) or 0) == 1 and pd.notna(r.get("ratio_jit_over_native_internal")):
            rows.append(
                {
                    "program": p,
                    "mode": "wasm-jit",
                    "y_time_internal_ratio": float(r["ratio_jit_over_native_internal"]),
                }
            )
        if int(r.get("aot_ok", 0) or 0) == 1 and pd.notna(r.get("ratio_aot_over_native_internal")):
            rows.append(
                {
                    "program": p,
                    "mode": "wasm-aot",
                    "y_time_internal_ratio": float(r["ratio_aot_over_native_internal"]),
                }
            )
    return pd.DataFrame(rows)


def static_numeric_columns(df: pd.DataFrame) -> List[str]:
    exclude = {
        "program",
        "mode",
        "source_path",
        "ir_path",
        "opt_loop_note",
    }
    bad_prefixes = ("native_perf_", "perf_", "ratio_")
    out: List[str] = []
    n = len(df)
    for c in df.columns:
        if c in exclude or c == "y_time_internal_ratio":
            continue
        if any(c.startswith(p) for p in bad_prefixes):
            continue
        s = pd.to_numeric(df[c], errors="coerce")
        if s.notna().sum() >= max(4, int(0.95 * n)):
            out.append(c)
    return out


def perf_ratio_columns(df: pd.DataFrame) -> List[str]:
    return sorted([c for c in df.columns if c.startswith("ratio_") and c != "y_time_internal_ratio"])


def spearman_table(x_cols: Sequence[str], y: pd.Series, df: pd.DataFrame) -> pd.DataFrame:
    rows = []
    yv = pd.to_numeric(y, errors="coerce")
    for c in x_cols:
        if c not in df.columns:
            continue
        xv = pd.to_numeric(df[c], errors="coerce")
        pair = pd.DataFrame({"x": xv, "y": yv}).dropna()
        n = len(pair)
        if n < 4 or pair["x"].nunique() < 2:
            continue
        rho, p = spearmanr(pair["x"], pair["y"])
        if np.isnan(rho):
            continue
        rows.append(
            {
                "column": c,
                "n": n,
                "spearman_rho": float(rho),
                "p_value": float(p),
                "abs_rho": float(abs(rho)),
            }
        )
    out = pd.DataFrame(rows)
    if out.empty:
        return pd.DataFrame(columns=["column", "n", "spearman_rho", "p_value", "abs_rho"])
    return out.sort_values("abs_rho", ascending=False).reset_index(drop=True)


def main() -> None:
    root = repo_root_from_script()
    out_dir = Path(__file__).resolve().parent
    out_dir.mkdir(parents=True, exist_ok=True)

    ap = argparse.ArgumentParser()
    ap.add_argument(
        "--join-csv",
        default=str(root / "assets/4.29后/static_perf_join_llvm_direct.csv"),
    )
    ap.add_argument(
        "--labels-csv",
        default=str(root / "data/results/labels_llvm_direct_from_runnable.csv"),
    )
    ap.add_argument("--out-dir", default=str(out_dir))
    args = ap.parse_args()

    join_path = Path(args.join_csv)
    labels_path = Path(args.labels_csv)
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    j = pd.read_csv(join_path)
    lab = pd.read_csv(labels_path)
    long_lab = labels_to_long(lab)

    main = j.merge(long_lab, on=["program", "mode"], how="inner")
    if main.empty:
        raise RuntimeError("Merge produced empty table; check program/mode alignment.")

    static_cols = static_numeric_columns(main)
    ratio_cols = perf_ratio_columns(main)

    groups = {
        "meta": ["program", "mode", "source_path", "ir_path"],
        "y_main": ["y_time_internal_ratio"],
        "x_static_all_numeric": static_cols,
        "y_perf_ratios": ratio_cols,
        "native_perf_medians": [c for c in main.columns if c.startswith("native_perf_")],
        "wasm_perf_medians": [c for c in main.columns if c.startswith("perf_") and not c.startswith("perf_medians")],
    }
    (out_dir / "column_groups.json").write_text(json.dumps(groups, indent=2, ensure_ascii=False), encoding="utf-8")

    out_csv = out_dir / "main_table_time_perf_static.csv"
    main.to_csv(out_csv, index=False)

    y = main["y_time_internal_ratio"]
    tab_static = spearman_table(static_cols, y, main)
    tab_static.to_csv(out_dir / "spearman_static_vs_y_time_internal.csv", index=False)

    tab_perf = spearman_table(ratio_cols, y, main)
    tab_perf.to_csv(out_dir / "spearman_perf_ratio_vs_y_time_internal.csv", index=False)

    # By mode (same Spearman if ranks identical — still useful for audit)
    by_mode_rows = []
    for mode in sorted(main["mode"].dropna().unique()):
        sub = main[main["mode"] == mode]
        for c in static_cols:
            t = spearman_table([c], sub["y_time_internal_ratio"], sub)
            if not t.empty:
                row = t.iloc[0].to_dict()
                row["mode"] = mode
                by_mode_rows.append(row)
    pd.DataFrame(by_mode_rows).to_csv(out_dir / "spearman_static_vs_y_time_by_mode.csv", index=False)

    try:
        jp = str(join_path.relative_to(root))
        lp = str(labels_path.relative_to(root))
    except ValueError:
        jp, lp = str(join_path), str(labels_path)

    readme = f"""# 5.11 主表与桥接分析（内部时间比为主 Y）

## 输入

- 静态 + perf 比值: `{jp}`
- 内部时间比标签: `{lp}`

## 主 Y

- `y_time_internal_ratio` = `ratio_jit_over_native_internal`（mode=`wasm-jit`）或 `ratio_aot_over_native_internal`（mode=`wasm-aot`）

## X（全部静态数值特征）

见 `column_groups.json` 中 `x_static_all_numeric`（**非**此前 8 特征子集）。`opt_loop_note` 为文本，未纳入 X 相关表。

## 产出

| 文件 | 说明 |
|------|------|
| `main_table_time_perf_static.csv` | 每行 program×mode；含全部静态列、perf 中位数、ratio_*、**y_time_internal_ratio** |
| `column_groups.json` | 列分组（meta / y_main / x_static / y_perf_ratios / raw perf medians） |
| `spearman_static_vs_y_time_internal.csv` | 各静态特征 vs 内部时间比的 Spearman（pooled 52 行） |
| `spearman_perf_ratio_vs_y_time_internal.csv` | 各 perf ratio vs 内部时间比（桥接层） |
| `spearman_static_vs_y_time_by_mode.csv` | 按 mode 单列 Spearman（便于核对） |

## 下一步（建议）

1. 以 `y_time_internal_ratio` 为因变量、**全部** `x_static_*` 做弹性网络或逐步回归 + 与 OLS/RLM 对照（注意 n=52、p 较大 → 强正则或先降维）。
2. 用 `spearman_perf_ratio_vs_y_time_internal.csv` 选出与时间最相关的 2–3 个 perf 比值，再报告静态特征如何通过它们与时间关联。
"""
    (out_dir / "README.md").write_text(readme, encoding="utf-8")

    print(f"rows={len(main)} cols={len(main.columns)}")
    print(f"wrote {out_csv}")


if __name__ == "__main__":
    main()
