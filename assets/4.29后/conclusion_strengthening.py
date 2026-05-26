#!/usr/bin/env python3
"""
Conclusion strengthening: robustness (OLS / Huber RLM / winsorized OLS),
stratified analysis by wasm mode, and export paths for anomaly case notes.

Reads:
  - static_perf_join_llvm_direct.csv
  - final_feature_subset_v1.csv (selected==1 features)

Writes under --out-dir:
  - robustness_models_coefficients.csv
  - robustness_key_feature_signs.csv
  - stratified_spearman.csv
  - stratified_regression_coefficients.csv
  - stratified_regression_metrics.csv
  - conclusion_strengthening_report.md
  - anomaly_case_notes.md
"""

from __future__ import annotations

import argparse
from pathlib import Path
from typing import List, Optional, Sequence, Tuple

import numpy as np
import pandas as pd
import statsmodels.api as sm
from scipy.stats import spearmanr
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.model_selection import KFold
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler

KEY_FEATURES = [
    "memory_access_density",
    "hostcall_density",
    "ir_instruction_count",
    "max_loop_depth",
]


def parse_args() -> argparse.Namespace:
    d = Path(__file__).resolve().parent
    ap = argparse.ArgumentParser()
    ap.add_argument("--input-csv", default=str(d / "static_perf_join_llvm_direct.csv"))
    ap.add_argument("--feature-subset-csv", default=str(d / "final_feature_subset_v1.csv"))
    ap.add_argument("--out-dir", default=str(d))
    ap.add_argument("--target", default="ratio_instructions_retired_over_native")
    ap.add_argument("--winsor-low", type=float, default=0.025, help="Lower quantile for winsorize on y")
    ap.add_argument("--winsor-high", type=float, default=0.975, help="Upper quantile for winsorize on y")
    ap.add_argument("--seed", type=int, default=42)
    return ap.parse_args()


def load_selected_features(path: Path) -> List[str]:
    df = pd.read_csv(path)
    sel = df.loc[df["selected"] == 1, "feature"].astype(str).tolist()
    if not sel:
        raise ValueError(f"No selected features in {path}")
    return sel


def standardize_x(x: pd.DataFrame) -> pd.DataFrame:
    mu = x.mean()
    sd = x.std(ddof=0).replace(0, 1.0)
    return (x - mu) / sd


def winsorize_series(y: pd.Series, low_q: float, high_q: float) -> pd.Series:
    lo = y.quantile(low_q)
    hi = y.quantile(high_q)
    return y.clip(lower=lo, upper=hi)


def fit_ols(y: pd.Series, x_std: pd.DataFrame):
    x_mat = sm.add_constant(x_std)
    return sm.OLS(y, x_mat).fit()


def fit_rlm(y: pd.Series, x_std: pd.DataFrame):
    x_mat = sm.add_constant(x_std)
    return sm.RLM(y, x_mat, M=sm.robust.norms.HuberT()).fit()


def coefs_to_rows(
    fit,
    model_name: str,
    scope: str,
    p_getter: bool = True,
) -> List[dict]:
    rows = []
    for feat in fit.params.index:
        pval = np.nan
        if p_getter and hasattr(fit, "pvalues") and feat in fit.pvalues.index:
            try:
                pval = float(fit.pvalues[feat])
            except Exception:
                pval = np.nan
        rows.append(
            {
                "scope": scope,
                "model": model_name,
                "feature": feat,
                "coef": float(fit.params[feat]),
                "std_err": float(fit.bse[feat]) if feat in fit.bse.index else np.nan,
                "p_value": pval,
            }
        )
    return rows


def sign(x: float) -> int:
    if x > 0:
        return 1
    if x < 0:
        return -1
    return 0


def cv_metrics(
    x: pd.DataFrame,
    y: pd.Series,
    n_splits: int,
    seed: int,
) -> Tuple[float, float]:
    n = len(x)
    if n < n_splits + 2:
        return float("nan"), float("nan")
    kf = KFold(n_splits=n_splits, shuffle=True, random_state=seed)
    r2s = []
    for tr, te in kf.split(x):
        pipe = Pipeline([("scaler", StandardScaler()), ("lr", LinearRegression())])
        pipe.fit(x.iloc[tr], y.iloc[tr])
        pred = pipe.predict(x.iloc[te])
        r2s.append(float(r2_score(y.iloc[te], pred)))
    return float(np.mean(r2s)), float(np.std(r2s))


def spearman_rows(
    df: pd.DataFrame,
    features: Sequence[str],
    target: str,
    mode: Optional[str],
) -> List[dict]:
    sub = df.copy()
    if mode is not None:
        sub = sub[sub["mode"] == mode]
    rows = []
    for f in features:
        if f not in sub.columns:
            continue
        pair = sub[[f, target]].dropna()
        n = len(pair)
        if n < 4:
            continue
        rho, p = spearmanr(pair[f], pair[target])
        rows.append(
            {
                "mode_scope": mode if mode is not None else "pooled",
                "feature": f,
                "n": n,
                "spearman_rho": float(rho),
                "p_value": float(p),
            }
        )
    return rows


