#!/usr/bin/env python3
"""
One-shot analysis for static-vs-perf association.

Outputs (under --out-dir):
  1) anomaly_report.csv / anomaly_report.md
  2) spearman_table.csv
  3) scatter plots for top relations
  4) feature_reduction_suggestions.csv / feature_reduction_suggestions.md
"""

from __future__ import annotations

import argparse
from pathlib import Path
from typing import Dict, List, Sequence, Tuple

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy.stats import spearmanr


DEFAULT_X_FEATURES = [
    "ir_instruction_count",
    "basic_block_count",
    "avg_bb_size",
    "avg_bb_out_degree",
    "max_loop_depth",
    "branch_instr_count",
    "branch_density",
    "compute_instr_count",
    "compute_density",
    "memory_instr_count",
    "memory_access_density",
    "compute_to_memory_ratio",
    "load_store_ratio",
    "call_instr_count",
    "hostcall_density",
]

DEFAULT_Y_METRICS = [
    "ratio_instructions_retired_over_native",
    "ratio_branches_retired_over_native",
    "ratio_conditional_branches_over_native",
    "ratio_all_loads_retired_over_native",
    "ratio_all_stores_retired_over_native",
    "ratio_cpu_cycles_over_native",
    "ratio_L1_icache_load_misses_over_native",
    "ratio_branch_misses_over_native",
]


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    ap = argparse.ArgumentParser()
    ap.add_argument(
        "--input-csv",
        default=str(script_dir / "static_perf_join_llvm_direct.csv"),
        help="Joined static+perf table from extract_static_features.py",
    )
    ap.add_argument(
        "--out-dir",
        default=str(script_dir),
        help="Output directory for all reports and figures",
    )
    ap.add_argument("--corr-threshold", type=float, default=0.85, help="Feature pair high-corr threshold")
    ap.add_argument("--vif-threshold", type=float, default=10.0, help="VIF warning threshold")
    ap.add_argument("--top-k", type=int, default=9, help="Top abs(spearman) pairs for scatter plots")
    ap.add_argument(
        "--iqr-k",
        type=float,
        default=3.0,
        help="Outlier sensitivity for ratio columns; larger is stricter",
    )
    return ap.parse_args()


def ensure_numeric(df: pd.DataFrame, cols: Sequence[str]) -> pd.DataFrame:
    out = df.copy()
    for c in cols:
        if c in out.columns:
            out[c] = pd.to_numeric(out[c], errors="coerce")
    return out


def detect_anomalies(df: pd.DataFrame, ratio_cols: Sequence[str], iqr_k: float) -> pd.DataFrame:
    rows: List[Dict[str, object]] = []
    for col in ratio_cols:
        if col not in df.columns:
            continue
        s = pd.to_numeric(df[col], errors="coerce").dropna()
        if s.empty:
            continue
        q1, q3 = np.percentile(s, [25, 75])
        iqr = q3 - q1
        low = q1 - iqr_k * iqr
        high = q3 + iqr_k * iqr
        for idx, val in df[col].items():
            if pd.isna(val):
                continue
            reason = []
            if val <= 0:
                reason.append("non_positive_ratio")
            if val < low:
                reason.append("below_iqr_bound")
            if val > high:
                reason.append("above_iqr_bound")
            if val > 10:
                reason.append("ratio_gt_10")
            if reason:
                rows.append(
                    {
                        "program": df.at[idx, "program"],
                        "mode": df.at[idx, "mode"],
                        "metric": col,
                        "value": float(val),
                        "q1": float(q1),
                        "q3": float(q3),
                        "iqr": float(iqr),
                        "lower_bound": float(low),
                        "upper_bound": float(high),
                        "reason": ";".join(reason),
                    }
                )
    return pd.DataFrame(rows).sort_values(["metric", "value"], ascending=[True, False])


def spearman_table(df: pd.DataFrame, x_cols: Sequence[str], y_cols: Sequence[str]) -> pd.DataFrame:
    rows: List[Dict[str, object]] = []
    for x in x_cols:
        if x not in df.columns:
            continue
        for y in y_cols:
            if y not in df.columns:
                continue
            pair = df[[x, y]].dropna()
            n = len(pair)
            if n < 4:
                continue
            rho, pval = spearmanr(pair[x], pair[y])
            rows.append(
                {
                    "x_feature": x,
                    "y_metric": y,
                    "n": n,
                    "spearman_rho": float(rho),
                    "p_value": float(pval),
                    "abs_rho": float(abs(rho)),
                    "direction": "positive" if rho > 0 else "negative",
                }
            )
    out = pd.DataFrame(rows)
    if out.empty:
        return out
    return out.sort_values(["abs_rho", "p_value"], ascending=[False, True]).reset_index(drop=True)


