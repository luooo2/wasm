# 5.11 主表与桥接分析（内部时间比为主 Y）

## 输入

- 静态 + perf 比值: `assets/4.29后/static_perf_join_llvm_direct.csv`
- 内部时间比标签: `data/results/labels_llvm_direct_from_runnable.csv`

## 主 Y

- `y_time_internal_ratio` = `ratio_jit_over_native_internal`（mode=`wasm-jit`）或 `ratio_aot_over_native_internal`（mode=`wasm-aot`）

## X（全部静态数值特征）

见 `column_groups.json` 中 `x_static_all_numeric`（**非**此前 8 特征子集）。`opt_loop_note` 为文本，未纳入 X 相关表。

## 产出

| 文件 | 说明 |
|------|------|
| `main_table_time_perf_static.csv` | 每行 program×mode；含全部静态列、perf 中位数、ratio_*、**y_time_internal_ratio** |
| `column_groups.json` | 列分组（meta / y_main / x_static / y_perf_ratios / raw perf medians） |
| `spearman_static_vs_y_time_internal.csv` | 各静态特征 vs 内部时间比的 Spearman（pooled 52 行） |
| `spearman_perf_ratio_vs_y_time_internal.csv` | 各 perf ratio vs 内部时间比（桥接层） |
| `spearman_static_vs_y_time_by_mode.csv` | 按 mode 单列 Spearman（便于核对） |

## 三目标实验（`analyze_three_goals.py`）

```bash
python3 assets/4.29后/5.11/analyze_three_goals.py
```

| 文件 | 说明 |
|------|------|
| `fdr_spearman_static_vs_time.csv` | 静态 vs 内部时间比 + BH-FDR |
| `fdr_spearman_perf_vs_time.csv` | perf 比值 vs 内部时间比 + FDR |
| `fdr_spearman_static_vs_perf_grid.csv` | 静态×perf 全网格 + FDR |
| `bridge_top_static_to_perf.csv` | FDR q&lt;0.10 的 top 桥接对 |
| `model_time_lasso_cv.json` | LassoCV 选参、R²、内部 CV MSE |
| `model_time_lasso_coefs.csv` | Lasso 稀疏系数（含「每 1 SD X」对时间比的影响） |
| `model_time_ols_full_coefs.csv` / `model_time_rlm_coefs.csv` | 全特征 OLS / Huber RLM 对照 |
| `model_time_compare_metrics.csv` | 模型对比 |
| `bootstrap_lasso_coef_ci.csv` | Lasso bootstrap 置信区间 |
| **`analysis_three_goals.md`** | **中文：三条目标对齐的结果解读** |

## 后续可做

1. 按 `analysis_three_goals.md` 写论文：静态 → perf（桥接表）→ 时间比。
2. 扩样本后重跑本目录脚本，对比 FDR 与 Lasso 非零集是否稳定。
