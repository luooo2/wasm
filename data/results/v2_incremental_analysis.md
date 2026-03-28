# V2 增量分析报告

## 1) 数据集对比

- 旧数据集行数：42
- 新数据集行数：42
- 行集一致：是
- 旧特征数：22
- 新特征数：18
- 新增特征：avg_bb_size, call_to_bb_ratio, compute_to_memory_ratio, hostcall_per_bb, load_store_ratio
- 移除特征：branch_density, call_density, compute_instr_count, filesystem_call_count, function_count, indirect_call_count, io_call_count, loop_count, memory_instr_count

## 2) 标签分布（V2）

- native-better: 35
- similar: 4
- wasm-better: 3

## 3) 与 ratio 相关性 Top 8（按 |r|）

| feature | r_vs_ratio | r_vs_native_better | cohen_d |
|---|---:|---:|---:|
| time_call_count | 0.701 | 0.070 | 0.183 |
| call_to_bb_ratio | 0.456 | -0.028 | -0.073 |
| ir_instruction_count | 0.300 | 0.283 | 0.773 |
| load_count | 0.290 | 0.194 | 0.518 |
| store_count | 0.249 | 0.273 | 0.744 |
| basic_block_count | 0.233 | 0.238 | 0.640 |
| branch_instr_count | 0.232 | 0.244 | 0.660 |
| memory_access_density | 0.231 | 0.243 | 0.657 |

## 4) 区分度 Top 8（按 |Cohen d|）

| feature | cohen_d | r_vs_ratio |
|---|---:|---:|
| ir_instruction_count | 0.773 | 0.300 |
| store_count | 0.744 | 0.249 |
| branch_instr_count | 0.660 | 0.232 |
| memory_access_density | 0.657 | 0.231 |
| basic_block_count | 0.640 | 0.233 |
| compute_density | -0.633 | -0.151 |
| load_count | 0.518 | 0.290 |
| alloc_call_count | 0.455 | -0.034 |

明细统计见：`c:/Users/86187/Desktop/graduation project/wasm/data/results/v2_feature_stats.csv`

## 5) 基于 V2 特征的模型增量分析

评估设置：`Repeated Stratified 3-fold × 30`（纯 numpy 实现），模型为 `NearestCentroid` 与 `GaussianNB`。

### 5.1 V1(22特征) vs V2(18特征) 对比

| 模型 | 特征集 | Accuracy | Macro-F1 | Weighted-F1 |
|---|---|---:|---:|---:|
| NearestCentroid | V1(22) | 0.425 ± 0.137 | 0.301 ± 0.111 | 0.486 ± 0.136 |
| NearestCentroid | V2(18) | 0.512 ± 0.151 | 0.333 ± 0.116 | 0.572 ± 0.147 |
| GaussianNB | V1(22) | 0.540 ± 0.169 | 0.337 ± 0.119 | 0.579 ± 0.139 |
| GaussianNB | V2(18) | 0.556 ± 0.167 | 0.352 ± 0.114 | 0.590 ± 0.137 |

### 5.2 V2(NearestCentroid) 3折OOF混淆矩阵

标签顺序：native-better, similar, wasm-better

```text
[[23  7  5]
 [ 1  3  0]
 [ 1  1  1]]
```

### 5.3 V2(NearestCentroid) 分类指标（3折OOF）

| class | F1 |
|---|---:|
| native-better | 0.767 |
| similar | 0.400 |
| wasm-better | 0.222 |
| macro avg | 0.463 |
| weighted avg | 0.693 |

### 5.4 增量结论

- NearestCentroid: Accuracy Δ=+0.087, Macro-F1 Δ=+0.032
- 在小样本且类别不平衡数据中，Macro-F1 的提升说明 V2 特征集在少数类区分上有一定增益。
- 但 `wasm-better` 类别样本仍很少（n=3），后续建议通过补充该类样本进一步验证稳定性。

模型明细：`c:/Users/86187/Desktop/graduation project/wasm/data/results/v2_model_incremental_metrics.csv`

