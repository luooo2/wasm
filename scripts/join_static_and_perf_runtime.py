#!/usr/bin/env python3
"""
Join LLVM static feature tables with wide perf counters (data_perf.csv).

For each (suite, program), aggregates perf over run_index (mean / std), then
computes Wasm-vs-Native gaps aligned with assets/4.15整理总结.md 阶段 2:

  - cycles ratio: proxy for execution time gap (wall-clock not in PMU dump)
  - instructions ratio: instruction inflation (retired insn Wasm / Native)
  - branch-miss rate delta: branch-misses / branches
  - L1 / LLC load-miss rate deltas

Outputs:
  data/results/perf/static_runtime_joint.csv   — one row per program + static + runtime
  data/results/perf/static_runtime_correlations.csv — Spearman rho vs gap metrics (by suite)
"""

from __future__ import annotations

import argparse
from pathlib import Path

import numpy as np
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_PERF = ROOT / "data/results/perf/data_perf.csv"
DEFAULT_MICRO = ROOT / "data/results/dataset_microbench.csv"
DEFAULT_POLY = ROOT / "data/results/dataset_polybench_kernel.csv"
OUT_JOINT = ROOT / "data/results/perf/static_runtime_joint.csv"
OUT_CORR = ROOT / "data/results/perf/static_runtime_correlations.csv"

PERF_RENAME = {
    "branch-misses": "branch_misses",
    "L1-dcache-loads": "L1_dcache_loads",
    "L1-dcache-load-misses": "L1_dcache_load_misses",
    "LLC-loads": "LLC_loads",
    "LLC-load-misses": "LLC_load_misses",
}

MODE_SUFFIX = {"native": "native", "wasm-jit": "wasm_jit", "wasm-aot": "wasm_aot"}


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    p.add_argument("--perf", type=Path, default=DEFAULT_PERF)
    p.add_argument("--micro-static", type=Path, default=DEFAULT_MICRO)
    p.add_argument("--poly-static", type=Path, default=DEFAULT_POLY)
    p.add_argument("--out-joint", type=Path, default=OUT_JOINT)
    p.add_argument("--out-corr", type=Path, default=OUT_CORR)
    p.add_argument("--no-correlations", action="store_true")
    return p.parse_args()


def load_static(micro_path: Path, poly_path: Path) -> pd.DataFrame:
    micro = pd.read_csv(micro_path)
    poly = pd.read_csv(poly_path)
    micro["suite"] = "micro"
    poly["suite"] = "poly"
    for col in ("label_jit", "label_aot"):
        if col not in poly.columns:
            poly[col] = np.nan
    cols = sorted(set(micro.columns) | set(poly.columns))
    micro = micro.reindex(columns=cols)
    poly = poly.reindex(columns=cols)
    return pd.concat([micro, poly], ignore_index=True)


def perf_program_summary(perf: pd.DataFrame) -> pd.DataFrame:
    df = perf.loc[perf["status"].str.strip() == "ok"].copy()
    df = df.rename(columns=PERF_RENAME)
    metrics = [
        "cycles",
        "instructions",
        "branches",
        "branch_misses",
        "L1_dcache_loads",
        "L1_dcache_load_misses",
        "LLC_loads",
        "LLC_load_misses",
    ]
    g = df.groupby(["suite", "program", "mode"], sort=False)
    means = g[metrics].mean()
    stds = g[metrics].std()
    counts = g.size().rename("perf_run_count")

    flat_m = means.reset_index().melt(
        id_vars=["suite", "program", "mode"],
        var_name="metric",
        value_name="v",
    )
    wide_mean = flat_m.pivot_table(
        index=["suite", "program"],
        columns=["mode", "metric"],
        values="v",
        aggfunc="first",
    )
    wide_mean.columns = [
        f"mean_{metric}_{MODE_SUFFIX[mode]}" for mode, metric in wide_mean.columns
    ]

    flat_s = stds.reset_index().melt(
        id_vars=["suite", "program", "mode"],
        var_name="metric",
        value_name="v",
    )
    wide_std = flat_s.pivot_table(
        index=["suite", "program"],
        columns=["mode", "metric"],
        values="v",
        aggfunc="first",
    )
    wide_std.columns = [
        f"std_{metric}_{MODE_SUFFIX[mode]}" for mode, metric in wide_std.columns
    ]

    cnt = counts.reset_index(name="perf_run_count").pivot_table(
        index=["suite", "program"],
        columns="mode",
        values="perf_run_count",
        aggfunc="first",
    )
    cnt.columns = [f"perf_run_count_{MODE_SUFFIX[c]}" for c in cnt.columns]

    out = pd.concat([wide_mean, wide_std, cnt], axis=1).reset_index()
    return out


def safe_div(a: pd.Series, b: pd.Series) -> pd.Series:
    return np.where(b > 0, a / b, np.nan)


