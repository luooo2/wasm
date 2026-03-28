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
- 由于类别极不平衡（native-better 占多数），建议优先关注 Macro-F1 的变化。

明细CSV：`c:/Users/86187/Desktop/graduation project/wasm/data/results/v2_model_incremental_metrics.csv`
