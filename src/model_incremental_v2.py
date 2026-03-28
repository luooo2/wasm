#!/usr/bin/env python3
"""
Model incremental analysis without sklearn/scipy.

Compare V1(22) vs V2(18) using lightweight numpy models:
1) NearestCentroid
2) GaussianNB

Outputs:
- data/results/v2_model_incremental_metrics.csv
- data/results/v2_model_incremental_summary.md
"""

from pathlib import Path
import csv
import numpy as np

ROOT = Path(__file__).parent.parent
RES = ROOT / "data" / "results"

OLD_PATH = RES / "dataset_combined.csv"
V2_PATH = RES / "dataset_combined_v2.csv"

OUT_CSV = RES / "v2_model_incremental_metrics.csv"
OUT_MD = RES / "v2_model_incremental_summary.md"

META = ["program", "native_median_ms", "wasm_median_ms", "ratio_wasm_over_native", "label"]


# ---------- IO ----------
def read_csv(path: Path):
    with path.open("r", encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def write_csv(path: Path, rows, fieldnames):
    with path.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames)
        w.writeheader()
        w.writerows(rows)


# ---------- basic preprocessing ----------
def robust_fit(X):
    med = np.median(X, axis=0)
    q1 = np.quantile(X, 0.25, axis=0)
    q3 = np.quantile(X, 0.75, axis=0)
    iqr = q3 - q1
    iqr[iqr == 0] = 1.0
    return med, iqr


def robust_transform(X, med, iqr):
    return (X - med) / iqr


# ---------- models ----------
def fit_nearest_centroid(X, y, n_classes):
    cents = np.zeros((n_classes, X.shape[1]), dtype=float)
    for c in range(n_classes):
        idx = np.where(y == c)[0]
        if len(idx) == 0:
            continue
        cents[c] = X[idx].mean(axis=0)
    return {"centroids": cents}


def pred_nearest_centroid(model, X):
    cents = model["centroids"]
    # squared euclidean
    d = ((X[:, None, :] - cents[None, :, :]) ** 2).sum(axis=2)
    return np.argmin(d, axis=1)


def fit_gnb(X, y, n_classes):
    n_features = X.shape[1]
    means = np.zeros((n_classes, n_features), dtype=float)
    vars_ = np.ones((n_classes, n_features), dtype=float)
    priors = np.zeros(n_classes, dtype=float)

    for c in range(n_classes):
        idx = np.where(y == c)[0]
        priors[c] = len(idx) / max(len(y), 1)
        if len(idx) == 0:
            continue
        xc = X[idx]
        means[c] = xc.mean(axis=0)
        v = xc.var(axis=0)
        v[v < 1e-9] = 1e-9
        vars_[c] = v

    return {"means": means, "vars": vars_, "priors": priors}


def pred_gnb(model, X):
    means = model["means"]
    vars_ = model["vars"]
    priors = model["priors"]
    n_classes = means.shape[0]

    logp = np.zeros((X.shape[0], n_classes), dtype=float)
    for c in range(n_classes):
        # log N(x|mu,var) + log prior
        ll = -0.5 * np.sum(np.log(2 * np.pi * vars_[c]) + ((X - means[c]) ** 2) / vars_[c], axis=1)
        lp = np.log(max(priors[c], 1e-12))
        logp[:, c] = ll + lp
    return np.argmax(logp, axis=1)


# ---------- CV and metrics ----------
def stratified_kfold_indices(y, n_splits=3, seed=42):
    rng = np.random.default_rng(seed)
    classes = np.unique(y)
    per_class = {}
    for c in classes:
        idx = np.where(y == c)[0].copy()
        rng.shuffle(idx)
        per_class[c] = np.array_split(idx, n_splits)

    folds = []
    all_idx = np.arange(len(y))
    for k in range(n_splits):
        test_parts = [per_class[c][k] for c in classes]
        test_idx = np.concatenate(test_parts)
        train_mask = np.ones(len(y), dtype=bool)
        train_mask[test_idx] = False
        train_idx = all_idx[train_mask]
        folds.append((train_idx, test_idx))
    return folds


def confusion(y_true, y_pred, n_classes):
    cm = np.zeros((n_classes, n_classes), dtype=int)
    for t, p in zip(y_true, y_pred):
        cm[t, p] += 1
    return cm