def add_gap_columns(j: pd.DataFrame) -> pd.DataFrame:
    out = j.copy()

    for suf in ("native", "wasm_jit", "wasm_aot"):
        out[f"branch_miss_rate_{suf}"] = safe_div(
            out[f"mean_branch_misses_{suf}"],
            out[f"mean_branches_{suf}"],
        )
        out[f"l1_load_miss_rate_{suf}"] = safe_div(
            out[f"mean_L1_dcache_load_misses_{suf}"],
            out[f"mean_L1_dcache_loads_{suf}"],
        )
        out[f"llc_load_miss_rate_{suf}"] = safe_div(
            out[f"mean_LLC_load_misses_{suf}"],
            out[f"mean_LLC_loads_{suf}"],
        )
        out[f"ipc_{suf}"] = safe_div(
            out[f"mean_instructions_{suf}"],
            out[f"mean_cycles_{suf}"],
        )

    out["cycles_ratio_jit_over_native"] = safe_div(
        out["mean_cycles_wasm_jit"], out["mean_cycles_native"]
    )
    out["cycles_ratio_aot_over_native"] = safe_div(
        out["mean_cycles_wasm_aot"], out["mean_cycles_native"]
    )
    out["instructions_ratio_jit_over_native"] = safe_div(
        out["mean_instructions_wasm_jit"], out["mean_instructions_native"]
    )
    out["instructions_ratio_aot_over_native"] = safe_div(
        out["mean_instructions_wasm_aot"], out["mean_instructions_native"]
    )

    out["delta_branch_miss_rate_jit"] = (
        out["branch_miss_rate_wasm_jit"] - out["branch_miss_rate_native"]
    )
    out["delta_branch_miss_rate_aot"] = (
        out["branch_miss_rate_wasm_aot"] - out["branch_miss_rate_native"]
    )
    out["delta_l1_load_miss_rate_jit"] = (
        out["l1_load_miss_rate_wasm_jit"] - out["l1_load_miss_rate_native"]
    )
    out["delta_l1_load_miss_rate_aot"] = (
        out["l1_load_miss_rate_wasm_aot"] - out["l1_load_miss_rate_native"]
    )
    out["delta_llc_load_miss_rate_jit"] = (
        out["llc_load_miss_rate_wasm_jit"] - out["llc_load_miss_rate_native"]
    )
    out["delta_llc_load_miss_rate_aot"] = (
        out["llc_load_miss_rate_wasm_aot"] - out["llc_load_miss_rate_native"]
    )
    out["delta_ipc_jit"] = out["ipc_wasm_jit"] - out["ipc_native"]
    out["delta_ipc_aot"] = out["ipc_wasm_aot"] - out["ipc_native"]

    return out


def static_feature_columns(static: pd.DataFrame) -> list[str]:
    """LLVM-derived numeric columns only (not merged perf columns)."""
    skip = {
        "program",
        "suite",
        "label",
        "label_jit",
        "label_aot",
    }
    cols = []
    for c in static.columns:
        if c in skip:
            continue
        if static[c].dtype == object:
            continue
        cols.append(c)
    return cols


def spearman_rho(x: pd.Series, y: pd.Series) -> float:
    df = pd.DataFrame({"x": x, "y": y}).replace([np.inf, -np.inf], np.nan).dropna()
    if len(df) < 4:
        return float("nan")
    if df["x"].std() == 0 or df["y"].std() == 0:
        return float("nan")
    return float(df["x"].corr(df["y"], method="spearman"))


def correlation_table(joint: pd.DataFrame, feats: list[str]) -> pd.DataFrame:
    targets = [
        "cycles_ratio_jit_over_native",
        "cycles_ratio_aot_over_native",
        "instructions_ratio_jit_over_native",
        "instructions_ratio_aot_over_native",
        "delta_branch_miss_rate_jit",
        "delta_branch_miss_rate_aot",
        "delta_l1_load_miss_rate_jit",
        "delta_l1_load_miss_rate_aot",
        "delta_llc_load_miss_rate_jit",
        "delta_llc_load_miss_rate_aot",
        "delta_ipc_jit",
        "delta_ipc_aot",
    ]
    rows = []
    for suite in ("micro", "poly"):
        sub = joint[joint["suite"] == suite]
        for tgt in targets:
            if tgt not in sub.columns:
                continue
            for f in feats:
                if f not in sub.columns:
                    continue
                rho = spearman_rho(sub[f], sub[tgt])
                if np.isnan(rho):
                    continue
                rows.append(
                    {
                        "suite": suite,
                        "target": tgt,
                        "feature": f,
                        "spearman_rho": rho,
                        "n": int(
                            sub[[f, tgt]]
                            .replace([np.inf, -np.inf], np.nan)
                            .dropna()
                            .shape[0]
                        ),
                    }
                )
    return pd.DataFrame(rows)


def main() -> None:
    args = parse_args()
    perf = pd.read_csv(args.perf)
    static = load_static(args.micro_static, args.poly_static)
    ps = perf_program_summary(perf)

    joint = static.merge(ps, on=["suite", "program"], how="inner", validate="one_to_one")
    joint = add_gap_columns(joint)

    first = ["suite", "program", "label", "label_jit", "label_aot"]
    ordered = [c for c in first if c in joint.columns]
    ordered.extend([c for c in joint.columns if c not in ordered])
    joint = joint[ordered]

    args.out_joint.parent.mkdir(parents=True, exist_ok=True)
    joint.to_csv(args.out_joint, index=False)
    print(f"Wrote {args.out_joint} ({len(joint)} rows, {len(joint.columns)} columns)")

    if not args.no_correlations:
        feats = static_feature_columns(static)
        corr_df = correlation_table(joint, feats)
        corr_df["_absrho"] = corr_df["spearman_rho"].abs()
        corr_df = corr_df.sort_values(
            ["suite", "target", "_absrho"], ascending=[True, True, False]
        ).drop(columns=["_absrho"])
        corr_df.to_csv(args.out_corr, index=False)
        print(f"Wrote {args.out_corr} ({len(corr_df)} rows)")


if __name__ == "__main__":
    main()