def _vif_for_matrix(x: np.ndarray) -> List[float]:
    # x shape: [n_samples, n_features], no intercept
    # VIF_j = 1/(1-R_j^2), where R_j^2 from regressing x_j on x_-j.
    out: List[float] = []
    n_features = x.shape[1]
    for j in range(n_features):
        y = x[:, j]
        x_other = np.delete(x, j, axis=1)
        if x_other.shape[1] == 0:
            out.append(1.0)
            continue
        x_design = np.column_stack([np.ones(len(x_other)), x_other])
        coef, *_ = np.linalg.lstsq(x_design, y, rcond=None)
        y_hat = x_design @ coef
        ss_res = float(np.sum((y - y_hat) ** 2))
        ss_tot = float(np.sum((y - np.mean(y)) ** 2))
        r2 = 0.0 if ss_tot == 0 else max(0.0, min(1.0, 1.0 - ss_res / ss_tot))
        vif = np.inf if r2 >= 0.999999 else 1.0 / (1.0 - r2)
        out.append(vif)
    return out


def feature_reduction_suggestions(
    df: pd.DataFrame,
    x_cols: Sequence[str],
    y_cols: Sequence[str],
    corr_threshold: float,
    vif_threshold: float,
) -> pd.DataFrame:
    data = df[list(x_cols) + list(y_cols)].copy()
    data = data.replace([np.inf, -np.inf], np.nan)
    data = data.dropna(subset=x_cols)
    if data.empty:
        return pd.DataFrame()

    x_df = data[list(x_cols)]
    y_df = data[list(y_cols)] if y_cols else pd.DataFrame(index=x_df.index)

    pair_rows: List[Dict[str, object]] = []
    corr = x_df.corr(method="spearman")
    cols = list(x_df.columns)
    for i in range(len(cols)):
        for j in range(i + 1, len(cols)):
            a, b = cols[i], cols[j]
            c = corr.loc[a, b]
            if pd.isna(c) or abs(c) < corr_threshold:
                continue
            a_y = y_df.corrwith(x_df[a], method="spearman").abs().mean() if not y_df.empty else np.nan
            b_y = y_df.corrwith(x_df[b], method="spearman").abs().mean() if not y_df.empty else np.nan
            keep = a if (a_y >= b_y) else b
            drop = b if keep == a else a
            pair_rows.append(
                {
                    "kind": "high_corr_pair",
                    "feature_a": a,
                    "feature_b": b,
                    "pair_spearman_corr": float(c),
                    "mean_abs_corr_to_y_a": float(a_y),
                    "mean_abs_corr_to_y_b": float(b_y),
                    "suggest_keep": keep,
                    "suggest_drop": drop,
                    "reason": f"|rho| >= {corr_threshold}",
                }
            )

    # VIF table
    x_numeric = x_df.apply(pd.to_numeric, errors="coerce").dropna()
    vif_rows: List[Dict[str, object]] = []
    if len(x_numeric) >= max(8, len(x_cols) + 1):
        vifs = _vif_for_matrix(x_numeric.to_numpy(dtype=float))
        for name, vif in sorted(zip(x_numeric.columns, vifs), key=lambda t: t[1], reverse=True):
            vif_rows.append(
                {
                    "kind": "vif",
                    "feature_a": name,
                    "feature_b": "",
                    "pair_spearman_corr": np.nan,
                    "mean_abs_corr_to_y_a": float(
                        y_df.corrwith(x_numeric[name], method="spearman").abs().mean()
                    )
                    if not y_df.empty
                    else np.nan,
                    "mean_abs_corr_to_y_b": np.nan,
                    "suggest_keep": name if vif <= vif_threshold else "",
                    "suggest_drop": name if vif > vif_threshold else "",
                    "reason": f"VIF={vif:.3f}" + (f" > {vif_threshold}" if vif > vif_threshold else ""),
                    "vif": float(vif),
                }
            )
    out = pd.DataFrame(pair_rows + vif_rows)
    if out.empty:
        return out
    return out


