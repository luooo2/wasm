#!/usr/bin/env python3
"""
Plot one comparative figure per LLVM perf metric.

Input:
  data/results/perf_llvm/perf_raw_events_llvm.csv

Output:
  data/results/figures/llvm/*.png
"""

from __future__ import annotations

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


ROOT = Path(__file__).resolve().parents[4]
INPUT_CSV = ROOT / "data/results/perf_llvm/perf_raw_events_llvm.csv"
OUT_DIR = ROOT / "data/results/figures/llvm"
OUT_RATIO_TABLE = OUT_DIR / "llvm_metric_ratios_table.csv"

EVENT_LABELS = {
    "r81d0": "All Loads Retired",
    "r82d0": "All Stores Retired",
    "r00c4": "Branches Retired",
    "r01c4": "Conditional Branches",
    "r1c0": "Instructions Retired",
    "cpu-cycles": "CPU Cycles",
    "L1-icache-load-misses": "L1 I-Cache Load Misses",
    "branch-misses": "Branch Misses",
}

MODE_DISPLAY = {"wasm-jit": "wasm-jit", "wasm-aot": "wasm-aot"}
MODE_COLORS = {"wasm-jit": "#f5a623", "wasm-aot": "#2ca02c"}


def _safe_filename(text: str) -> str:
    return "".join(ch.lower() if ch.isalnum() else "_" for ch in text).strip("_")


def build_ratio_table(df_event: pd.DataFrame) -> pd.DataFrame:
    # Median over repeats for each program + mode.
    pivot = (
        df_event.groupby(["program", "mode"], as_index=False)["value"]
        .median()
        .pivot(index="program", columns="mode", values="value")
    )
    pivot = pivot.dropna(subset=["native", "wasm-jit", "wasm-aot"]).copy()
    pivot["ratio_jit"] = pivot["wasm-jit"] / pivot["native"]
    pivot["ratio_aot"] = pivot["wasm-aot"] / pivot["native"]
    out = pivot[["ratio_jit", "ratio_aot"]].sort_values(
        by=["ratio_jit", "ratio_aot"], ascending=False
    )
    return out


def plot_event(event: str, label: str, ratios: pd.DataFrame) -> Path:
    programs = ratios.index.tolist()
    x = np.arange(len(programs))
    width = 0.38

    plt.style.use("ggplot")
    fig, ax = plt.subplots(figsize=(16, 6))
    ax.bar(
        x - width / 2,
        ratios["ratio_jit"].values,
        width,
        color=MODE_COLORS["wasm-jit"],
        label=MODE_DISPLAY["wasm-jit"],
    )
    ax.bar(
        x + width / 2,
        ratios["ratio_aot"].values,
        width,
        color=MODE_COLORS["wasm-aot"],
        label=MODE_DISPLAY["wasm-aot"],
    )

    ax.axhline(1.0, color="#555555", linewidth=1.2)
    ax.set_ylabel("Sampled value ratio (native = 1.0)")
    ax.set_xlabel("Program")
    ax.set_title(f"{label} — LLVM Direct Benchmarks")
    ax.set_xticks(x)
    ax.set_xticklabels(programs, rotation=55, ha="right", fontsize=8)
    ax.legend(loc="upper center", ncol=2, frameon=True)
    fig.tight_layout()

    out_path = OUT_DIR / f"metric_{_safe_filename(label)}.png"
    fig.savefig(out_path, dpi=180)
    plt.close(fig)
    return out_path


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    df = pd.read_csv(INPUT_CSV)
    df = df[df["status"] == "ok"].copy()
    df["value"] = pd.to_numeric(df["value"], errors="coerce")
    df = df.dropna(subset=["value"])

    events = [e for e in EVENT_LABELS if e in set(df["event"].unique())]
    generated: list[Path] = []
    ratio_tables: list[pd.DataFrame] = []
    for event in events:
        dfe = df[df["event"] == event]
        ratios = build_ratio_table(dfe)
        if ratios.empty:
            continue
        generated.append(plot_event(event, EVENT_LABELS[event], ratios))
        label_slug = _safe_filename(EVENT_LABELS[event])
        cols = {
            "ratio_jit": f"{label_slug}__wasm_jit_over_native",
            "ratio_aot": f"{label_slug}__wasm_aot_over_native",
        }
        ratio_tables.append(ratios.rename(columns=cols))

    if ratio_tables:
        merged = ratio_tables[0]
        for t in ratio_tables[1:]:
            merged = merged.join(t, how="outer")
        merged = merged.reset_index().rename(columns={"index": "program"})
        merged = merged.sort_values("program")
        merged.to_csv(OUT_RATIO_TABLE, index=False)

    print(f"Generated {len(generated)} figures in: {OUT_DIR}")
    for p in generated:
        print(f"- {p.name}")
    if ratio_tables:
        print(f"- {OUT_RATIO_TABLE.name}")


if __name__ == "__main__":
    main()

