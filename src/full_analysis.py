"""
Comprehensive analysis: feature correlation, classification, continuous ratio regression.
Outputs a Markdown report to data/results/full_analysis_report.md
"""

import os, sys, warnings
import numpy as np
import pandas as pd
from pathlib import Path

warnings.filterwarnings("ignore")

ROOT = Path(__file__).resolve().parent.parent
RESULTS = ROOT / "data" / "results"

FEATURE_COLS = [
    "total_instr_count", "basic_block_count", "avg_bb_size", "avg_bb_out_degree",
    "max_loop_depth", "br_instr_count", "br_density",
    "compute_instr_count", "compute_density", "mem_instr_count", "ls_ratio",
    "func_count", "call_instr_count", "call_density",
    "syscall_count", "syscall_density", "io_call_count", "io_density",
    "compute_mem_ratio", "call_bb_ratio",
]

POLYBENCH_FEATURE_COLS = [
    "total_instr_count", "basic_block_count", "avg_bb_size", "avg_bb_out_degree",
    "max_loop_depth", "br_instr_count", "br_density",
    "compute_instr_count", "compute_density", "mem_instr_count", "ls_ratio",
    "func_count", "call_instr_count", "call_density",
    "compute_mem_ratio", "call_bb_ratio",
]


def load_microbench():
    feat = pd.read_csv(RESULTS / "dataset_microbench.csv")
    ratio = pd.read_csv(RESULTS / "labels_microbench_internal.csv")
    ratio = ratio[["program", "ratio_jit_over_native", "ratio_aot_over_native"]].copy()
    df = feat.merge(ratio, on="program", how="inner")
    return df


def load_polybench():
    feat = pd.read_csv(RESULTS / "dataset_polybench_kernel.csv")
    ratio = pd.read_csv(RESULTS / "polybench_summary.csv")
    ratio = ratio[["program", "ratio_jit_over_native", "ratio_aot_over_native",
                    "label_jit", "label_aot"]].copy()
    df = feat.merge(ratio, on="program", how="inner")
    return df


def label_encode(s):
    mapping = {"wasm-better": 0, "similar": 1, "native-better": 2}
    return s.map(mapping)


# ───────────────────────────────────────
# 1. Feature Correlation Analysis
# ───────────────────────────────────────
def correlation_analysis(df, feat_cols, name):
    from scipy.stats import spearmanr, pearsonr
    lines = [f"### {name}\n"]

    for ratio_col in ["ratio_jit_over_native", "ratio_aot_over_native"]:
        if ratio_col not in df.columns:
            continue
        lines.append(f"\n**{ratio_col}**\n")
        lines.append("| Feature | Pearson r | p-value | Spearman ρ | p-value |")
        lines.append("|---------|-----------|---------|------------|---------|")
        rows = []
        for f in feat_cols:
            x = df[f].values.astype(float)
            y = df[ratio_col].values.astype(float)
            mask = np.isfinite(x) & np.isfinite(y)
            if mask.sum() < 5:
                continue
            pr, pp = pearsonr(x[mask], y[mask])
            sr, sp = spearmanr(x[mask], y[mask])
            rows.append((f, pr, pp, sr, sp))
        rows.sort(key=lambda r: abs(r[3]), reverse=True)
        for f, pr, pp, sr, sp in rows:
            sig_p = "**" if pp < 0.05 else ""
            sig_s = "**" if sp < 0.05 else ""
            lines.append(f"| {f} | {sig_p}{pr:.4f}{sig_p} | {pp:.4f} | {sig_s}{sr:.4f}{sig_s} | {sp:.4f} |")
    return "\n".join(lines)


def feature_intercorr(df, feat_cols, name):
    corr = df[feat_cols].corr(method="spearman")
    lines = [f"\n### {name} — Feature Intercorrelation (|ρ| > 0.8)\n"]
    pairs = set()
    for i, c1 in enumerate(feat_cols):
        for j, c2 in enumerate(feat_cols):
            if i >= j:
                continue
            v = corr.loc[c1, c2]
            if abs(v) > 0.8:
                pairs.add((c1, c2, v))
    if pairs:
        lines.append("| Feature A | Feature B | Spearman ρ |")
        lines.append("|-----------|-----------|------------|")
        for a, b, v in sorted(pairs, key=lambda x: -abs(x[2])):
            lines.append(f"| {a} | {b} | {v:.4f} |")
    else:
        lines.append("No feature pairs with |ρ| > 0.8.")
    return "\n".join(lines)


