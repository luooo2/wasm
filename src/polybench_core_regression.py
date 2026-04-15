from pathlib import Path
import csv

ROOT = Path(r"c:\Users\86187\Desktop\graduation project\wasm")
FIG_DIR = ROOT / "data/results/figures"
SUMMARY_PATH = ROOT / "data/results/polybench_core_regression_summary.md"
FEATURES = ["compute_density", "ls_ratio", "compute_mem_ratio"]


def load_csv(path: Path):
    with open(path, encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def solve_linear_system(A, b):
    n = len(A)
    M = [row[:] + [val] for row, val in zip(A, b)]
    for col in range(n):
        pivot = max(range(col, n), key=lambda r: abs(M[r][col]))
        if abs(M[pivot][col]) < 1e-12:
            return None
        M[col], M[pivot] = M[pivot], M[col]
        pv = M[col][col]
        for j in range(col, n + 1):
            M[col][j] /= pv
        for r in range(n):
            if r == col:
                continue
            factor = M[r][col]
            if factor == 0:
                continue
            for j in range(col, n + 1):
                M[r][j] -= factor * M[col][j]
    return [M[i][n] for i in range(n)]


def fit_linear(rows, ratio_field):
    X = []
    y = []
    for r in rows:
        X.append([1.0] + [float(r[f]) for f in FEATURES])
        y.append(float(r[ratio_field]))
    p = len(X[0])
    XtX = [[0.0] * p for _ in range(p)]
    Xty = [0.0] * p
    for xi, yi in zip(X, y):
        for i in range(p):
            Xty[i] += xi[i] * yi
            for j in range(p):
                XtX[i][j] += xi[i] * xi[j]
    beta = solve_linear_system(XtX, Xty)
    yhat = [sum(b * v for b, v in zip(beta, xi)) for xi in X]
    mean_y = sum(y) / len(y)
    ss_res = sum((a - b) ** 2 for a, b in zip(y, yhat))
    ss_tot = sum((a - mean_y) ** 2 for a in y)
    r2 = 0.0 if ss_tot == 0 else 1 - ss_res / ss_tot
    adj = 1 - (1 - r2) * (len(y) - 1) / (len(y) - len(FEATURES) - 1)
    return beta, y, yhat, r2, adj


def loocv(rows, ratio_field):
    preds = []
    actual = []
    n = len(rows)
    for i in range(n):
        train = [r for j, r in enumerate(rows) if j != i]
        test = rows[i]
        beta, _, _, _, _ = fit_linear(train, ratio_field)
        x = [1.0] + [float(test[f]) for f in FEATURES]
        preds.append(sum(b * v for b, v in zip(beta, x)))
        actual.append(float(test[ratio_field]))
    mean_y = sum(actual) / len(actual)
    ss_res = sum((a - b) ** 2 for a, b in zip(actual, preds))
    ss_tot = sum((a - mean_y) ** 2 for a in actual)
    q2 = 0.0 if ss_tot == 0 else 1 - ss_res / ss_tot
    mae = sum(abs(a - b) for a, b in zip(actual, preds)) / len(actual)
    rmse = (sum((a - b) ** 2 for a, b in zip(actual, preds)) / len(actual)) ** 0.5
    return actual, preds, mae, rmse, q2


def merge_rows():
    feat = load_csv(ROOT / "data/results/dataset_polybench_kernel.csv")
    perf = load_csv(ROOT / "data/results/polybench_summary.csv")
    perf_map = {r["program"]: r for r in perf}
    out = []
    for r in feat:
        p = r["program"]
        if p in perf_map:
            merged = dict(r)
            merged["ratio_jit_over_native"] = perf_map[p]["ratio_jit_over_native"]
            merged["ratio_aot_over_native"] = perf_map[p]["ratio_aot_over_native"]
            merged["label_jit"] = perf_map[p]["label_jit"]
            merged["label_aot"] = perf_map[p]["label_aot"]
            out.append(merged)
    return out


def simple_corr(xs, ys):
    mx = sum(xs) / len(xs)
    my = sum(ys) / len(ys)
    sx = (sum((x - mx) ** 2 for x in xs)) ** 0.5
    sy = (sum((y - my) ** 2 for y in ys)) ** 0.5
    if sx == 0 or sy == 0:
        return 0.0
    return sum((x - mx) * (y - my) for x, y in zip(xs, ys)) / (sx * sy)


def fit_1d(xs, ys):
    mx = sum(xs) / len(xs)
    my = sum(ys) / len(ys)
    sxx = sum((x - mx) ** 2 for x in xs)
    if sxx == 0:
        return my, 0.0
    b1 = sum((x - mx) * (y - my) for x, y in zip(xs, ys)) / sxx
    b0 = my - b1 * mx
    return b0, b1


def plot_scatter(rows, ratio_field, out_path, title):
    ys = [float(r[ratio_field]) for r in rows]
    lines = [f"# {title}", ""]
    for feat in FEATURES:
        xs = [float(r[feat]) for r in rows]
        corr = simple_corr(xs, ys)
        b0, b1 = fit_1d(xs, ys)
        lines.append(f"## {feat}")
        lines.append(f"- Pearson r: {corr:.4f}")
        lines.append(f"- Trend line: ratio = {b0:.4f} + {b1:.4f} * {feat}")
        lines.append("- Points:")
        lines.append("")
        lines.append("| program | x | ratio |")
        lines.append("|---|---:|---:|")
        for r in sorted(rows, key=lambda row: float(row[feat])):
            lines.append(f"| {r['program']} | {float(r[feat]):.6f} | {float(r[ratio_field]):.6f} |")
        lines.append("")
    out_path.write_text("\n".join(lines), encoding="utf-8")


def plot_surface(rows, ratio_field, out_path, title):
    beta, _, _, _, _ = fit_linear(rows, ratio_field)
    cm = [float(r["compute_mem_ratio"]) for r in rows]
    cm_mean = sum(cm) / len(cm)
    lines = [
        f"# {title}",
        "",
        f"Regression plane (holding compute_mem_ratio at mean={cm_mean:.6f}):",
        f"ratio = {beta[0]:.6f} + {beta[1]:.6f} * compute_density + {beta[2]:.6f} * ls_ratio + {beta[3]:.6f} * compute_mem_ratio",
        "",
        "Representative predictions on observed points:",
        "",
        "| program | compute_density | ls_ratio | compute_mem_ratio | actual_ratio | predicted_ratio |",
        "|---|---:|---:|---:|---:|---:|",
    ]
    for r in rows:
        pred = beta[0] + beta[1] * float(r['compute_density']) + beta[2] * float(r['ls_ratio']) + beta[3] * float(r['compute_mem_ratio'])
        lines.append(
            f"| {r['program']} | {float(r['compute_density']):.6f} | {float(r['ls_ratio']):.6f} | {float(r['compute_mem_ratio']):.6f} | {float(r[ratio_field]):.6f} | {pred:.6f} |"
        )
    out_path.write_text("\n".join(lines), encoding="utf-8")


def plot_pred_actual(actual, preds, out_path, title):
    lines = [
        f"# {title}",
        "",
        "| index | actual_ratio | predicted_ratio | abs_error |",
        "|---:|---:|---:|---:|",
    ]
    for idx, (a, p) in enumerate(zip(actual, preds), start=1):
        lines.append(f"| {idx} | {a:.6f} | {p:.6f} | {abs(a-p):.6f} |")
    out_path.write_text("\n".join(lines), encoding="utf-8")


def main():
    rows = merge_rows()
    metrics = {}
    for mode in ["jit", "aot"]:
        ratio_field = f"ratio_{mode}_over_native"
        beta, _, _, r2, adj = fit_linear(rows, ratio_field)
        actual, preds, mae, rmse, q2 = loocv(rows, ratio_field)
        metrics[mode] = {
            "beta": beta,
            "r2": r2,
            "adj_r2": adj,
            "mae": mae,
            "rmse": rmse,
            "q2": q2,
        }
        plot_scatter(rows, ratio_field, FIG_DIR / f"polybench_core_scatter_{mode}.md", f"PolyBench {mode.upper()} ratio vs core features")
        plot_surface(rows, ratio_field, FIG_DIR / f"polybench_core_surface_{mode}.md", f"PolyBench {mode.upper()} 3-feature regression surface")
        plot_pred_actual(actual, preds, FIG_DIR / f"polybench_core_loocv_{mode}.md", f"PolyBench {mode.upper()} LOOCV: predicted vs actual")

    lines = [
        "# PolyBench core 3-feature regression summary",
        "",
        "Core features: `compute_density`, `ls_ratio`, `compute_mem_ratio`",
        "",
    ]
    for mode in ["jit", "aot"]:
        m = metrics[mode]
        lines.extend([
            f"## {mode.upper()}",
            f"- In-sample R^2: {m['r2']:.4f}",
            f"- Adjusted R^2: {m['adj_r2']:.4f}",
            f"- LOOCV Q^2: {m['q2']:.4f}",
            f"- LOOCV MAE: {m['mae']:.4f}",
            f"- LOOCV RMSE: {m['rmse']:.4f}",
            f"- Coefficients [intercept, compute_density, ls_ratio, compute_mem_ratio]: {[round(x, 4) for x in m['beta']]}",
            "",
        ])
    SUMMARY_PATH.write_text("\n".join(lines), encoding="utf-8")
    print("saved_summary", SUMMARY_PATH)
    for mode in ["jit", "aot"]:
        m = metrics[mode]
        print(mode, {
            "r2": round(m["r2"], 4),
            "adj_r2": round(m["adj_r2"], 4),
            "q2": round(m["q2"], 4),
            "mae": round(m["mae"], 4),
            "rmse": round(m["rmse"], 4),
            "beta": [round(x, 4) for x in m["beta"]],
        })


if __name__ == "__main__":
    main()
