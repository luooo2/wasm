#!/usr/bin/env python3
"""Aggregate results.csv into a markdown summary, a pivot CSV, and figures.

Outputs:
  results/summary.md          human-readable summary answering the PoC questions
  results/pivot.csv           one row per program with each strategy's ratio/time
  results/figures/*.png       (if matplotlib available) speedup + ratio charts

Key questions answered:
  - On how many programs does each LLM variant beat wasm-opt -O3?
  - Mean speedup over O3 on the programs where it helps.
  - Does the wasm/native ratio drop after LLM optimisation?
  - Are all kept candidates correct (validation + differential test)?
"""

from __future__ import annotations

import argparse
import csv
import statistics
from collections import defaultdict
from pathlib import Path
from typing import Dict, List

from common import RESULTS_DIR, FIG_DIR
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
    figs = []
    x = np.arange(len(progs))
    width = 0.25

    # Figure 1: wasm/native ratio per program: raw vs O3 vs LLM(static+perf)
    fig, ax = plt.subplots(figsize=(12, 5))
    series = {"raw": [], "O3": [], "llm_static_perf": []}
    for p in progs:
        for s in series:
            r = by_prog[p].get(s, {})
            series[s].append(fnum(r.get("wasm_native_ratio")) or 0.0)
    for i, (s, vals) in enumerate(series.items()):
        ax.bar(x + (i - 1) * width, vals, width, label=s)
    ax.set_xticks(x)
    ax.set_xticklabels([p.replace("llvmss_", "") for p in progs], rotation=60, ha="right", fontsize=7)
    ax.set_ylabel("wasm / native runtime ratio")
    ax.set_title("wasm/native slowdown: raw vs -O3 vs LLM(static+perf)")
    ax.axhline(1.0, color="gray", ls="--", lw=0.8)
    ax.legend()
    fig.tight_layout()
    f1 = FIG_DIR / "ratio_by_program.png"
    fig.savefig(f1, dpi=130)
    plt.close(fig)
    figs.append(f1)

    # Figure 2: speedup over O3 for the two LLM variants
    fig, ax = plt.subplots(figsize=(12, 5))
    for i, s in enumerate(["llm_static", "llm_static_perf"]):
        vals = [(fnum(by_prog[p].get(s, {}).get("speedup_vs_O3")) or 0.0) * 100 for p in progs]
        ax.bar(x + (i - 0.5) * width, vals, width, label=s)
    ax.set_xticks(x)
    ax.set_xticklabels([p.replace("llvmss_", "") for p in progs], rotation=60, ha="right", fontsize=7)
    ax.set_ylabel("speedup over wasm-opt -O3 (%)")
    ax.set_title("LLM pass selection: runtime speedup over -O3 (positive = faster)")
    ax.axhline(0.0, color="gray", ls="--", lw=0.8)
    ax.legend()
    fig.tight_layout()
    f2 = FIG_DIR / "speedup_over_O3.png"
    fig.savefig(f2, dpi=130)
    plt.close(fig)
    figs.append(f2)
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
        cols += ["llm_static_vs_O3", "llm_static_perf_vs_O3"]
        w = csv.writer(f)
        w.writerow(cols)
        for p, sd in by_prog.items():
            any_row = next(iter(sd.values()))
            line = [p, any_row["category"], any_row["native_median_ms"]]
            for s in strategies:
                r = sd.get(s, {})
                line += [r.get("wasm_median_ms", ""), r.get("wasm_native_ratio", ""), r.get("correct", "")]
            line += [
                sd.get("llm_static", {}).get("speedup_vs_O3", ""),
                sd.get("llm_static_perf", {}).get("speedup_vs_O3", ""),
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
    lines.append("# PoC results: LLM-guided wasm-opt pass selection (wasmer/cranelift)\n")
    lines.append(f"- Programs evaluated: **{len(by_prog)}**")
    lines.append(f"- Strategy rows: **{total}**  | validated: **{validated}** | correct (diff-test): **{correct}**")
    lines.append(f"- Candidates accepted (correct + >=3% faster than raw): **{accepted}**\n")

    lines.append("## RQ2 - does the LLM beat wasm-opt -O3?\n")
    for strat in ["random", "llm_static", "llm_static_perf"]:
        wins, deltas = beats_o3(strat)
        mean_win = statistics.mean(deltas) * 100 if deltas else 0.0
        lines.append(
            f"- **{strat}**: faster than -O3 on **{len(wins)}/{len(by_prog)}** programs; "
            f"mean speedup over -O3 on winning programs = **{mean_win:.1f}%**"
        )
        if wins:
            lines.append(f"  - winners: {', '.join(w.replace('llvmss_','') for w in wins)}")
    lines.append("")

    lines.append("## RQ3 - does LLM optimisation lower the wasm/native ratio?\n")
    for strat in ["O3", "llm_static", "llm_static_perf"]:
        drops = ratio_drop(strat)
        mean_drop = statistics.mean(drops) if drops else 0.0
        pos = sum(1 for d in drops if d > 0)
        lines.append(
            f"- **{strat}**: mean ratio reduction vs raw = **{mean_drop:.3f}** "
            f"(improved on {pos}/{len(drops)} programs)"
        )
    lines.append("")

    lines.append("## RQ4 - static-only vs static+perf (ablation)\n")
    ws, ds = beats_o3("llm_static")
    wp, dp = beats_o3("llm_static_perf")
    lines.append(f"- static-only LLM beats -O3 on {len(ws)} programs (mean +{statistics.mean(ds)*100 if ds else 0:.1f}%).")
    lines.append(f"- static+perf LLM beats -O3 on {len(wp)} programs (mean +{statistics.mean(dp)*100 if dp else 0:.1f}%).\n")

    lines.append("## Per-program detail\n")
    lines.append("| program | cat | raw ratio | O3 ratio | llm_static ratio | llm_static_perf ratio | best vs O3 | passes (static_perf) |")
    lines.append("|---|---|---|---|---|---|---|---|")
    for p, sd in by_prog.items():
        def g(s, k):
            return sd.get(s, {}).get(k, "")
        best = max(
            [fnum(g("llm_static", "speedup_vs_O3")) or -9, fnum(g("llm_static_perf", "speedup_vs_O3")) or -9]
        )
        best_s = f"{best*100:.1f}%" if best > -9 else "-"
        lines.append(
            f"| {p.replace('llvmss_','')} | {g('raw','category')} | {g('raw','wasm_native_ratio')} | "
            f"{g('O3','wasm_native_ratio')} | {g('llm_static','wasm_native_ratio')} | "
            f"{g('llm_static_perf','wasm_native_ratio')} | {best_s} | "
            f"`{g('llm_static_perf','passes')}` |"
        )
    lines.append("")

    figs = [] if args.no_figures else make_figures(by_prog, strategies)
    if figs:
        lines.append("## Figures\n")
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