# ───────────────────────────────────────
# 2. Classification Analysis
# ───────────────────────────────────────
def classification_analysis(df, feat_cols, label_col, name):
    from sklearn.tree import DecisionTreeClassifier
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.linear_model import LogisticRegression
    from sklearn.model_selection import LeaveOneOut, cross_val_predict
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import accuracy_score, classification_report

    X = df[feat_cols].values.astype(float)
    y = df[label_col].values
    classes = sorted(set(y))
    n = len(y)

    lines = [f"\n### {name} (label=`{label_col}`, n={n})\n"]
    lines.append(f"**Label distribution**: {dict(pd.Series(y).value_counts())}\n")

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    models = {
        "Decision Tree (depth=3)": DecisionTreeClassifier(max_depth=3, random_state=42),
        "Random Forest (n=100)": RandomForestClassifier(n_estimators=100, max_depth=4, random_state=42),
        "Logistic Regression": LogisticRegression(max_iter=2000, random_state=42, multi_class="ovr"),
    }

    loo = LeaveOneOut()
    for mname, model in models.items():
        use_X = X_scaled if "Logistic" in mname else X
        y_pred = cross_val_predict(model, use_X, y, cv=loo)
        acc = accuracy_score(y, y_pred)
        lines.append(f"**{mname}** — LOO Accuracy: **{acc:.4f}** ({int(acc*n)}/{n})\n")
        lines.append("```")
        lines.append(classification_report(y, y_pred, zero_division=0))
        lines.append("```\n")

    best_rf = RandomForestClassifier(n_estimators=200, max_depth=5, random_state=42)
    best_rf.fit(X, y)
    importances = best_rf.feature_importances_
    feat_imp = sorted(zip(feat_cols, importances), key=lambda x: -x[1])
    lines.append("**Random Forest Feature Importances (top 10)**\n")
    lines.append("| Feature | Importance |")
    lines.append("|---------|------------|")
    for f, imp in feat_imp[:10]:
        lines.append(f"| {f} | {imp:.4f} |")

    return "\n".join(lines)


# ───────────────────────────────────────
# 3. Continuous Ratio Regression
# ───────────────────────────────────────
def regression_analysis(df, feat_cols, ratio_col, name):
    from sklearn.linear_model import LinearRegression, Ridge, Lasso
    from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
    from sklearn.model_selection import LeaveOneOut, cross_val_predict
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import r2_score, mean_absolute_error, mean_squared_error

    X = df[feat_cols].values.astype(float)
    y = df[ratio_col].values.astype(float)
    n = len(y)

    lines = [f"\n### {name} (target=`{ratio_col}`, n={n})\n"]
    lines.append(f"**Ratio stats**: mean={y.mean():.4f}, std={y.std():.4f}, "
                 f"min={y.min():.4f}, max={y.max():.4f}\n")

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    models = {
        "Linear Regression": (LinearRegression(), X_scaled),
        "Ridge (α=1.0)": (Ridge(alpha=1.0), X_scaled),
        "Lasso (α=0.01)": (Lasso(alpha=0.01, max_iter=5000), X_scaled),
        "Random Forest (n=100)": (RandomForestRegressor(n_estimators=100, max_depth=4, random_state=42), X),
        "Gradient Boosting": (GradientBoostingRegressor(n_estimators=100, max_depth=3, learning_rate=0.1, random_state=42), X),
    }

    loo = LeaveOneOut()
    lines.append("| Model | LOO R² | MAE | RMSE |")
    lines.append("|-------|--------|-----|------|")

    best_r2 = -999
    best_model_name = ""
    for mname, (model, use_X) in models.items():
        y_pred = cross_val_predict(model, use_X, y, cv=loo)
        r2 = r2_score(y, y_pred)
        mae = mean_absolute_error(y, y_pred)
        rmse = np.sqrt(mean_squared_error(y, y_pred))
        lines.append(f"| {mname} | {r2:.4f} | {mae:.4f} | {rmse:.4f} |")
        if r2 > best_r2:
            best_r2 = r2
            best_model_name = mname

    lines.append(f"\nBest LOO R²: **{best_model_name}** ({best_r2:.4f})\n")

    rf = RandomForestRegressor(n_estimators=200, max_depth=5, random_state=42)
    rf.fit(X, y)
    importances = rf.feature_importances_
    feat_imp = sorted(zip(feat_cols, importances), key=lambda x: -x[1])
    lines.append("**RF Feature Importances (top 10)**\n")
    lines.append("| Feature | Importance |")
    lines.append("|---------|------------|")
    for f, imp in feat_imp[:10]:
        lines.append(f"| {f} | {imp:.4f} |")

    ridge = Ridge(alpha=1.0)
    ridge.fit(X_scaled, y)
    coefs = sorted(zip(feat_cols, ridge.coef_), key=lambda x: -abs(x[1]))
    lines.append("\n**Ridge Regression Coefficients (standardized, top 10)**\n")
    lines.append("| Feature | Coefficient |")
    lines.append("|---------|-------------|")
    for f, c in coefs[:10]:
        lines.append(f"| {f} | {c:.4f} |")

    return "\n".join(lines)