def f1_scores_from_cm(cm):
    n_classes = cm.shape[0]
    f1s = []
    supports = []
    for c in range(n_classes):
        tp = cm[c, c]
        fp = cm[:, c].sum() - tp
        fn = cm[c, :].sum() - tp
        support = cm[c, :].sum()
        supports.append(support)

        precision = tp / (tp + fp) if (tp + fp) > 0 else 0.0
        recall = tp / (tp + fn) if (tp + fn) > 0 else 0.0
        f1 = 2 * precision * recall / (precision + recall) if (precision + recall) > 0 else 0.0
        f1s.append(f1)

    macro = float(np.mean(f1s))
    total = max(sum(supports), 1)
    weighted = float(sum(f * s for f, s in zip(f1s, supports)) / total)
    return f1s, macro, weighted


def evaluate_repeated_cv(X, y, model_name, n_classes, repeats=30, n_splits=3):
    accs, macros, weighteds = [], [], []
    for r in range(repeats):
        folds = stratified_kfold_indices(y, n_splits=n_splits, seed=42 + r)
        for tr, te in folds:
            Xtr, Xte = X[tr], X[te]
            ytr, yte = y[tr], y[te]

            med, iqr = robust_fit(Xtr)
            Xtr_s = robust_transform(Xtr, med, iqr)
            Xte_s = robust_transform(Xte, med, iqr)

            if model_name == "NearestCentroid":
                model = fit_nearest_centroid(Xtr_s, ytr, n_classes)
                pred = pred_nearest_centroid(model, Xte_s)
            else:
                model = fit_gnb(Xtr_s, ytr, n_classes)
                pred = pred_gnb(model, Xte_s)

            acc = float((pred == yte).mean())
            cm = confusion(yte, pred, n_classes)
            _, macro, weighted = f1_scores_from_cm(cm)

            accs.append(acc)
            macros.append(macro)
            weighteds.append(weighted)

    return {
        "acc_mean": float(np.mean(accs)),
        "acc_std": float(np.std(accs)),
        "f1_macro_mean": float(np.mean(macros)),
        "f1_macro_std": float(np.std(macros)),
        "f1_weighted_mean": float(np.mean(weighteds)),
        "f1_weighted_std": float(np.std(weighteds)),
    }


def oof_cv(X, y, model_name, n_classes, n_splits=3):
    folds = stratified_kfold_indices(y, n_splits=n_splits, seed=123)
    pred_all = np.zeros_like(y)
    for tr, te in folds:
        Xtr, Xte = X[tr], X[te]
        ytr = y[tr]

        med, iqr = robust_fit(Xtr)
        Xtr_s = robust_transform(Xtr, med, iqr)
        Xte_s = robust_transform(Xte, med, iqr)

        if model_name == "NearestCentroid":
            model = fit_nearest_centroid(Xtr_s, ytr, n_classes)
            pred = pred_nearest_centroid(model, Xte_s)
        else:
            model = fit_gnb(Xtr_s, ytr, n_classes)
            pred = pred_gnb(model, Xte_s)

        pred_all[te] = pred
    return pred_all


def fmt(ms: dict, key: str):
    return f"{ms[key + '_mean']:.3f} ± {ms[key + '_std']:.3f}"


def build_matrix(rows, features):
    return np.array([[float(r[c]) for c in features] for r in rows], dtype=float)