def write_anomaly_case_notes(path: Path) -> None:
    text = """# 异常样本个案说明（结论加固用）

以下程序在 `anomaly_report.csv` 中多次出现，或比值极端；写作论文时建议**单独讨论**或归入「微基准 / 扩展集」，避免与常规 kernel 混为一谈。

## llvmss_shootout_hello（Shootout/hello.c）

- **为何极端**：IR 极小（约 2 条指令量级），native 侧 retired 事件与周期数本身就很低；Wasm 仍要付运行时与线性内存等固定成本，导致 `ratio_*` 分母过小、比值被放大到 10～20 倍量级。
- **建议**：归入**非代表性微基准**，主结论中可脚注说明；或从主回归剔除，仅在「固定开销敏感性」小节展示。

## llvmss_misc_flops-4 / flops-7 / flops-8（Misc/flops-*.c）

- **为何极端**：`ratio_all_loads_retired_over_native` 或 `ratio_all_stores_retired_over_native` 可达数百倍；程序体小、大量浮点循环 + 频繁 `printf` 类宿主调用，Wasm 路径下 load/store 与宿主交互被显著放大，而 native 基线事件数相对较小。
- **建议**：归入**扩展集**或按 `adaptation_level=minimal` 标注；分析 hostcall / IO 效应时保留，做「全样本 vs 剔除微基准」对照表。

## llvmss_misc_mandel-2（Misc/mandel-2.c）

- **为何极端**：与 flops 类似，`all_loads` / `all_stores` 比值约 250+；计算核小、边界检查与访存展开在 Wasm 侧占主导，perf 比值对「静态 IR 规模」极不敏感。
- **建议**：与 flops 同类处理；若讨论「访存放大」可保留为 case study。

## llvmss_stanford_intmm / realmm / floatmm（Stanford 矩阵类）

- **为何极端**：`ratio_all_stores_retired` 或 `ratio_L1_icache_load_misses` 偏高；矩阵访存密集，Wasm 线性内存与代码布局使 icache / store 事件相对 native 抬升明显，属于**结构真实差异**而非纯噪声。
- **建议**：**保留在主样本**，但在文中说明「数值核 + 密集访存」子类。

## llvmss_stanford_oscar / queens / perm / bubblesort / towers 等

- **为何极端**：多出现在 `ratio_L1_icache_load_misses_over_native` 高分位；控制流与代码体积与 Wasm 运行时组合易导致 I-cache 行为与 native 差异大。
- **建议**：保留为主样本；与 `avg_bb_size`、分支类特征联动解读。

## llvmss_misc_salsa20

- **为何极端**：`ratio_branch_misses_over_native` 极高（约 25～26）；密码学式密集位运算与分支模式使分支预测差异被放大。
- **建议**：保留为 **branch-miss 敏感** 代表；讨论分支相关结论时单独点出。

---

**汇总**：`hello` 与部分极小 `flops`/`mandel` 更宜视为**比值失真型微基准**；Stanford 矩阵与 salsa20 更宜视为**真实结构差异型**极端值。后续鲁棒回归与 winsorize 主要削弱前一类对全局斜率的影响。
"""
    path.write_text(text, encoding="utf-8")


