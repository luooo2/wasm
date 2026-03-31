#!/usr/bin/env python3
"""
Analyze JIT vs AOT label/ratio differences and write markdown report.
"""

import csv
from collections import Counter
from pathlib import Path
from typing import Dict, List

ROOT = Path(__file__).parent.parent
RES = ROOT / "data" / "results"

JIT_CSV = RES / "labels_all_jit_30.csv"
AOT_CSV = RES / "labels_all_aot_30.csv"
OUT_MD = RES / "jit_vs_aot_analysis.md"


def read_rows(path: Path) -> List[Dict[str, str]]:
    with path.open("r", encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def fnum(x: str) -> float:
    try:
        return float(x)
    except Exception:
        return 0.0


def main() -> None:
    jit_rows = read_rows(JIT_CSV)
    aot_rows = read_rows(AOT_CSV)

    jit_map = {r["program"]: r for r in jit_rows}
    aot_map = {r["program"]: r for r in aot_rows}
    programs = sorted(set(jit_map) & set(aot_map))

    label_cnt_jit = Counter(jit_map[p]["label"] for p in programs)
    label_cnt_aot = Counter(aot_map[p]["label"] for p in programs)

    flips: List[Dict[str, str]] = []
    deltas: List[Dict[str, float]] = []
    for p in programs:
        j = jit_map[p]
        a = aot_map[p]
        rj = fnum(j.get("ratio_wasm_over_native", "0"))
        ra = fnum(a.get("ratio_wasm_over_native", "0"))
        d = ra - rj
        deltas.append({"program": p, "jit": rj, "aot": ra, "delta": d})
        if j.get("label") != a.get("label"):
            flips.append(
                {
                    "program": p,
                    "label_jit": j.get("label", ""),
                    "label_aot": a.get("label", ""),
                    "ratio_jit": f"{rj:.6f}",
                    "ratio_aot": f"{ra:.6f}",
                    "delta": f"{d:.6f}",
                }
            )

    mean_jit = sum(x["jit"] for x in deltas) / max(len(deltas), 1)
    mean_aot = sum(x["aot"] for x in deltas) / max(len(deltas), 1)
    mean_delta = mean_aot - mean_jit

    top_down = sorted(deltas, key=lambda x: x["delta"])[:10]
    top_up = sorted(deltas, key=lambda x: x["delta"], reverse=True)[:10]

    lines = [
        "# JIT vs AOT 对比分析",
        "",
        "## 1) 覆盖情况",
        "",
        f"- 对比程序数：{len(programs)}",
        f"- JIT 行数：{len(jit_rows)}",
        f"- AOT 行数：{len(aot_rows)}",
        "",
        "## 2) 标签分布对比",
        "",
        f"- JIT native-better: {label_cnt_jit.get('native-better', 0)}",
        f"- JIT similar: {label_cnt_jit.get('similar', 0)}",
        f"- JIT wasm-better: {label_cnt_jit.get('wasm-better', 0)}",
        "",
        f"- AOT native-better: {label_cnt_aot.get('native-better', 0)}",
        f"- AOT similar: {label_cnt_aot.get('similar', 0)}",
        f"- AOT wasm-better: {label_cnt_aot.get('wasm-better', 0)}",
        "",
        "## 3) ratio 总体变化",
        "",
        f"- mean(ratio)_jit: {mean_jit:.6f}",
        f"- mean(ratio)_aot: {mean_aot:.6f}",
        f"- mean delta (aot-jit): {mean_delta:.6f}",
        "",
        "## 4) 标签翻转样本",
        "",
        f"- 翻转数量：{len(flips)}",
        "",
    ]

    if flips:
        lines.extend(
            [
                "| program | label_jit | label_aot | ratio_jit | ratio_aot | delta |",
                "|---|---|---|---:|---:|---:|",
            ]
        )
        for r in flips:
            lines.append(
                f"| {r['program']} | {r['label_jit']} | {r['label_aot']} | {r['ratio_jit']} | {r['ratio_aot']} | {r['delta']} |"
            )
        lines.append("")

    lines.extend(
        [
            "## 5) ratio 下降最多的 Top10（AOT 更优）",
            "",
            "| program | ratio_jit | ratio_aot | delta |",
            "|---|---:|---:|---:|",
        ]
    )
    for r in top_down:
        lines.append(f"| {r['program']} | {r['jit']:.6f} | {r['aot']:.6f} | {r['delta']:.6f} |")

    lines.extend(
        [
            "",
            "## 6) ratio 上升最多的 Top10（AOT 更劣）",
            "",
            "| program | ratio_jit | ratio_aot | delta |",
            "|---|---:|---:|---:|",
        ]
    )
    for r in top_up:
        lines.append(f"| {r['program']} | {r['jit']:.6f} | {r['aot']:.6f} | {r['delta']:.6f} |")

    OUT_MD.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"wrote: {OUT_MD}")


if __name__ == "__main__":
    main()

