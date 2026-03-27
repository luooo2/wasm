# Phase 2B 前：第一版建模分析（基于 dataset_labeled_34）

## 1) 数据与标签概览

- 样本数: **34**
- 标签分布: native-better=27, similar=4, wasm-better=3
- 二分类映射（native-better vs non-native）：native=27, non-native=7

## 2) 特征相关性（静态特征 vs 性能比值/标签）

### 2.1 与 ratio_wasm_over_native 的 Pearson 相关（Top 8 by |r|）
- `time_call_count`: r = 0.8014
- `call_density`: r = 0.3550
- `call_instr_count`: r = 0.2151
- `max_loop_depth`: r = -0.1881
- `hostcall_density`: r = -0.1463
- `io_call_count`: r = -0.1339
- `filesystem_call_count`: r = -0.1273
- `compute_density`: r = -0.1038

### 2.2 与二分类标签（native=1）的相关（Top 8 by |r|）
- `alloc_call_count`: r = 0.2569
- `ir_instruction_count`: r = 0.2371
- `store_count`: r = 0.2193
- `compute_density`: r = -0.2043
- `filesystem_call_count`: r = -0.1818
- `memory_instr_count`: r = 0.1601
- `io_call_count`: r = 0.1525
- `memory_access_density`: r = 0.1471

## 3) 区分度（native vs non-native，Cohen d）

> d>0 表示该特征在 native-better 组均值更高，d<0 表示在 non-native 组更高。
- `alloc_call_count`: d = 0.6379 (native_mean=1.0370, non_native_mean=0.2857)
- `ir_instruction_count`: d = 0.5856 (native_mean=65.7037, non_native_mean=45.1429)
- `store_count`: d = 0.5393 (native_mean=3.6296, non_native_mean=1.5714)
- `compute_density`: d = -0.5006 (native_mean=0.2664, non_native_mean=0.3585)
- `filesystem_call_count`: d = -0.4437 (native_mean=0.0370, non_native_mean=0.1429)
- `memory_instr_count`: d = 0.3892 (native_mean=5.9630, non_native_mean=3.7143)
- `io_call_count`: d = 0.3703 (native_mean=1.5185, non_native_mean=1.0000)
- `memory_access_density`: d = 0.3568 (native_mean=0.0794, non_native_mean=0.0610)

## 4) Baseline 分类器

### 4.1 Baseline-A：多数类预测（二分类）
- Accuracy: 0.7941
- Balanced Accuracy: 0.5000

### 4.2 Baseline-B：Nearest Centroid + LOOCV（二分类）
- Accuracy: 0.5588
- Balanced Accuracy: 0.5635
- Macro-F1: 0.5072
- Confusion: TP=15, TN=4, FP=3, FN=12

### 4.3 Baseline-C：Nearest Centroid + LOOCV（三分类）
- Classes: native-better, similar, wasm-better
- Accuracy: 0.4706
- Macro-F1: 0.3127

## 5) 初步结论

1. 当前 34 样本已可完成第一版可学习性验证，但类别不平衡依然明显（native-better 占主导）。
2. 静态特征中，`hostcall_count / hostcall_density`、`call_density`、`compute_density` 等对标签和性能比值表现出较强相关性。
3. 二分类 baseline（LOOCV）相较多数类有提升，说明特征具备可学习信号；但三分类指标仍受样本量和类别稀缺限制。
4. 下一步建议进入 Phase 2B 时，优先补充能产生 `similar` 与 `wasm-better` 的样本（特别是分支结构与低宿主开销计算核）。

## 6) 建议的 Phase 2B 数据扩展方向

- 引入 PolyBench/C 子集时，优先选择控制流/访存模式差异大的 kernel 组合。
- 保留现有 34 样本作为 base set，新样本追加后做分层重测与再标注。
- 扩展后优先复跑同一套 baseline 指标（LOOCV accuracy/macro-F1），比较增量收益。
