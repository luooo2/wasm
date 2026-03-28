#!/usr/bin/env python3
"""
Incremental analysis for V2 dataset.

Compares dataset_combined.csv (old) vs dataset_combined_v2.csv (new), and
computes V2 feature statistics:
- Pearson r vs ratio_wasm_over_native
- Cohen's d (native-better vs non-native)

Outputs:
- data/results/v2_feature_stats.csv
- data/results/v2_incremental_analysis.md
"""

import csv
import math
from collections import Counter
from pathlib import Path
from typing import Dict, List

import numpy as np

ROOT = Path(__file__).parent.parent
RES = ROOT / "data" / "results"

OLD_DS = RES / "dataset_combined.csv"
NEW_DS = RES / "dataset_combined_v2.csv"

OUT_STATS = RES / "v2_feature_stats.csv"
OUT_MD = RES / "v2_incremental_analysis.md"

META_COLS = {
    "program",
    "native_median_ms",
    "wasm_median_ms",
    "ratio_wasm_over_native",
    "label",
}


def read_csv(path: Path) -> List[Dict[str, str]]:
    with path.open("r", encoding="utf-8", newline="") as f:
        return list(csv.DictReader(f))


def cohens_d(a: np.ndarray, b: np.ndarray) -> float:
    if len(a) < 2 or len(b) < 2:
        return 0.0
    va = float(np.var(a, ddof=1))
    vb = float(np.var(b, ddof=1))
    pooled = ((len(a) - 1) * va + (len(b) - 1) * vb) / max((len(a) + len(b) - 2), 1)
    if pooled <= 1e-12:
        return 0.0
    return float((np.mean(a) - np.mean(b)) / math.sqrt(pooled))


def main() -> None:
    old_rows = read_csv(OLD_DS)
    new_rows = read_csv(NEW_DS)

    old_cols = list(old_rows[0].keys()) if old_rows else []
    new_cols = list(new_rows[0].keys()) if new_rows else []

    old_features = [c for c in old_cols if c not in META_COLS]
    new_features = [c for c in new_cols if c not in META_COLS]

    old_programs = {r["program"] for r in old_rows}
    new_programs = {r["program"] for r in new_rows}

    added_features = sorted(set(new_features) - set(old_features))
    removed_features = sorted(set(old_features) - set(new_features))

    labels = [r["label"] for r in new_rows]
    label_counts = Counter(labels)

    ratio = np.array([float(r["ratio_wasm_over_native"]) for r in new_rows], dtype=float)
    y_native = np.array([1 if r["label"] == "native-better" else 0 for r in new_rows], dtype=int)

    stats_rows = []
    for feat in new_features:
        x = np.array([float(r[feat]) for r in new_rows], dtype=float)

        r_ratio = float(np.corrcoef(x, ratio)[0, 1]) if np.std(x) > 0 else 0.0
        r_native = float(np.corrcoef(x, y_native)[0, 1]) if np.std(x) > 0 else 0.0

        a = x[y_native == 1]
        b = x[y_native == 0]
        d = cohens_d(a, b)

        stats_rows.append(
            {
                "feature": feat,
                "pearson_r_vs_ratio": round(r_ratio, 6),
                "pearson_r_vs_native_better": round(r_native, 6),
                "cohens_d_native_vs_non_native": round(d, 6),
                "abs_r_vs_ratio": round(abs(r_ratio), 6),
                "abs_d": round(abs(d), 6),
            }
        )

    stats_rows.sort(key=lambda r: r["abs_d"], reverse=True)

    with OUT_STATS.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(
            f,
            fieldnames=[
                "feature",
                "pearson_r_vs_ratio",
                "pearson_r_vs_native_better",
                "cohens_d_native_vs_non_native",
                "abs_r_vs_ratio",
                "abs_d",
            ],
        )
        w.writeheader()
        w.writerows(stats_rows)

    top_r = sorted(stats_rows, key=lambda r: r["abs_r_vs_ratio"], reverse=True)[:8]
    top_d = stats_rows[:8]

    md_lines = [
        "# V2 增量分析报告",
        "",
        "## 1) 数据集对比",
        "",
        f"- 旧数据集行数：{len(old_rows)}",
        f"- 新数据集行数：{len(new_rows)}",
        f"- 行集一致：{'是' if old_programs == new_programs else '否'}",
        f"- 旧特征数：{len(old_features)}",
        f"- 新特征数：{len(new_features)}",
        f"- 新增特征：{', '.join(added_features) if added_features else '无'}",
        f"- 移除特征：{', '.join(removed_features) if removed_features else '无'}",
        "",
        "## 2) 标签分布（V2）",
        "",
        f"- native-better: {label_counts.get('native-better', 0)}",
        f"- similar: {label_counts.get('similar', 0)}",
        f"- wasm-better: {label_counts.get('wasm-better', 0)}",
        "",
        "## 3) 与 ratio 相关性 Top 8（按 |r|）",
        "",
        "| feature | r_vs_ratio | r_vs_native_better | cohen_d |",
        "|---|---:|---:|---:|",
    ]
    for r in top_r:
        md_lines.append(
            f"| {r['feature']} | {r['pearson_r_vs_ratio']:.3f} | {r['pearson_r_vs_native_better']:.3f} | {r['cohens_d_native_vs_non_native']:.3f} |"
        )

    md_lines.extend(
        [
            "",
            "## 4) 区分度 Top 8（按 |Cohen d|）",
            "",
            "| feature | cohen_d | r_vs_ratio |",
            "|---|---:|---:|",
        ]
    )
    for r in top_d:
        md_lines.append(
            f"| {r['feature']} | {r['cohens_d_native_vs_non_native']:.3f} | {r['pearson_r_vs_ratio']:.3f} |"
        )

    md_lines.extend(
        [
            "",
            f"明细统计见：`{OUT_STATS.as_posix()}`",
        ]
    )

    OUT_MD.write_text("\n".join(md_lines) + "\n", encoding="utf-8")

    print(f"wrote: {OUT_STATS}")
    print(f"wrote: {OUT_MD}")


if __name__ == "__main__":
    main()