def main() -> None:
    args = parse_args()
    out = Path(args.out_dir)
    out.mkdir(parents=True, exist_ok=True)

    raw = pd.read_csv(args.input_csv)
    features = load_selected_features(Path(args.feature_subset_csv))
    tgt = args.target
    for c in features + [tgt, "mode", "program"]:
        if c in raw.columns and c not in ("mode", "program"):
            raw[c] = pd.to_numeric(raw[c], errors="coerce")

    work = raw[["program", "mode", tgt] + features].dropna(subset=[tgt]).copy()
    if len(work) < 12:
        raise RuntimeError("Too few rows for strengthening analysis.")

    coef_all: List[dict] = []
    metrics_rows: List[dict] = []

    def run_block(scope: str, sub: pd.DataFrame, model_suffix: str = "") -> None:
        x = sub[features].astype(float)
        y = sub[tgt].astype(float)
        x_std = standardize_x(x)

        ols = fit_ols(y, x_std)
        coef_all.extend(coefs_to_rows(ols, "ols" + model_suffix, scope, True))

        rlm = fit_rlm(y, x_std)
        coef_all.extend(coefs_to_rows(rlm, "rlm_huber" + model_suffix, scope, True))

        y_w = winsorize_series(y, args.winsor_low, args.winsor_high)
        ols_w = fit_ols(y_w, x_std)
        coef_all.extend(coefs_to_rows(ols_w, "ols_winsor_y" + model_suffix, scope, True))

        # Small n + many features makes KFold R² unstable; use fewer folds when n is low.
        n_splits = min(5, max(3, len(sub) // 10))
        if len(sub) < 40:
            n_splits = min(3, max(2, len(sub) // 12))
        if n_splits >= len(sub):
            n_splits = max(2, len(sub) - 1)
        cv_m, cv_s = cv_metrics(x, y, n_splits, args.seed)
        cv_m_w, cv_s_w = cv_metrics(x, y_w, n_splits, args.seed)
        metrics_rows.append(
            {
                "scope": scope,
                "n": len(sub),
                "cv_n_splits": n_splits,
                "ols_r2": float(ols.rsquared),
                "ols_adj_r2": float(ols.rsquared_adj),
                "ols_winsor_y_r2": float(ols_w.rsquared),
                "cv_r2_mean": cv_m,
                "cv_r2_std": cv_s,
                "cv_r2_mean_winsor_y": cv_m_w,
                "cv_r2_std_winsor_y": cv_s_w,
            }
        )

    run_block("pooled_all_modes", work)

    spearman_all: List[dict] = []
    spearman_all.extend(spearman_rows(work, features, tgt, None))

    for mode in sorted(work["mode"].dropna().unique()):
        sub = work[work["mode"] == mode]
        spearman_all.extend(spearman_rows(work, features, tgt, str(mode)))
        run_block(f"mode_{mode}", sub, f"_{mode.replace('-', '_')}")

    coef_df = pd.DataFrame(coef_all)
    coef_df.to_csv(out / "robustness_models_coefficients.csv", index=False)

    # Key feature sign agreement (pooled only)
    pooled = coef_df[coef_df["scope"] == "pooled_all_modes"]
    signs = {}
    for m in ["ols", "rlm_huber", "ols_winsor_y"]:
        subm = pooled[pooled["model"] == m].set_index("feature")["coef"]
        signs[m] = subm

    key_rows = []
    for f in KEY_FEATURES:
        if f not in signs["ols"].index:
            continue
        s_ols = sign(float(signs["ols"].get(f, 0)))
        s_rlm = sign(float(signs["rlm_huber"].get(f, 0))) if f in signs["rlm_huber"].index else 0
        s_w = sign(float(signs["ols_winsor_y"].get(f, 0))) if f in signs["ols_winsor_y"].index else 0
        key_rows.append(
            {
                "feature": f,
                "sign_ols": s_ols,
                "sign_rlm_huber": s_rlm,
                "sign_ols_winsor_y": s_w,
                "all_three_agree": int(s_ols == s_rlm == s_w and s_ols != 0),
            }
        )
    pd.DataFrame(key_rows).to_csv(out / "robustness_key_feature_signs.csv", index=False)

    pd.DataFrame(spearman_all).to_csv(out / "stratified_spearman.csv", index=False)

    strat_only = coef_df[coef_df["scope"].str.startswith("mode_")].copy()
    strat_only.to_csv(out / "stratified_regression_coefficients.csv", index=False)

    pd.DataFrame(metrics_rows).to_csv(out / "stratified_regression_metrics.csv", index=False)

    # Report MD
    signs_df = pd.DataFrame(key_rows)
    met_df = pd.DataFrame(metrics_rows)
    report_lines = [
        "# 结论加固报告",
        "",
        f"- 目标变量: `{tgt}`",
        f"- 特征子集: 来自 `final_feature_subset_v1.csv`（共 {len(features)} 个）",
        f"- Winsorize: 对 y 在分位数 [{args.winsor_low}, {args.winsor_high}] 处截断后再做 OLS",
        "",
        "> **说明**：`mode_wasm-*` 每组仅约 26 个样本、8 个特征，K 折交叉验证的 `R²` 可能为负或波动极大，**不宜作为泛化能力结论**；分层部分请以 **同号 Spearman** 与 **回归系数方向** 为主，CV 仅作参考。",
        "",
        "## 1) 关键特征系数符号是否一致（pooled：OLS vs RLM vs Winsor-OLS）",
        "",
        signs_df.to_markdown(index=False),
        "",
        "> `all_three_agree=1` 表示三种模型下系数符号一致且非零。",
        "",
        "## 2) 拟合度与交叉验证（按 pooled / 分 mode）",
        "",
        met_df.to_markdown(index=False),
        "",
        "## 3) 输出文件",
        "",
        "- `robustness_models_coefficients.csv`",
        "- `robustness_key_feature_signs.csv`",
        "- `stratified_spearman.csv`",
        "- `stratified_regression_coefficients.csv`",
        "- `stratified_regression_metrics.csv`",
        "- `anomaly_case_notes.md`",
        "",
    ]
    (out / "conclusion_strengthening_report.md").write_text("\n".join(report_lines), encoding="utf-8")

    write_anomaly_case_notes(out / "anomaly_case_notes.md")

    print("Wrote:")
    for name in [
        "robustness_models_coefficients.csv",
        "robustness_key_feature_signs.csv",
        "stratified_spearman.csv",
        "stratified_regression_coefficients.csv",
        "stratified_regression_metrics.csv",
        "conclusion_strengthening_report.md",
        "anomaly_case_notes.md",
    ]:
        print(f"  {out / name}")


if __name__ == "__main__":
    main()