def main():
    old_rows = read_csv(OLD_PATH)
    v2_rows = read_csv(V2_PATH)

    old_by_prog = {r["program"]: r for r in old_rows}
    v2_rows = sorted(v2_rows, key=lambda r: r["program"])
    old_rows = [old_by_prog[r["program"]] for r in v2_rows]

    old_features = [c for c in old_rows[0].keys() if c not in META]
    v2_features = [c for c in v2_rows[0].keys() if c not in META]

    labels = [r["label"] for r in v2_rows]
    cls_names = sorted(set(labels))
    cls_to_id = {c: i for i, c in enumerate(cls_names)}
    y = np.array([cls_to_id[l] for l in labels], dtype=int)
    n_classes = len(cls_names)

    X_old = build_matrix(old_rows, old_features)
    X_v2 = build_matrix(v2_rows, v2_features)

    models = ["NearestCentroid", "GaussianNB"]

    metrics_rows = []
    collect = {}

    for m in models:
        r_old = evaluate_repeated_cv(X_old, y, m, n_classes)
        r_v2 = evaluate_repeated_cv(X_v2, y, m, n_classes)

        metrics_rows.append({"model": m, "feature_set": "V1(22)", **r_old})
        metrics_rows.append({"model": m, "feature_set": "V2(18)", **r_v2})

        collect[(m, "old")] = r_old
        collect[(m, "v2")] = r_v2

    write_csv(
        OUT_CSV,
        metrics_rows,
        [
            "model", "feature_set",
            "acc_mean", "acc_std",
            "f1_macro_mean", "f1_macro_std",
            "f1_weighted_mean", "f1_weighted_std",
        ],
    )

    # OOF details for V2 + NearestCentroid
    pred = oof_cv(X_v2, y, "NearestCentroid", n_classes, n_splits=3)
    cm = confusion(y, pred, n_classes)
    f1_per_cls, macro, weighted = f1_scores_from_cm(cm)

    nc_old = collect[("NearestCentroid", "old")]
    nc_v2 = collect[("NearestCentroid", "v2")]
    nb_old = collect[("GaussianNB", "old")]
    nb_v2 = collect[("GaussianNB", "v2")]

    lines = []
    lines.append("## 5) 基于 V2 特征的模型增量分析")
    lines.append("")
    lines.append("评估设置：`Repeated Stratified 3-fold × 30`（纯 numpy 实现），模型为 `NearestCentroid` 与 `GaussianNB`。")
    lines.append("")
    lines.append("### 5.1 V1(22特征) vs V2(18特征) 对比")
    lines.append("")
    lines.append("| 模型 | 特征集 | Accuracy | Macro-F1 | Weighted-F1 |")
    lines.append("|---|---|---:|---:|---:|")
    lines.append(f"| NearestCentroid | V1(22) | {fmt(nc_old, 'acc')} | {fmt(nc_old, 'f1_macro')} | {fmt(nc_old, 'f1_weighted')} |")
    lines.append(f"| NearestCentroid | V2(18) | {fmt(nc_v2, 'acc')} | {fmt(nc_v2, 'f1_macro')} | {fmt(nc_v2, 'f1_weighted')} |")
    lines.append(f"| GaussianNB | V1(22) | {fmt(nb_old, 'acc')} | {fmt(nb_old, 'f1_macro')} | {fmt(nb_old, 'f1_weighted')} |")
    lines.append(f"| GaussianNB | V2(18) | {fmt(nb_v2, 'acc')} | {fmt(nb_v2, 'f1_macro')} | {fmt(nb_v2, 'f1_weighted')} |")
    lines.append("")

    lines.append("### 5.2 V2(NearestCentroid) 3折OOF混淆矩阵")
    lines.append("")
    lines.append("标签顺序：" + ", ".join(cls_names))
    lines.append("")
    lines.append("```text")
    lines.append(np.array2string(cm))
    lines.append("```")
    lines.append("")

    lines.append("### 5.3 V2(NearestCentroid) 分类指标（3折OOF）")
    lines.append("")
    lines.append("| class | F1 |")
    lines.append("|---|---:|")
    for c, f1 in zip(cls_names, f1_per_cls):
        lines.append(f"| {c} | {f1:.3f} |")
    lines.append(f"| macro avg | {macro:.3f} |")
    lines.append(f"| weighted avg | {weighted:.3f} |")
    lines.append("")

    lines.append("### 5.4 增量结论")
    lines.append("")
    delta_macro = nc_v2["f1_macro_mean"] - nc_old["f1_macro_mean"]
    delta_acc = nc_v2["acc_mean"] - nc_old["acc_mean"]
    lines.append(f"- NearestCentroid: Accuracy Δ={delta_acc:+.3f}, Macro-F1 Δ={delta_macro:+.3f}")
    lines.append("- 由于类别极不平衡（native-better 占多数），建议优先关注 Macro-F1 的变化。")
    lines.append("")
    lines.append(f"明细CSV：`{OUT_CSV.as_posix()}`")

    OUT_MD.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"wrote: {OUT_CSV}")
    print(f"wrote: {OUT_MD}")


if __name__ == "__main__":
    main()
