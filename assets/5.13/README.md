# 5.13 wasmer (cranelift) 复现 + 与 wasmtime 一致性验证

## 目的

复用 `assets/4.29后` + `assets/4.29后/5.11` 的「静态 IR → perf 桥接 → 内部时间比」三段式
管线，将 **wasmtime** 的数据源替换为 **wasmer (cranelift)**，验证 wasmtime 上的结论
在不同 runtime 上是否一致。

## 输入

- **静态特征源**：`data/build/llvm_direct/*.ll`（两 runtime 共用，未改动）
- **wasmer perf 原始事件**：`data/results/wasmer/perf_llvm/perf_raw_events_llvm_wasmer_cranelift.csv`
  - 由 `wasmer_migration/collect_perf_metrics_llvm_wasmer.sh` 采集（5 repeats × 1 warmup）
- **wasmer 内部时间比标签**：`data/results/wasmer/labels_llvm_direct_from_runnable_wasmer_cranelift.csv`
  - 由 `wasmer_migration/run_llvm_from_runnable_wasmer.py` 采集（10 repeats × 1 warmup）

## 复用的脚本（**未修改**，按参数调用）

- `assets/4.29后/extract_static_features.py`            （静态 + perf 中位数 + ratio_*）
- `assets/4.29后/5.11/build_time_perf_static_table.py`  （拼内部时间比，主表 + Spearman）
- `assets/4.29后/5.11/analyze_three_goals.py`           （FDR + LassoCV / OLS / RLM + bootstrap CI）

## 本目录新增的代码

| 文件 | 作用 |
|------|------|
| `run_pipeline_wasmer.sh`       | 驱动脚本：以 wasmer 输入运行上述三个 4.29后 脚本，所有产物写入本目录 |
| `consistency_with_wasmtime.py` | 把 wasmer 结果与 `assets/4.29后/5.11/` 中 wasmtime 的同名产物逐项对比 |
| `consistency_summary.md`       | 上述对比脚本生成的人类可读结论 |

## 复现命令

```bash
# 1) 重跑 wasmer 三段式管线（约 15s，主要是 LassoCV 收敛）
bash assets/5.13/run_pipeline_wasmer.sh

# 2) 与 wasmtime 结果做一致性对照
python3 assets/5.13/consistency_with_wasmtime.py
```

## 产出（按管线阶段分组）

### 阶段 1：静态 + perf
- `static_features_llvm_direct.csv` —— 30 程序 × 24 数值 + 5 元 IR 静态特征（与 wasmtime 完全一致）
- `perf_medians_llvm_direct.csv`    —— wasmer 的 perf 事件中位数 (program × mode × event)
- `static_perf_join_llvm_direct.csv` —— 每 program×mode 一行，含 `ratio_<event>_over_native`

### 阶段 2：主表 + Spearman
- `main_table_time_perf_static.csv` —— n=52；含全部静态 / perf 中位数 / ratio / `y_time_internal_ratio`
- `column_groups.json`              —— 列分组定义（与 wasmtime 版本结构一致）
- `spearman_static_vs_y_time_internal.csv` / `spearman_perf_ratio_vs_y_time_internal.csv`
- `spearman_static_vs_y_time_by_mode.csv`

### 阶段 3：三目标分析
- `fdr_spearman_static_vs_time.csv`        （Goal 1，静态-时间）
- `fdr_spearman_perf_vs_time.csv`          （桥接链尾）
- `fdr_spearman_static_vs_perf_grid.csv` + `bridge_top_static_to_perf.csv`（链腰）
- `model_time_lasso_coefs.csv` + `model_time_lasso_cv.json` + `bootstrap_lasso_coef_ci.csv`
- `model_time_ols_full_coefs.csv` / `model_time_rlm_coefs.csv` / `model_time_compare_metrics.csv`
- **`analysis_three_goals.md`** —— 与 5.11 同结构的最终中文报告（wasmer 数据下的版本）

### 阶段 4：与 wasmtime 的逐项一致性
- `consistency_static_vs_time.csv` / `consistency_perf_vs_time.csv` / `consistency_bridge_overlap.csv`
- `consistency_lasso_features.csv` / `consistency_y_time_pairs.csv`
- **`consistency_summary.md`** —— 一致性总报告（含程序级时间比 Spearman、ρ 序列 rho-of-rhos、
  FDR 集合 Jaccard、Lasso 非零特征重合 + 符号一致率、模型 R² 对照、结论一句话）
- **`总体观察.md`** —— 简短结论卡片（沿用 5.11 的格式）

## 结论速览（详见 `consistency_summary.md`）

| 维度 | 一致性指标 |
|---|---|
| 程序级时间比 Spearman(y_wasmtime, y_wasmer) | **0.923** (n=52, p≈2e-22) |
| 静态-时间 ρ 序列跨 runtime 相关（rho-of-rhos） | **0.972**（符号一致 96%） |
| perf-时间 ρ 序列跨 runtime 相关 | **0.929**（符号一致 88%） |
| 静态↔perf 桥接 184 配对的 ρ 跨 runtime 相关 | **0.956**（符号一致 92%） |
| Lasso 非零特征 Jaccard / 交集内符号一致 | **66.7%** / **9 of 10**（仅 `compute_density` 翻转） |
| LassoCV R² (in-sample, std-y) | wasmtime 0.553 → wasmer 0.804 |

**结论**：wasmtime 三段式证据链在 wasmer (cranelift) 上**整体复现**；wasmer 上的相关结构甚至**更显著**，
主要由 `conditional_branches`、`L1-icache-load-misses` 这两类 perf 比值的贡献加强带来。
