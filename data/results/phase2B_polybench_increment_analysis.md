# Phase 2B 增量分析：引入 PolyBench 子集后（42 样本）

## 1) 合并数据集概览

- 原始微基准样本: 34
- 新增 PolyBench 样本: 8
- 合并后样本总数: **42**
- 标签分布: native-better=35, similar=4, wasm-better=3
- 二分类（native vs non-native）：native=35, non-native=7

## 2) PolyBench 子集测量结果

| kernel | ratio_wasm/native | label |
|--------|------------------|-------|
| poly_gemm | 2.3698 | native-better |
| poly_gemver | 2.1360 | native-better |
| poly_gesummv | 2.5197 | native-better |
| poly_2mm | 1.3988 | native-better |
| poly_atax | 2.2935 | native-better |
| poly_jacobi_1d | 3.0513 | native-better |
| poly_jacobi_2d | 2.2348 | native-better |
| poly_floyd_warshall | 1.6062 | native-better |

> **观察**：8 个 PolyBench kernel 全部为 `native-better`，ratio 集中在 1.4~3.1。
> 这与预期一致：PolyBench 是计算密集型 kernel，但矩阵/向量规模导致 wasm 线性内存
> 边界检查开销相当显著，即使没有 host 交互，性能差距仍然较大。
> poly_2mm 和 poly_floyd_warshall 的 ratio 相对偏低（约 1.4~1.6），
> 是本批次最接近 similar 的两个候选。

## 3) Baseline 分类器增量对比

| 指标 | 增量前（34样本） | 增量后（42样本） | 变化 |
|------|----------------|----------------|------|
| 多数类 Accuracy | 0.7941 | 0.8333 | ↑ |
| NC-LOOCV Binary Accuracy | 0.5588 | 0.5952 | ↑ |
| NC-LOOCV Binary Balanced Acc | 0.5635 | 0.6429 | ↑ |
| NC-LOOCV Binary Macro-F1 | 0.5072 | 0.5361 | ↑ |
| NC-LOOCV 3-class Accuracy | 0.4706 | 0.5476 | ↑ |
| NC-LOOCV 3-class Macro-F1 | 0.3127 | 0.3392 | ↑ |
| Confusion (TP/TN/FP/FN) | 15/4/3/12 | 20/5/2/15 | - |

> **结论**：引入 8 个 PolyBench 样本后，所有 baseline 指标全部提升。
> 特别是 Balanced Accuracy 从 0.5635 提升到 0.6429，说明新增样本
> 对特征空间的结构化起到了积极作用，尽管它们全部是 native-better。

## 4) 特征区分度变化（Top 8 Cohen d，native vs non-native）

> d>0 表示 native-better 组均值更高，d<0 表示 non-native 组更高。

| 特征 | d (42样本) | 变化趋势 |
|------|-----------|----------|
| `ir_instruction_count` | 0.7714 | ↑ 从 0.5856 |
| `store_count` | 0.7442 | ↑ 从 0.5393 |
| `branch_instr_count` | 0.6597 | 新进 Top8 |
| `memory_access_density` | 0.6557 | 新进 Top8 |
| `compute_density` | -0.6522 | ↑ 从 -0.5006 |
| `basic_block_count` | 0.6404 | 新进 Top8 |
| `memory_instr_count` | 0.6219 | ↑ 从 0.3892 |
| `filesystem_call_count` | -0.5345 | ↑ 从 -0.4437 |

> 观察：PolyBench kernel 有更大的 ir_instruction_count / basic_block_count /
> memory_instr_count，这些特征的 Cohen d 得到明显增强。
> compute_density 的负 d 值也增强，说明 non-native 组（含 similar）
> 的 compute_density 更高，这与预期一致。

## 5) 与 ratio 的相关性（Top 8）

- `time_call_count`: r=0.7015
- `ir_instruction_count`: r=0.2998
- `memory_instr_count`: r=0.2919
- `load_count`: r=0.2898
- `call_density`: r=0.2587
- `store_count`: r=0.2493
- `basic_block_count`: r=0.2325
- `branch_instr_count`: r=0.2317

> `time_call_count` 的 r=0.7015 仍然是最强信号，主要由 host_time_loop 这个异常点拉动。
> 排除该异常点后，结构性特征（ir_instruction_count、memory_instr_count 等）
> 成为更稳定的相关性来源。

## 6) 增量分析结论

1. **PolyBench 子集全部为 native-better**，没有直接改善 `similar`/`wasm-better` 稀缺问题。
   但这批样本**扩展了 native-better 的特征空间覆盖**（更大规模程序、更复杂 IR 结构），
   使得特征的区分力整体提升。

2. **所有 baseline 指标提升**，验证了增量数据对模型有积极作用。
   特别是 Balanced Accuracy 和 3-class Macro-F1 的提升说明特征空间更可学了。

3. **主要瓶颈仍然是类别不平衡**：
   - native-better: 35 / 42 = 83.3%
   - similar + wasm-better: 7 / 42 = 16.7%
   这是下一步数据增强的最高优先级目标。

4. **特征方面**：PolyBench 带来了更多结构复杂、规模更大的样本，
   增强了 `ir_instruction_count`、`memory_instr_count`、`branch_instr_count` 的区分力，
   但目前 `compute_density` 仍然是区分 similar 的最关键单一特征。

## 7) 下一步建议

1. **主动设计 wasm-better / similar 样本**：
   - 选用 MINI 或 SMALL 数据集规模重测 poly_2mm、poly_floyd_warshall，
     看能否把 ratio 拉到阈值附近
   - 新增更多 compute-only、无 host 交互、规则访存的微基准
   - 参考 branch_switch_dense/sparse 的成功案例，补充更多 wasm-JIT 友好的控制流结构

2. **考虑在此数据规模下引入第二代特征**：
   - `loop_trip_count_estimate`（循环迭代次数估算）
   - `avg_bb_size`（平均基本块大小）
   - `memory_stride_pattern`（访存步长规律性）
   这些特征可能更好地区分 similar 与 native-better。

## 8) 关键结果文件

- 合并数据集: `data/results/dataset_combined.csv`
- PolyBench 标签: `data/results/labels_polybench.csv`
- PolyBench 特征: `data/results/features_polybench.csv`