# ───────────────────────────────────────
# Main
# ───────────────────────────────────────
def main():
    micro = load_microbench()
    poly = load_polybench()

    report = []
    report.append("# WebAssembly 性能特征综合分析报告\n")
    report.append(f"Microbench samples: {len(micro)}, PolyBench samples: {len(poly)}\n")

    # ── Part 1: Correlation ──
    report.append("## 1. 特征相关性分析\n")
    report.append(correlation_analysis(micro, FEATURE_COLS, "Microbench"))
    report.append(correlation_analysis(poly, POLYBENCH_FEATURE_COLS, "PolyBench"))
    report.append(feature_intercorr(micro, FEATURE_COLS, "Microbench"))
    report.append(feature_intercorr(poly, POLYBENCH_FEATURE_COLS, "PolyBench"))

    # ── Part 2: Classification ──
    report.append("\n## 2. 分类模型建模分析\n")
    report.append(classification_analysis(micro, FEATURE_COLS, "label", "Microbench (combined label)"))
    report.append(classification_analysis(micro, FEATURE_COLS, "label_jit", "Microbench (JIT label)"))
    report.append(classification_analysis(micro, FEATURE_COLS, "label_aot", "Microbench (AOT label)"))
    report.append(classification_analysis(poly, POLYBENCH_FEATURE_COLS, "label", "PolyBench (combined label)"))
    report.append(classification_analysis(poly, POLYBENCH_FEATURE_COLS, "label_jit", "PolyBench (JIT label)"))
    report.append(classification_analysis(poly, POLYBENCH_FEATURE_COLS, "label_aot", "PolyBench (AOT label)"))

    # ── Part 3: Regression ──
    report.append("\n## 3. 连续 Ratio 回归建模分析\n")
    report.append(regression_analysis(micro, FEATURE_COLS, "ratio_jit_over_native", "Microbench JIT Ratio"))
    report.append(regression_analysis(micro, FEATURE_COLS, "ratio_aot_over_native", "Microbench AOT Ratio"))
    report.append(regression_analysis(poly, POLYBENCH_FEATURE_COLS, "ratio_jit_over_native", "PolyBench JIT Ratio"))
    report.append(regression_analysis(poly, POLYBENCH_FEATURE_COLS, "ratio_aot_over_native", "PolyBench AOT Ratio"))

    full_report = "\n".join(report)
    out_path = RESULTS / "full_analysis_report.md"
    out_path.write_text(full_report, encoding="utf-8")
    print(f"Report written to {out_path}")
    print("Done. Check the report file for results.")


if __name__ == "__main__":
    main()
