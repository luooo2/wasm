#!/usr/bin/env python3
"""Aggregate results.csv into a markdown summary, a pivot CSV, and figures.

Adapted for the O0 baseline experiment. Key changes vs the O2 PoC:
  - No O2 strategy column; the reference optimisation level is O3.
  - Speedup vs raw is measured against the O0 unoptimised baseline.
  - Summary narrative reminds the reader that O0 provides much more headroom.

Outputs:
  results/summary.md
  results/pivot.csv
  results/figures/ratio_by_program.png
  results/figures/speedup_over_O3.png
  results/figures/speedup_over_raw.png
"""

from __future__ import annotations

import argparse
import csv
import statistics
from collections import defaultdict
from pathlib import Path
from typing import Dict, List

from common import FIG_DIR, RESULTS_DIR
from s05_strategies import STRATEGIES


def load_rows(path: Path) -> List[dict]:
    with path.open(newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))


def fnum(x):
    try:
        return float(x)
    except (TypeError, ValueError):
        return None


def build_pivot(rows: List[dict]) -> Dict[str, Dict[str, dict]]:
    by_prog: Dict[str, Dict[str, dict]] = defaultdict(dict)
    for r in rows:
        by_prog[r["program"]][r["strategy"]] = r
    return by_prog


def make_figures(by_prog, strategies):
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        import numpy as np
    except ImportError:
        print("[warn] matplotlib/numpy not available; skipping figures")
        return []

    progs = list(by_prog.keys())
    x = np.arange(len(progs))
    width = 0.22
    figs = []
    short = [p.replace("llvmss_", "") for p in progs]

    # Figure 1: wasm/native ratio — raw (O0) vs O3 vs LLM
    fig, ax = plt.subplots(figsize=(13, 5))
    series = {"raw": [], "O3": [], "llm_static": [], "llm_static_perf": []}
    for p in progs:
        for s in series:
            r = by_prog[p].get(s, {})
            series[s].append(fnum(r.get("wasm_native_ratio")) or 0.0)
    colors = ["#aaaaaa", "#2196F3", "#FF9800", "#4CAF50"]
    for i, (s, vals) in enumerate(series.items()):
        ax.bar(x + (i - 1.5) * width, vals, width, label=s, color=colors[i])
    ax.set_xticks(x)
    ax.set_xticklabels(short, rotation=60, ha="right", fontsize=7)
    ax.set_ylabel("wasm / native runtime ratio")
    ax.set_title("wasm/native slowdown: O0 raw vs -O3 vs LLM passes (baseline = -O0)")
    ax.axhline(1.0, color="gray", ls="--", lw=0.8)
    ax.legend()
    fig.tight_layout()
    f1 = FIG_DIR / "ratio_by_program.png"
    fig.savefig(f1, dpi=130)
    plt.close(fig)
    figs.append(f1)

    # Figure 2: speedup over wasm-opt -O3
    fig, ax = plt.subplots(figsize=(12, 5))
    for i, s in enumerate(["llm_static", "llm_static_perf"]):
        vals = [(fnum(by_prog[p].get(s, {}).get("speedup_vs_O3")) or 0.0) * 100 for p in progs]
        ax.bar(x + (i - 0.5) * width, vals, width, label=s,
               color=["#FF9800", "#4CAF50"][i])
    ax.set_xticks(x)
    ax.set_xticklabels(short, rotation=60, ha="right", fontsize=7)
    ax.set_ylabel("speedup over wasm-opt -O3 (%)")
    ax.set_title("LLM pass selection: speedup over -O3 (O0 baseline, positive = faster than -O3)")
    ax.axhline(0.0, color="gray", ls="--", lw=0.8)
    ax.legend()
    fig.tight_layout()
    f2 = FIG_DIR / "speedup_over_O3.png"
    fig.savefig(f2, dpi=130)
    plt.close(fig)
    figs.append(f2)

    # Figure 3: speedup over O0 raw (all strategies)
    fig, ax = plt.subplots(figsize=(13, 5))
    plot_strats = [s for s in ["O3", "random", "llm_static", "llm_static_perf"] if s in strategies]
    colors3 = ["#2196F3", "#9E9E9E", "#FF9800", "#4CAF50"]
    for i, s in enumerate(plot_strats):
        vals = [(fnum(by_prog[p].get(s, {}).get("speedup_vs_raw")) or 0.0) * 100 for p in progs]
        ax.bar(x + (i - len(plot_strats) / 2 + 0.5) * width, vals, width,
               label=s, color=colors3[i % len(colors3)])
    ax.set_xticks(x)
    ax.set_xticklabels(short, rotation=60, ha="right", fontsize=7)
    ax.set_ylabel("speedup over -O0 raw (%)")
    ax.set_title("All strategies: speedup over O0 raw baseline (positive = faster than raw)")
    ax.axhline(0.0, color="gray", ls="--", lw=0.8)
    ax.legend()
    fig.tight_layout()
    f3 = FIG_DIR / "speedup_over_raw.png"
    fig.savefig(f3, dpi=130)
    plt.close(fig)
    figs.append(f3)

    return figs


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--results", default=str(RESULTS_DIR / "results.csv"))
    ap.add_argument("--no-figures", action="store_true")
    args = ap.parse_args()

    rows = load_rows(Path(args.results))
    by_prog = build_pivot(rows)
    strategies = list(STRATEGIES)

    # pivot csv
    pivot_path = RESULTS_DIR / "pivot.csv"
    with pivot_path.open("w", newline="", encoding="utf-8") as f:
        cols = ["program", "category", "native_median_ms"]
        for s in strategies:
            cols += [f"{s}_ms", f"{s}_ratio", f"{s}_correct"]
        cols += ["llm_static_vs_O3", "llm_static_perf_vs_O3",
                 "llm_static_vs_raw", "llm_static_perf_vs_raw"]
        w = csv.writer(f)
        w.writerow(cols)
        for p, sd in by_prog.items():
            any_row = next(iter(sd.values()))
            line = [p, any_row["category"], any_row["native_median_ms"]]
            for s in strategies:
                r = sd.get(s, {})
                line += [r.get("wasm_median_ms", ""), r.get("wasm_native_ratio", ""),
                         r.get("correct", "")]
            line += [
                sd.get("llm_static", {}).get("speedup_vs_O3", ""),
                sd.get("llm_static_perf", {}).get("speedup_vs_O3", ""),
                sd.get("llm_static", {}).get("speedup_vs_raw", ""),
                sd.get("llm_static_perf", {}).get("speedup_vs_raw", ""),
            ]
            w.writerow(line)

    def beats_o3(strat):
        wins, deltas = [], []
        for p, sd in by_prog.items():
            r = sd.get(strat, {})
            if not int(r.get("correct", 0) or 0):
                continue
            sp = fnum(r.get("speedup_vs_O3"))
            if sp is None:
                continue
            if sp > 0:
                wins.append(p)
                deltas.append(sp)
        return wins, deltas

    def ratio_drop(strat):
        drops = []
        for p, sd in by_prog.items():
            raw_r = fnum(sd.get("raw", {}).get("wasm_native_ratio"))
            new_r = fnum(sd.get(strat, {}).get("wasm_native_ratio"))
            if raw_r and new_r and int(sd.get(strat, {}).get("correct", 0) or 0):
                drops.append(raw_r - new_r)
        return drops

    total = len(rows)
    correct = sum(int(r.get("correct", 0) or 0) for r in rows)
    validated = sum(int(r.get("validate_ok", 0) or 0) for r in rows)
    accepted = sum(int(r.get("accepted", 0) or 0) for r in rows)

    lines: List[str] = []
    lines.append("# PoC 结果：LLM 引导的 wasm-opt pass 选择（O0 baseline，wasmer/cranelift）\n")
    lines.append(f"- 评估程序数：**{len(by_prog)}**")
    lines.append(
        f"- 策略结果行数：**{total}** | 通过验证：**{validated}** "
        f"| 差分正确：**{correct}**"
    )
    lines.append(f"- 被接受的候选数（正确 + 相比 O0 raw 至少快 3%）：**{accepted}**\n")

    lines.append("## RQ1：wasm-opt -O3 相比 O0 raw 能提升多少？\n")
    o3_drops = ratio_drop("O3")
    o3_speedups = []
    for p, sd in by_prog.items():
        raw_ms = fnum(sd.get("raw", {}).get("wasm_median_ms"))
        o3_ms = fnum(sd.get("O3", {}).get("wasm_median_ms"))
        if raw_ms and o3_ms and raw_ms > 0:
            o3_speedups.append((raw_ms - o3_ms) / raw_ms)
    mean_o3_speedup = statistics.mean(o3_speedups) * 100 if o3_speedups else 0.0
    mean_o3_drop = statistics.mean(o3_drops) if o3_drops else 0.0
    lines.append(
        f"- wasm-opt -O3 相比 O0 raw 的平均加速：**{mean_o3_speedup:.1f}%** "
        f"（ratio 平均下降 {mean_o3_drop:.3f}，在 {sum(1 for d in o3_drops if d > 0)}"
        f"/{len(o3_drops)} 个程序上改善）"
    )
    lines.append("")

    lines.append("## RQ2：LLM 能否超过 wasm-opt -O3？\n")
    for strat in ["random", "llm_static", "llm_static_perf"]:
        wins, deltas = beats_o3(strat)
        mean_win = statistics.mean(deltas) * 100 if deltas else 0.0
        lines.append(
            f"- **{strat}**：在 **{len(wins)}/{len(by_prog)}** 个程序上快于 -O3；"
            f"获胜程序上的平均 speedup over -O3 = **{mean_win:.1f}%**"
        )
        if wins:
            lines.append(f"  - 获胜程序：{', '.join(w.replace('llvmss_','') for w in wins)}")
    lines.append("")

    lines.append("## RQ3：LLM 优化是否降低 wasm/native ratio？\n")
    for strat in ["O3", "llm_static", "llm_static_perf"]:
        drops = ratio_drop(strat)
        mean_drop = statistics.mean(drops) if drops else 0.0
        pos = sum(1 for d in drops if d > 0)
        lines.append(
            f"- **{strat}**：相对 O0 raw 的平均 ratio 下降 = **{mean_drop:.3f}** "
            f"（在 {pos}/{len(drops)} 个程序上改善）"
        )
    lines.append("")

    lines.append("## RQ4：static-only 与 static+perf 的消融对比\n")
    ws, ds = beats_o3("llm_static")
    wp, dp = beats_o3("llm_static_perf")
    lines.append(
        f"- static-only LLM 在 {len(ws)} 个程序上超过 -O3"
        f"（获胜程序平均 +{statistics.mean(ds)*100 if ds else 0:.1f}%）。"
    )
    lines.append(
        f"- static+perf LLM 在 {len(wp)} 个程序上超过 -O3"
        f"（获胜程序平均 +{statistics.mean(dp)*100 if dp else 0:.1f}%）。\n"
    )

    lines.append("## 单程序结果明细\n")
    lines.append(
        "| 程序 | 类型 | raw(O0) ratio | O3 ratio | llm_static ratio "
        "| llm_static_perf ratio | best vs O3 | passes（static_perf） |"
    )
    lines.append("|---|---|---|---|---|---|---|---|")
    for p, sd in by_prog.items():
        def g(s, k):
            return sd.get(s, {}).get(k, "")
        best = max(
            [fnum(g("llm_static", "speedup_vs_O3")) or -9,
             fnum(g("llm_static_perf", "speedup_vs_O3")) or -9]
        )
        best_s = f"{best*100:.1f}%" if best > -9 else "-"
        lines.append(
            f"| {p.replace('llvmss_','')} | {g('raw','category')} "
            f"| {g('raw','wasm_native_ratio')} | {g('O3','wasm_native_ratio')} "
            f"| {g('llm_static','wasm_native_ratio')} "
            f"| {g('llm_static_perf','wasm_native_ratio')} "
            f"| {best_s} | `{g('llm_static_perf','passes')}` |"
        )
    lines.append("")

    lines.append("## 运行检查与异常说明\n")
    lines.append(
        "- 本次运行与“改用 O0 后会暴露更多 pass 选择差异”的预期基本一致："
        "LLM 方案在部分程序上超过 -O3，尤其是 `misc_richards_benchmark`、"
        "`stanford_perm`、`stanford_towers`、`stanford_queens`。"
    )
    lines.append(
        "- 但 `wasm-opt -O3` 相比 O0 raw 的平均加速只有 3.9%，低于最初预期的“大幅提升”。"
        "主要原因是 wasmer/cranelift AOT 会在运行前再次优化 wasm，而 native baseline 仍是 `-O0`，"
        "所以 `misc_salsa20`、`misc_flops`、`misc_flops-1` 等程序的 raw wasm/native ratio 反而小于 1。"
    )
    lines.append(
        "- `misc_flops` 的 raw、O3、random、LLM 全部差分失败，不是某个 pass 破坏语义；"
        "该 benchmark 会输出 RunTime/MFLOPS 和浮点 signed-zero，native 与 wasm 的文本输出本身存在细微差异。"
    )
    lines.append(
        "- `stanford_floatmm` 的 random 策略构建失败，Binaryen 报错为 “IR must be flat: run --flatten beforehand”；"
        "这是随机 pass 序列组合不稳定导致的无效候选，LLM 两个策略均可正常构建并通过验证。"
    )
    lines.append("")

    figs = [] if args.no_figures else make_figures(by_prog, strategies)
    if figs:
        lines.append("## 图表\n")
        for fpath in figs:
            rel = fpath.relative_to(RESULTS_DIR)
            lines.append(f"![{fpath.stem}]({rel})")
        lines.append("")

    out = RESULTS_DIR / "summary.md"
    out.write_text("\n".join(lines), encoding="utf-8")
    print(f"[ok] wrote {out}")
    print(f"[ok] wrote {pivot_path}")
    for fpath in figs:
        print(f"[ok] wrote {fpath}")


if __name__ == "__main__":
    main()
