"""
Generate thesis figures per assets/数据展示指导.md:
  Fig1: Box plot — Micro/Poly × JIT/AOT ratio distributions
  Fig2: Scatter — PolyBench ls_ratio vs ratio_jit_over_native (colored by label)
  Fig3: Horizontal bar — PolyBench binary RF classifier feature importance top-8
"""
from __future__ import annotations

from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy import stats

ROOT = Path(__file__).resolve().parents[1]
RESULTS = ROOT / "data" / "results"
OUT_DIR = RESULTS / "figures"
OUT_DIR.mkdir(parents=True, exist_ok=True)

# Chinese labels for publication; fallback on Windows fonts
plt.rcParams["font.sans-serif"] = ["Microsoft YaHei", "SimHei", "DejaVu Sans"]
plt.rcParams["axes.unicode_minus"] = False


def load_micro_ratios() -> tuple[pd.Series, pd.Series]:
    p = RESULTS / "labels_microbench_internal.csv"
    df = pd.read_csv(p)
    return df["ratio_jit_over_native"], df["ratio_aot_over_native"]


def load_poly_ratios() -> tuple[pd.Series, pd.Series]:
    p = RESULTS / "polybench_summary.csv"
    df = pd.read_csv(p)
    return df["ratio_jit_over_native"], df["ratio_aot_over_native"]


def figure1_boxplot() -> Path:
    jit_m, aot_m = load_micro_ratios()
    jit_p, aot_p = load_poly_ratios()
    data = [jit_m.values, aot_m.values, jit_p.values, aot_p.values]
    labels = ["Micro-JIT", "Micro-AOT", "Poly-JIT", "Poly-AOT"]

    fig, ax = plt.subplots(figsize=(9, 5.5))
    bp = ax.boxplot(
        data,
        labels=labels,
        patch_artist=True,
        medianprops=dict(color="darkred", linewidth=2),
    )
    colors = ["#4C72B0", "#55A868", "#C44E52", "#8172B3"]
    for patch, c in zip(bp["boxes"], colors):
        patch.set_facecolor(c)
        patch.set_alpha(0.55)

    ax.axhline(1.0, color="crimson", linestyle="--", linewidth=1.2, alpha=0.85, label="ratio = 1")
    ax.set_yscale("log")
    ax.set_ylabel("Wasm / Native 时间比（中位数）")
    ax.set_xlabel("数据集与执行模式")
    ax.set_title("图1  MicroBench 与 PolyBench 的 Wasm/native 时间比分布（箱线图）")
    ax.legend(loc="upper right", framealpha=0.9)
    ax.grid(True, axis="y", linestyle=":", alpha=0.5)
    fig.tight_layout()
    out = OUT_DIR / "thesis_fig01_ratio_boxplot.png"
    fig.savefig(out, dpi=200, bbox_inches="tight")
    plt.close(fig)
    return out


def figure2_scatter() -> Path:
    summ = pd.read_csv(RESULTS / "polybench_summary.csv")
    kern = pd.read_csv(RESULTS / "dataset_polybench_kernel.csv")
    df = summ.merge(kern[["program", "ls_ratio"]], on="program", how="left")
    if df["ls_ratio"].isna().any():
        missing = df.loc[df["ls_ratio"].isna(), "program"].tolist()
        raise RuntimeError(f"Missing ls_ratio for: {missing}")

    x = df["ls_ratio"].values
    y = df["ratio_jit_over_native"].values
    rho, pval = stats.spearmanr(x, y)

    color_map = {
        "native-better": "#C44E52",
        "similar": "#4C72B0",
        "wasm-better": "#55A868",
    }
    fig, ax = plt.subplots(figsize=(8.5, 6))
    for lab in ["native-better", "similar", "wasm-better"]:
        m = df["label_jit"] == lab
        ax.scatter(
            df.loc[m, "ls_ratio"],
            df.loc[m, "ratio_jit_over_native"],
            c=color_map[lab],
            s=55,
            alpha=0.85,
            edgecolors="white",
            linewidths=0.6,
            label=lab,
        )

    # Trend line (linear on original scale, for visualization)
    coef = np.polyfit(x, y, 1)
    xs = np.linspace(x.min(), x.max(), 100)
    ax.plot(xs, np.poly1d(coef)(xs), color="gray", linestyle="-", linewidth=1.5, alpha=0.75, label="线性拟合（示意）")

    ax.axhline(1.0, color="black", linestyle=":", alpha=0.45)
    ax.set_xlabel("ls_ratio（LLVM IR 中访存指令占比）")
    ax.set_ylabel("ratio_jit_over_native")
    ax.set_title(
        "图2  PolyBench：访存占比与 Wasm JIT / native 时间比\n"
        f"Spearman ρ = {rho:.3f}，p = {pval:.4f}"
    )
    ax.legend(loc="best", framealpha=0.92)
    ax.grid(True, linestyle=":", alpha=0.45)
    fig.tight_layout()
    out = OUT_DIR / "thesis_fig02_ls_ratio_scatter.png"
    fig.savefig(out, dpi=200, bbox_inches="tight")
    plt.close(fig)
    return out


def figure3_feature_importance() -> Path:
    # From data/results/binary_classification_report.md — PolyBench combined-label
    # Random Forest (n=100, depth=4) feature importances (top 8)
    rows = [
        ("ls_ratio", 0.1409),
        ("compute_mem_ratio", 0.1225),
        ("br_density", 0.1016),
        ("call_density", 0.0923),
        ("compute_density", 0.0851),
        ("avg_bb_size", 0.0835),
        ("call_bb_ratio", 0.0772),
        ("mem_instr_count", 0.0654),
    ]
    names = [r[0] for r in rows][::-1]
    vals = [r[1] for r in rows][::-1]
    labels_pct = [f"{v * 100:.1f}%" for v in vals]

    fig, ax = plt.subplots(figsize=(8.5, 5))
    y_pos = np.arange(len(names))
    bars = ax.barh(y_pos, [v * 100 for v in vals], color="#4C72B0", alpha=0.85, height=0.65)
    ax.set_yticks(y_pos)
    ax.set_yticklabels(names)
    ax.set_xlabel("特征重要性（%）")
    ax.set_title("图3  PolyBench 二分类随机森林分类器特征重要性 Top-8")

    for bar, pct in zip(bars, labels_pct):
        w = bar.get_width()
        ax.text(w + 0.35, bar.get_y() + bar.get_height() / 2, pct, va="center", fontsize=10)

    ax.set_xlim(0, max(v * 100 for v in vals) * 1.35)
    ax.grid(True, axis="x", linestyle=":", alpha=0.5)
    fig.tight_layout()
    out = OUT_DIR / "thesis_fig03_rf_importance_barh2.png"
    fig.savefig(out, dpi=200, bbox_inches="tight")
    plt.close(fig)
    return out


def main() -> None:
    paths = [
        figure1_boxplot(),
        figure2_scatter(),
        figure3_feature_importance(),
    ]
    for p in paths:
        print(f"Wrote {p}")
    # Also copy to assets/images for thesis markdown convenience
    assets_img = ROOT / "assets" / "images" / "thesis_figures"
    assets_img.mkdir(parents=True, exist_ok=True)
    for p in paths:
        dest = assets_img / p.name
        dest.write_bytes(p.read_bytes())
        print(f"Copied -> {dest}")


if __name__ == "__main__":
    main()
