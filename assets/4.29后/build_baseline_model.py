#!/usr/bin/env python3
"""
Auto-select 8-10 static features and build a minimal interpretable baseline model.

Outputs under --out-dir:
  - final_feature_subset_v1.csv
  - baseline_model_coefficients.csv
  - baseline_model_cv_metrics.csv
  - baseline_model_report.md
"""

from __future__ import annotations

import argparse
from pathlib import Path
from typing import Dict, List, Sequence

import numpy as np
import pandas as pd
import statsmodels.api as sm
from scipy.stats import spearmanr
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.model_selection import KFold
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler


DEFAULT_X = [
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


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    ap = argparse.ArgumentParser()
    ap.add_argument("--input-csv", default=str(script_dir / "static_perf_join_llvm_direct.csv"))
    ap.add_argument("--out-dir", default=str(script_dir))
    ap.add_argument("--target", default="ratio_instructions_retired_over_native")
    ap.add_argument("--min-features", type=int, default=8)
    ap.add_argument("--max-features", type=int, default=10)
    ap.add_argument("--corr-threshold", type=float, default=0.85)
    ap.add_argument("--vif-threshold", type=float, default=10.0)
    ap.add_argument("--cv-folds", type=int, default=5)
    ap.add_argument("--seed", type=int, default=42)
    return ap.parse_args()


def _safe_spearman(x: pd.Series, y: pd.Series) -> float:
    pair = pd.concat([x, y], axis=1).dropna()
    if len(pair) < 4:
        return 0.0
    rho, _ = spearmanr(pair.iloc[:, 0], pair.iloc[:, 1])
    if np.isnan(rho):
        return 0.0
    return float(rho)


def _vif_table(df: pd.DataFrame) -> pd.DataFrame:
    x = df.to_numpy(dtype=float)
    names = list(df.columns)
    rows = []
    for j, name in enumerate(names):
        y = x[:, j]
        x_other = np.delete(x, j, axis=1)
        if x_other.shape[1] == 0:
            vif = 1.0
        else:
            x_design = np.column_stack([np.ones(len(x_other)), x_other])
            coef, *_ = np.linalg.lstsq(x_design, y, rcond=None)
            y_hat = x_design @ coef
            ss_res = float(np.sum((y - y_hat) ** 2))
            ss_tot = float(np.sum((y - np.mean(y)) ** 2))
            r2 = 0.0 if ss_tot == 0 else max(0.0, min(1.0, 1.0 - ss_res / ss_tot))
            vif = np.inf if r2 >= 0.999999 else 1.0 / (1.0 - r2)
        rows.append({"feature": name, "vif": float(vif)})
    return pd.DataFrame(rows).sort_values("vif", ascending=False).reset_index(drop=True)


def select_features(
    df: pd.DataFrame,
    x_candidates: Sequence[str],
    target: str,
    min_features: int,
    max_features: int,
    corr_threshold: float,
    vif_threshold: float,
) -> pd.DataFrame:
    y = df[target]
    scores: List[Dict[str, float]] = []
    for f in x_candidates:
        rho = _safe_spearman(df[f], y)
        scores.append({"feature": f, "spearman_to_target": rho, "abs_score": abs(rho)})
    score_df = pd.DataFrame(scores).sort_values("abs_score", ascending=False).reset_index(drop=True)

    selected: List[str] = []
    # Pass 1: strict de-correlation
    for f in score_df["feature"]:
        if len(selected) >= max_features:
            break
        ok = True
        for s in selected:
            c = df[[f, s]].corr(method="spearman").iloc[0, 1]
            if pd.notna(c) and abs(c) >= corr_threshold:
                ok = False
                break
        if ok:
            selected.append(f)

    # Pass 2: if not enough features, relax threshold gradually
    relax = corr_threshold + 0.05
    while len(selected) < min_features and relax <= 0.99:
        for f in score_df["feature"]:
            if f in selected or len(selected) >= min_features:
                continue
            ok = True
            for s in selected:
                c = df[[f, s]].corr(method="spearman").iloc[0, 1]
                if pd.notna(c) and abs(c) >= relax:
                    ok = False
                    break
            if ok:
                selected.append(f)
        relax += 0.05

    selected = selected[:max_features]
    data = df[selected + [target]].dropna().copy()
    if data.empty:
        raise RuntimeError("No valid rows after dropping NaN for selected features.")

    # Iterative VIF pruning; keep at least min_features.
    while len(selected) > min_features:
        vif_df = _vif_table(data[selected])
        top = vif_df.iloc[0]
        if float(top["vif"]) <= vif_threshold:
            break
        # Drop the highest VIF feature.
        drop_f = str(top["feature"])
        selected.remove(drop_f)
        data = df[selected + [target]].dropna().copy()

    out = score_df.copy()
    out["selected"] = out["feature"].isin(selected).astype(int)
    out["selection_order"] = out["feature"].apply(lambda x: selected.index(x) + 1 if x in selected else 0)
    # add final correlation matrix stats for selected
    pair_max = []
    for f in out["feature"]:
        if f not in selected:
            pair_max.append(np.nan)
            continue
        others = [x for x in selected if x != f]
        if not others:
            pair_max.append(0.0)
            continue
        vals = [abs(df[[f, o]].corr(method="spearman").iloc[0, 1]) for o in others]
        pair_max.append(float(np.nanmax(vals)))
    out["max_abs_corr_with_selected_others"] = pair_max
    return out


def fit_and_eval(df: pd.DataFrame, features: Sequence[str], target: str, cv_folds: int, seed: int):
    data = df[list(features) + [target]].dropna().copy()
    x = data[list(features)]
    y = data[target]

    # Interpretable coefficients via statsmodels OLS on standardized features.
    x_std = (x - x.mean()) / x.std(ddof=0).replace(0, 1)
    x_ols = sm.add_constant(x_std)
    ols = sm.OLS(y, x_ols).fit()

    coef_rows = []
    coef_rows.append(
        {
            "feature": "const",
            "coef": float(ols.params["const"]),
            "p_value": float(ols.pvalues["const"]),
            "std_err": float(ols.bse["const"]),
            "t_value": float(ols.tvalues["const"]),
        }
    )
    for f in features:
        coef_rows.append(
            {
                "feature": f,
                "coef": float(ols.params[f]),
                "p_value": float(ols.pvalues[f]),
                "std_err": float(ols.bse[f]),
                "t_value": float(ols.tvalues[f]),
            }
        )
    coef_df = pd.DataFrame(coef_rows).sort_values(
        ["feature"], key=lambda s: s.map(lambda x: 0 if x == "const" else 1)
    )

    # CV metrics via sklearn pipeline (standardize + linear regression).
    kf = KFold(n_splits=cv_folds, shuffle=True, random_state=seed)
    rmses = []
    r2s = []
    for tr, te in kf.split(x):
        x_tr, x_te = x.iloc[tr], x.iloc[te]
        y_tr, y_te = y.iloc[tr], y.iloc[te]
        pipe = Pipeline([("scaler", StandardScaler()), ("lr", LinearRegression())])
        pipe.fit(x_tr, y_tr)
        pred = pipe.predict(x_te)
        rmse = float(np.sqrt(mean_squared_error(y_te, pred)))
        r2 = float(r2_score(y_te, pred))
        rmses.append(rmse)
        r2s.append(r2)

    metrics = pd.DataFrame(
        [
            {
                "n_samples": len(data),
                "n_features": len(features),
                "cv_folds": cv_folds,
                "cv_rmse_mean": float(np.mean(rmses)),
                "cv_rmse_std": float(np.std(rmses)),
                "cv_r2_mean": float(np.mean(r2s)),
                "cv_r2_std": float(np.std(r2s)),
                "ols_r2": float(ols.rsquared),
                "ols_adj_r2": float(ols.rsquared_adj),
                "ols_f_pvalue": float(ols.f_pvalue),
            }
        ]
    )

    return coef_df, metrics, ols


def main() -> None:
    args = parse_args()
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    raw = pd.read_csv(args.input_csv)
    required = ["program", "mode", args.target]
    missing_req = [c for c in required if c not in raw.columns]
    if missing_req:
        raise ValueError(f"Missing required columns: {missing_req}")

    x_candidates = [c for c in DEFAULT_X if c in raw.columns]
    if len(x_candidates) < args.min_features:
        raise ValueError(f"Available features {len(x_candidates)} < min_features {args.min_features}")

    work = raw[["program", "mode", args.target] + x_candidates].copy()
    for c in x_candidates + [args.target]:
        work[c] = pd.to_numeric(work[c], errors="coerce")
    work = work.dropna(subset=[args.target]).copy()

    subset_df = select_features(
        df=work,
        x_candidates=x_candidates,
        target=args.target,
        min_features=args.min_features,
        max_features=args.max_features,
        corr_threshold=args.corr_threshold,
        vif_threshold=args.vif_threshold,
    )
    subset_df.to_csv(out_dir / "final_feature_subset_v1.csv", index=False)
    selected = subset_df.loc[subset_df["selected"] == 1, "feature"].tolist()

    coef_df, metrics_df, ols = fit_and_eval(work, selected, args.target, args.cv_folds, args.seed)
    coef_df.to_csv(out_dir / "baseline_model_coefficients.csv", index=False)
    metrics_df.to_csv(out_dir / "baseline_model_cv_metrics.csv", index=False)

    report = out_dir / "baseline_model_report.md"
    lines = []
    lines.append("# 最小可解释基线模型")
    lines.append("")
    lines.append(f"- target: `{args.target}`")
    lines.append(f"- selected feature count: `{len(selected)}`")
    lines.append(f"- selected features: `{', '.join(selected)}`")
    lines.append("")
    lines.append("## 交叉验证指标")
    lines.append("")
    lines.append(metrics_df.to_markdown(index=False))
    lines.append("")
    lines.append("## OLS 标准化系数（可解释）")
    lines.append("")
    lines.append(
        coef_df.assign(abs_coef=coef_df["coef"].abs())
        .sort_values("abs_coef", ascending=False)
        .drop(columns=["abs_coef"])
        .to_markdown(index=False)
    )
    lines.append("")
    lines.append("## OLS 摘要（截断）")
    lines.append("")
    summary_text = str(ols.summary())
    lines.append("```text")
    lines.extend(summary_text.splitlines()[:45])
    lines.append("... (truncated)")
    lines.append("```")
    report.write_text("\n".join(lines), encoding="utf-8")

    print(f"subset:   {out_dir / 'final_feature_subset_v1.csv'}")
    print(f"coef:     {out_dir / 'baseline_model_coefficients.csv'}")
    print(f"metrics:  {out_dir / 'baseline_model_cv_metrics.csv'}")
    print(f"report:   {out_dir / 'baseline_model_report.md'}")


if __name__ == "__main__":
    main()
