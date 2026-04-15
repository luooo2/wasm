"""
Binary classification: native-better vs nonnative-better (similar + wasm-better).
Outputs report to data/results/binary_classification_report.md
"""

import warnings
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
    return feat.merge(ratio, on="program", how="inner")


def load_polybench():
    feat = pd.read_csv(RESULTS / "dataset_polybench_kernel.csv")
    ratio = pd.read_csv(RESULTS / "polybench_summary.csv")
    ratio = ratio[["program", "ratio_jit_over_native", "ratio_aot_over_native",
                    "label_jit", "label_aot"]].copy()
    return feat.merge(ratio, on="program", how="inner")


def to_binary(labels):
    return np.array(["native-better" if l == "native-better" else "nonnative-better" for l in labels])


def binary_cls(df, feat_cols, label_col, name):
    from sklearn.tree import DecisionTreeClassifier, export_text
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.linear_model import LogisticRegression
    from sklearn.svm import SVC
    from sklearn.model_selection import LeaveOneOut, cross_val_predict
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import (accuracy_score, classification_report,
                                 f1_score, precision_score, recall_score,
                                 confusion_matrix, roc_auc_score)

    X = df[feat_cols].values.astype(float)
    y_raw = df[label_col].values
    y = to_binary(y_raw)
    n = len(y)
    pos = (y == "native-better").sum()
    neg = n - pos

    lines = [f"### {name} (n={n}, native-better={pos}, nonnative-better={neg})\n"]

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    models = {
        "Decision Tree (depth=3)": (DecisionTreeClassifier(max_depth=3, random_state=42), X),
        "Decision Tree (depth=2)": (DecisionTreeClassifier(max_depth=2, random_state=42), X),
        "Random Forest (n=100, depth=4)": (RandomForestClassifier(n_estimators=100, max_depth=4, random_state=42), X),
        "Random Forest (n=200, depth=5)": (RandomForestClassifier(n_estimators=200, max_depth=5, random_state=42), X),
        "Logistic Regression": (LogisticRegression(max_iter=2000, random_state=42), X_scaled),
        "SVM (RBF)": (SVC(kernel="rbf", random_state=42, probability=True), X_scaled),
        "SVM (Linear)": (SVC(kernel="linear", random_state=42, probability=True), X_scaled),
    }

    loo = LeaveOneOut()
    lines.append("| Model | Accuracy | F1 (macro) | Precision (NB) | Recall (NB) | AUC |")
    lines.append("|-------|----------|------------|----------------|-------------|-----|")

    best_acc = 0
    best_name = ""
    for mname, (model, use_X) in models.items():
        y_pred = cross_val_predict(model, use_X, y, cv=loo)
        acc = accuracy_score(y, y_pred)
        f1 = f1_score(y, y_pred, average="macro")
        prec_nb = precision_score(y, y_pred, pos_label="native-better", zero_division=0)
        rec_nb = recall_score(y, y_pred, pos_label="native-better", zero_division=0)
        try:
            y_prob = cross_val_predict(model, use_X, y, cv=loo, method="predict_proba")
            auc = roc_auc_score((y == "native-better").astype(int),
                                y_prob[:, list(model.classes_).index("native-better") if hasattr(model, "classes_") else 0])
        except Exception:
            try:
                model_tmp = type(model)(**model.get_params())
                model_tmp.fit(use_X, y)
                cls_list = list(model_tmp.classes_)
                y_prob = cross_val_predict(model_tmp.__class__(**model_tmp.get_params()), use_X, y, cv=loo, method="predict_proba")
                nb_idx = cls_list.index("native-better")
                auc = roc_auc_score((y == "native-better").astype(int), y_prob[:, nb_idx])
            except Exception:
                auc = float("nan")
        lines.append(f"| {mname} | **{acc:.4f}** | {f1:.4f} | {prec_nb:.4f} | {rec_nb:.4f} | {auc:.4f} |")
        if acc > best_acc:
            best_acc = acc
            best_name = mname

    lines.append(f"\nBest LOO accuracy: **{best_name}** ({best_acc:.4f})\n")

    # Detailed report for best tree-based model
    lines.append("#### Confusion Matrix (Random Forest n=200)\n")
    rf = RandomForestClassifier(n_estimators=200, max_depth=5, random_state=42)
    y_pred_rf = cross_val_predict(rf, X, y, cv=loo)
    cm = confusion_matrix(y, y_pred_rf, labels=["native-better", "nonnative-better"])
    lines.append("```")
    lines.append(f"                  Predicted")
    lines.append(f"                  NB    NNB")
    lines.append(f"Actual NB        {cm[0,0]:3d}   {cm[0,1]:3d}")
    lines.append(f"Actual NNB       {cm[1,0]:3d}   {cm[1,1]:3d}")
    lines.append("```\n")

    lines.append("```")
    lines.append(classification_report(y, y_pred_rf, zero_division=0))
    lines.append("```\n")

    # Misclassified programs
    programs = df["program"].values
    mis = [(programs[i], y[i], y_pred_rf[i]) for i in range(n) if y[i] != y_pred_rf[i]]
    if mis:
        lines.append("#### Misclassified Programs\n")
        lines.append("| Program | Actual | Predicted |")
        lines.append("|---------|--------|-----------|")
        for p, a, pr in mis:
            lines.append(f"| {p} | {a} | {pr} |")
        lines.append("")

    # Feature importances
    rf_full = RandomForestClassifier(n_estimators=200, max_depth=5, random_state=42)
    rf_full.fit(X, y)
    feat_imp = sorted(zip(feat_cols, rf_full.feature_importances_), key=lambda x: -x[1])
    lines.append("#### Random Forest Feature Importances\n")
    lines.append("| Rank | Feature | Importance |")
    lines.append("|------|---------|------------|")
    for i, (f, imp) in enumerate(feat_imp[:12], 1):
        lines.append(f"| {i} | {f} | {imp:.4f} |")

    # Logistic regression coefficients
    lr = LogisticRegression(max_iter=2000, random_state=42)
    lr.fit(X_scaled, y)
    coefs = sorted(zip(feat_cols, lr.coef_[0]), key=lambda x: -abs(x[1]))
    lines.append("\n#### Logistic Regression Coefficients (standardized)\n")
    lines.append("| Rank | Feature | Coeff | Direction |")
    lines.append("|------|---------|-------|-----------|")
    for i, (f, c) in enumerate(coefs[:12], 1):
        direction = "native-better +" if c > 0 else "nonnative-better +"
        lines.append(f"| {i} | {f} | {c:.4f} | {direction} |")

    # Decision tree rules
    dt = DecisionTreeClassifier(max_depth=3, random_state=42)
    dt.fit(X, y)
    tree_text = export_text(dt, feature_names=feat_cols, max_depth=3)
    lines.append("\n#### Decision Tree Rules (depth=3)\n")
    lines.append("```")
    lines.append(tree_text)
    lines.append("```")

    return "\n".join(lines)


def main():
    micro = load_microbench()
    poly = load_polybench()

    report = []
    report.append("# 二分类建模分析：native-better vs nonnative-better\n")
    report.append("> nonnative-better = similar + wasm-better\n")

    report.append("\n## Microbench\n")
    report.append(binary_cls(micro, FEATURE_COLS, "label", "Microbench (combined label)"))
    report.append(binary_cls(micro, FEATURE_COLS, "label_jit", "Microbench (JIT label)"))
    report.append(binary_cls(micro, FEATURE_COLS, "label_aot", "Microbench (AOT label)"))

    report.append("\n## PolyBench\n")
    report.append(binary_cls(poly, POLYBENCH_FEATURE_COLS, "label", "PolyBench (combined label)"))
    report.append(binary_cls(poly, POLYBENCH_FEATURE_COLS, "label_jit", "PolyBench (JIT label)"))
    report.append(binary_cls(poly, POLYBENCH_FEATURE_COLS, "label_aot", "PolyBench (AOT label)"))

    full = "\n".join(report)
    out = RESULTS / "binary_classification_report.md"
    out.write_text(full, encoding="utf-8")
    print(f"Report written to {out}")


if __name__ == "__main__":
    main()