def scatter_top_pairs(
    df: pd.DataFrame,
    spearman_df: pd.DataFrame,
    out_dir: Path,
    top_k: int,
) -> pd.DataFrame:
    plot_dir = out_dir / "figures_top_scatter"
    plot_dir.mkdir(parents=True, exist_ok=True)
    top = spearman_df.head(top_k).copy()
    rows: List[Dict[str, object]] = []
    for i, r in top.iterrows():
        x = r["x_feature"]
        y = r["y_metric"]
        pair = df[[x, y, "mode", "program"]].dropna()
        if len(pair) < 4:
            continue
        plt.figure(figsize=(6.2, 4.4))
        for mode, sub in pair.groupby("mode"):
            plt.scatter(sub[x], sub[y], s=28, alpha=0.78, label=mode)
        # median trend by x-quantile bins
        try:
            qbins = min(5, max(3, len(pair) // 10))
            bins = pd.qcut(pair[x], q=qbins, duplicates="drop")
            trend = pair.groupby(bins, observed=False).agg({x: "median", y: "median"}).dropna()
            if not trend.empty:
                plt.plot(trend[x], trend[y], color="black", linewidth=1.5, alpha=0.85, label="binned-median")
        except Exception:
            pass
        plt.xlabel(x)
        plt.ylabel(y)
        plt.title(f"{x} vs {y}\nSpearman rho={r['spearman_rho']:.3f}, p={r['p_value']:.3g}, n={int(r['n'])}")
        plt.grid(alpha=0.25, linestyle="--")
        plt.legend(fontsize=8)
        fname = f"{i+1:02d}_{x}__{y}.png".replace("/", "_")
        fpath = plot_dir / fname
        plt.tight_layout()
        plt.savefig(fpath, dpi=170)
        plt.close()
        rows.append(
            {
                "rank": i + 1,
                "x_feature": x,
                "y_metric": y,
                "spearman_rho": r["spearman_rho"],
                "p_value": r["p_value"],
                "n": r["n"],
                "plot_path": str(fpath),
            }
        )
    return pd.DataFrame(rows)


def to_markdown_table(df: pd.DataFrame, max_rows: int = 25) -> str:
    if df.empty:
        return "_empty_"
    small = df.head(max_rows).copy()
    return small.to_markdown(index=False)


def write_markdown_reports(
    out_dir: Path,
    anomalies: pd.DataFrame,
    spearman_df: pd.DataFrame,
    top_scatter_df: pd.DataFrame,
    feature_suggest_df: pd.DataFrame,
    args: argparse.Namespace,
) -> None:
    anomaly_md = out_dir / "anomaly_report.md"
    anomaly_md.write_text(
        "\n".join(
            [
                "# 异常样本报告",
                "",
                f"- input: `{Path(args.input_csv)}`",
                f"- iqr_k: `{args.iqr_k}`",
                f"- total anomalies: `{len(anomalies)}`",
                "",
                "## Top anomalies (by metric/value)",
                "",
                to_markdown_table(anomalies, max_rows=80),
                "",
            ]
        ),
        encoding="utf-8",
    )

    overview_md = out_dir / "analysis_overview.md"
    overview_md.write_text(
        "\n".join(
            [
                "# Static-Perf 关联分析概览",
                "",
                f"- input: `{Path(args.input_csv)}`",
                f"- top_k scatter: `{args.top_k}`",
                f"- corr_threshold: `{args.corr_threshold}`",
                f"- vif_threshold: `{args.vif_threshold}`",
                "",
                "## 1) Spearman top relations",
                "",
                to_markdown_table(spearman_df, max_rows=40),
                "",
                "## 2) Top scatter plots",
                "",
                to_markdown_table(top_scatter_df, max_rows=40),
                "",
                "## 3) Feature reduction suggestions",
                "",
                to_markdown_table(feature_suggest_df, max_rows=80),
                "",
            ]
        ),
        encoding="utf-8",
    )

    feature_md = out_dir / "feature_reduction_suggestions.md"
    feature_md.write_text(
        "\n".join(
            [
                "# 精简特征建议",
                "",
                f"- high-corr threshold: `{args.corr_threshold}`",
                f"- vif threshold: `{args.vif_threshold}`",
                "",
                to_markdown_table(feature_suggest_df, max_rows=120),
                "",
            ]
        ),
        encoding="utf-8",
    )


def main() -> None:
    args = parse_args()
    in_csv = Path(args.input_csv)
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    df = pd.read_csv(in_csv)
    needed = ["program", "mode"] + DEFAULT_X_FEATURES + DEFAULT_Y_METRICS
    existing = [c for c in needed if c in df.columns]
    df = df[existing].copy()
    df = ensure_numeric(df, [c for c in DEFAULT_X_FEATURES + DEFAULT_Y_METRICS if c in df.columns])

    # 1) anomaly report
    y_cols = [c for c in DEFAULT_Y_METRICS if c in df.columns]
    anomalies = detect_anomalies(df, y_cols, iqr_k=args.iqr_k)
    anomalies.to_csv(out_dir / "anomaly_report.csv", index=False)

    # 2) Spearman table
    x_cols = [c for c in DEFAULT_X_FEATURES if c in df.columns]
    spearman_df = spearman_table(df, x_cols, y_cols)
    spearman_df.to_csv(out_dir / "spearman_table.csv", index=False)

    # 3) Top scatter plots
    top_scatter_df = scatter_top_pairs(df, spearman_df, out_dir, top_k=args.top_k)
    top_scatter_df.to_csv(out_dir / "top_scatter_pairs.csv", index=False)

    # 4) feature reduction suggestions
    feature_suggest_df = feature_reduction_suggestions(
        df,
        x_cols=x_cols,
        y_cols=y_cols,
        corr_threshold=args.corr_threshold,
        vif_threshold=args.vif_threshold,
    )
    feature_suggest_df.to_csv(out_dir / "feature_reduction_suggestions.csv", index=False)

    write_markdown_reports(out_dir, anomalies, spearman_df, top_scatter_df, feature_suggest_df, args)

    print(f"anomaly:   {out_dir / 'anomaly_report.csv'} ({len(anomalies)} rows)")
    print(f"spearman:  {out_dir / 'spearman_table.csv'} ({len(spearman_df)} rows)")
    print(f"scatter:   {out_dir / 'figures_top_scatter'} ({len(top_scatter_df)} figures)")
    print(f"reduce:    {out_dir / 'feature_reduction_suggestions.csv'} ({len(feature_suggest_df)} rows)")
    print(f"overview:  {out_dir / 'analysis_overview.md'}")


if __name__ == "__main__":
    main()
