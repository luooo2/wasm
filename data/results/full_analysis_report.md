# WebAssembly 性能特征综合分析报告

Microbench samples: 34, PolyBench samples: 30

## 1. 特征相关性分析

### Microbench


**ratio_jit_over_native**

| Feature | Pearson r | p-value | Spearman ρ | p-value |
|---------|-----------|---------|------------|---------|
| mem_instr_count | -0.0262 | 0.8831 | 0.2635 | 0.1321 |
| compute_mem_ratio | -0.0447 | 0.8016 | -0.2389 | 0.1735 |
| total_instr_count | -0.0932 | 0.6002 | 0.2093 | 0.2348 |
| ls_ratio | 0.0926 | 0.6024 | 0.1935 | 0.2729 |
| compute_density | -0.1498 | 0.3979 | -0.1899 | 0.2819 |
| call_instr_count | -0.0081 | 0.9638 | 0.1752 | 0.3216 |
| io_density | -0.0342 | 0.8479 | -0.1426 | 0.4209 |
| max_loop_depth | -0.1243 | 0.4836 | 0.1332 | 0.4528 |
| syscall_count | 0.0052 | 0.9768 | 0.1311 | 0.4598 |
| syscall_density | 0.1361 | 0.4427 | -0.1298 | 0.4645 |
| br_density | 0.0268 | 0.8806 | -0.1119 | 0.5287 |
| avg_bb_out_degree | -0.0942 | 0.5961 | 0.1069 | 0.5474 |
| func_count | -0.0347 | 0.8455 | 0.0976 | 0.5830 |
| call_density | 0.1618 | 0.3606 | -0.0753 | 0.6720 |
| compute_instr_count | -0.0767 | 0.6665 | 0.0724 | 0.6841 |
| io_call_count | -0.0750 | 0.6735 | 0.0612 | 0.7311 |
| basic_block_count | -0.0600 | 0.7359 | 0.0536 | 0.7634 |
| avg_bb_size | 0.0271 | 0.8791 | 0.0498 | 0.7796 |
| br_instr_count | -0.0662 | 0.7100 | 0.0360 | 0.8397 |
| call_bb_ratio | 0.1384 | 0.4351 | -0.0106 | 0.9526 |

**ratio_aot_over_native**

| Feature | Pearson r | p-value | Spearman ρ | p-value |
|---------|-----------|---------|------------|---------|
| mem_instr_count | -0.0340 | 0.8486 | 0.2475 | 0.1581 |
| compute_mem_ratio | -0.0469 | 0.7922 | -0.2463 | 0.1603 |
| compute_density | -0.1555 | 0.3798 | -0.2094 | 0.2347 |
| total_instr_count | -0.1005 | 0.5717 | 0.1873 | 0.2888 |
| ls_ratio | 0.0852 | 0.6317 | 0.1832 | 0.2996 |
| call_instr_count | -0.0148 | 0.9337 | 0.1738 | 0.3255 |
| syscall_count | 0.0047 | 0.9789 | 0.1459 | 0.4105 |
| io_density | -0.0291 | 0.8702 | -0.1284 | 0.4691 |
| max_loop_depth | -0.1289 | 0.4674 | 0.1171 | 0.5096 |
| func_count | -0.0357 | 0.8410 | 0.1153 | 0.5160 |
| syscall_density | 0.1411 | 0.4259 | -0.1125 | 0.5264 |
| br_density | 0.0461 | 0.7959 | -0.1093 | 0.5384 |
| avg_bb_out_degree | -0.0886 | 0.6181 | 0.1061 | 0.5506 |
| io_call_count | -0.0745 | 0.6754 | 0.0705 | 0.6920 |
| call_density | 0.1636 | 0.3553 | -0.0562 | 0.7521 |
| avg_bb_size | 0.0169 | 0.9243 | 0.0472 | 0.7909 |
| basic_block_count | -0.0527 | 0.7673 | 0.0416 | 0.8154 |
| compute_instr_count | -0.0818 | 0.6455 | 0.0406 | 0.8198 |
| br_instr_count | -0.0590 | 0.7402 | 0.0238 | 0.8937 |
| call_bb_ratio | 0.1263 | 0.4765 | 0.0015 | 0.9931 |
### PolyBench


**ratio_jit_over_native**

| Feature | Pearson r | p-value | Spearman ρ | p-value |
|---------|-----------|---------|------------|---------|
| ls_ratio | **-0.3860** | 0.0351 | **-0.4705** | 0.0087 |
| func_count | nan | nan | nan | nan |
| compute_mem_ratio | **0.3932** | 0.0316 | **0.3849** | 0.0357 |
| call_instr_count | -0.1535 | 0.4179 | -0.3368 | 0.0687 |
| compute_density | **0.3777** | 0.0396 | 0.3217 | 0.0830 |
| call_density | -0.2654 | 0.1563 | -0.2852 | 0.1266 |
| call_bb_ratio | -0.2176 | 0.2480 | -0.2847 | 0.1273 |
| max_loop_depth | -0.0652 | 0.7322 | -0.2508 | 0.1812 |
| total_instr_count | -0.1661 | 0.3804 | -0.2080 | 0.2700 |
| mem_instr_count | -0.2049 | 0.2774 | -0.2023 | 0.2836 |
| compute_instr_count | 0.0730 | 0.7016 | 0.1136 | 0.5501 |
| basic_block_count | -0.1873 | 0.3215 | -0.0940 | 0.6214 |
| br_instr_count | -0.1868 | 0.3228 | -0.0915 | 0.6306 |
| avg_bb_size | -0.1089 | 0.5668 | -0.0630 | 0.7410 |
| br_density | 0.0831 | 0.6624 | 0.0594 | 0.7552 |
| avg_bb_out_degree | -0.0497 | 0.7940 | 0.0414 | 0.8279 |

**ratio_aot_over_native**

| Feature | Pearson r | p-value | Spearman ρ | p-value |
|---------|-----------|---------|------------|---------|
| ls_ratio | **-0.3843** | 0.0360 | **-0.4501** | 0.0126 |
| compute_density | **0.3725** | 0.0426 | 0.3257 | 0.0790 |
| func_count | nan | nan | nan | nan |
| compute_mem_ratio | **0.3878** | 0.0342 | **0.3860** | 0.0351 |
| call_instr_count | -0.1456 | 0.4428 | -0.2939 | 0.1149 |
| call_bb_ratio | -0.2075 | 0.2711 | -0.2606 | 0.1642 |
| call_density | -0.2577 | 0.1691 | -0.2549 | 0.1741 |
| max_loop_depth | -0.0513 | 0.7878 | -0.2298 | 0.2219 |
| total_instr_count | -0.1602 | 0.3977 | -0.1675 | 0.3762 |
| mem_instr_count | -0.1992 | 0.2912 | -0.1611 | 0.3950 |
| compute_instr_count | 0.0740 | 0.6977 | 0.1428 | 0.4515 |
| avg_bb_size | -0.0985 | 0.6047 | -0.0590 | 0.7570 |
| br_density | 0.0746 | 0.6953 | 0.0554 | 0.7712 |
| basic_block_count | -0.1852 | 0.3271 | -0.0551 | 0.7725 |
| br_instr_count | -0.1846 | 0.3289 | -0.0526 | 0.7825 |
| avg_bb_out_degree | -0.0439 | 0.8178 | 0.0414 | 0.8279 |

### Microbench — Feature Intercorrelation (|ρ| > 0.8)

| Feature A | Feature B | Spearman ρ |
|-----------|-----------|------------|
| syscall_density | io_density | 0.9951 |
| basic_block_count | br_instr_count | 0.9781 |
| basic_block_count | call_bb_ratio | -0.9482 |
| br_instr_count | call_bb_ratio | -0.9314 |
| mem_instr_count | ls_ratio | 0.9275 |
| avg_bb_size | br_density | -0.9199 |
| compute_instr_count | call_density | -0.8856 |
| ls_ratio | compute_mem_ratio | -0.8633 |
| basic_block_count | avg_bb_size | -0.8560 |
| avg_bb_size | br_instr_count | -0.8511 |
| call_density | syscall_density | 0.8283 |
| call_density | io_density | 0.8102 |
| mem_instr_count | compute_mem_ratio | -0.8067 |
| total_instr_count | syscall_density | -0.8032 |
| avg_bb_size | call_bb_ratio | 0.8007 |

### PolyBench — Feature Intercorrelation (|ρ| > 0.8)

| Feature A | Feature B | Spearman ρ |
|-----------|-----------|------------|
| basic_block_count | br_instr_count | 0.9999 |
| avg_bb_size | br_density | -0.9973 |
| compute_density | compute_mem_ratio | 0.9862 |
| total_instr_count | mem_instr_count | 0.9829 |
| call_density | call_bb_ratio | 0.9778 |
| call_instr_count | call_density | 0.9077 |
| compute_instr_count | compute_density | 0.8964 |
| call_instr_count | call_bb_ratio | 0.8651 |
| basic_block_count | mem_instr_count | 0.8566 |
| br_instr_count | mem_instr_count | 0.8563 |
| total_instr_count | br_instr_count | 0.8505 |
| total_instr_count | basic_block_count | 0.8502 |
| compute_instr_count | compute_mem_ratio | 0.8356 |

## 2. 分类模型建模分析


### Microbench (combined label) (label=`label`, n=34)

**Label distribution**: {'native-better': 18, 'similar': 10, 'wasm-better': 6}

**Decision Tree (depth=3)** — LOO Accuracy: **0.4118** (14/34)

```
               precision    recall  f1-score   support

native-better       0.75      0.50      0.60        18
      similar       0.45      0.50      0.48        10
  wasm-better       0.00      0.00      0.00         6

     accuracy                           0.41        34
    macro avg       0.40      0.33      0.36        34
 weighted avg       0.53      0.41      0.46        34

```

**Random Forest (n=100)** — LOO Accuracy: **0.4706** (16/34)

```
               precision    recall  f1-score   support

native-better       0.58      0.78      0.67        18
      similar       0.29      0.20      0.24        10
  wasm-better       0.00      0.00      0.00         6

     accuracy                           0.47        34
    macro avg       0.29      0.33      0.30        34
 weighted avg       0.39      0.47      0.42        34

```

**Logistic Regression** — LOO Accuracy: **0.3529** (12/34)

```
               precision    recall  f1-score   support

native-better       0.50      0.50      0.50        18
      similar       0.23      0.30      0.26        10
  wasm-better       0.00      0.00      0.00         6

     accuracy                           0.35        34
    macro avg       0.24      0.27      0.25        34
 weighted avg       0.33      0.35      0.34        34

```

**Random Forest Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| compute_density | 0.1006 |
| total_instr_count | 0.0963 |
| compute_instr_count | 0.0825 |
| br_density | 0.0803 |
| syscall_density | 0.0799 |
| compute_mem_ratio | 0.0782 |
| io_density | 0.0781 |
| call_density | 0.0724 |
| avg_bb_size | 0.0624 |
| call_bb_ratio | 0.0459 |

### Microbench (JIT label) (label=`label_jit`, n=34)

**Label distribution**: {'native-better': 18, 'similar': 10, 'wasm-better': 6}

**Decision Tree (depth=3)** — LOO Accuracy: **0.4118** (14/34)

```
               precision    recall  f1-score   support

native-better       0.75      0.50      0.60        18
      similar       0.45      0.50      0.48        10
  wasm-better       0.00      0.00      0.00         6

     accuracy                           0.41        34
    macro avg       0.40      0.33      0.36        34
 weighted avg       0.53      0.41      0.46        34

```

**Random Forest (n=100)** — LOO Accuracy: **0.4706** (16/34)

```
               precision    recall  f1-score   support

native-better       0.58      0.78      0.67        18
      similar       0.29      0.20      0.24        10
  wasm-better       0.00      0.00      0.00         6

     accuracy                           0.47        34
    macro avg       0.29      0.33      0.30        34
 weighted avg       0.39      0.47      0.42        34

```

**Logistic Regression** — LOO Accuracy: **0.3529** (12/34)

```
               precision    recall  f1-score   support

native-better       0.50      0.50      0.50        18
      similar       0.23      0.30      0.26        10
  wasm-better       0.00      0.00      0.00         6

     accuracy                           0.35        34
    macro avg       0.24      0.27      0.25        34
 weighted avg       0.33      0.35      0.34        34

```

**Random Forest Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| compute_density | 0.1006 |
| total_instr_count | 0.0963 |
| compute_instr_count | 0.0825 |
| br_density | 0.0803 |
| syscall_density | 0.0799 |
| compute_mem_ratio | 0.0782 |
| io_density | 0.0781 |
| call_density | 0.0724 |
| avg_bb_size | 0.0624 |
| call_bb_ratio | 0.0459 |

### Microbench (AOT label) (label=`label_aot`, n=34)

**Label distribution**: {'native-better': 18, 'similar': 10, 'wasm-better': 6}

**Decision Tree (depth=3)** — LOO Accuracy: **0.4118** (14/34)

```
               precision    recall  f1-score   support

native-better       0.75      0.50      0.60        18
      similar       0.45      0.50      0.48        10
  wasm-better       0.00      0.00      0.00         6

     accuracy                           0.41        34
    macro avg       0.40      0.33      0.36        34
 weighted avg       0.53      0.41      0.46        34

```

**Random Forest (n=100)** — LOO Accuracy: **0.4706** (16/34)

```
               precision    recall  f1-score   support

native-better       0.58      0.78      0.67        18
      similar       0.29      0.20      0.24        10
  wasm-better       0.00      0.00      0.00         6

     accuracy                           0.47        34
    macro avg       0.29      0.33      0.30        34
 weighted avg       0.39      0.47      0.42        34

```

**Logistic Regression** — LOO Accuracy: **0.3529** (12/34)

```
               precision    recall  f1-score   support

native-better       0.50      0.50      0.50        18
      similar       0.23      0.30      0.26        10
  wasm-better       0.00      0.00      0.00         6

     accuracy                           0.35        34
    macro avg       0.24      0.27      0.25        34
 weighted avg       0.33      0.35      0.34        34

```

**Random Forest Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| compute_density | 0.1006 |
| total_instr_count | 0.0963 |
| compute_instr_count | 0.0825 |
| br_density | 0.0803 |
| syscall_density | 0.0799 |
| compute_mem_ratio | 0.0782 |
| io_density | 0.0781 |
| call_density | 0.0724 |
| avg_bb_size | 0.0624 |
| call_bb_ratio | 0.0459 |

### PolyBench (combined label) (label=`label`, n=30)

**Label distribution**: {'similar': 16, 'native-better': 12, 'wasm-better': 2}

**Decision Tree (depth=3)** — LOO Accuracy: **0.4667** (14/30)

```
               precision    recall  f1-score   support

native-better       0.40      0.33      0.36        12
      similar       0.56      0.62      0.59        16
  wasm-better       0.00      0.00      0.00         2

     accuracy                           0.47        30
    macro avg       0.32      0.32      0.32        30
 weighted avg       0.46      0.47      0.46        30

```

**Random Forest (n=100)** — LOO Accuracy: **0.5333** (16/30)

```
               precision    recall  f1-score   support

native-better       0.46      0.50      0.48        12
      similar       0.59      0.62      0.61        16
  wasm-better       0.00      0.00      0.00         2

     accuracy                           0.53        30
    macro avg       0.35      0.38      0.36        30
 weighted avg       0.50      0.53      0.52        30

```

**Logistic Regression** — LOO Accuracy: **0.5667** (17/30)

```
               precision    recall  f1-score   support

native-better       0.50      0.58      0.54        12
      similar       0.62      0.62      0.62        16
  wasm-better       0.00      0.00      0.00         2

     accuracy                           0.57        30
    macro avg       0.38      0.40      0.39        30
 weighted avg       0.53      0.57      0.55        30

```

**Random Forest Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| ls_ratio | 0.1409 |
| compute_mem_ratio | 0.1294 |
| call_density | 0.0965 |
| br_density | 0.0891 |
| avg_bb_size | 0.0819 |
| call_bb_ratio | 0.0768 |
| compute_density | 0.0756 |
| mem_instr_count | 0.0630 |
| compute_instr_count | 0.0446 |
| total_instr_count | 0.0428 |

### PolyBench (JIT label) (label=`label_jit`, n=30)

**Label distribution**: {'similar': 16, 'native-better': 12, 'wasm-better': 2}

**Decision Tree (depth=3)** — LOO Accuracy: **0.4667** (14/30)

```
               precision    recall  f1-score   support

native-better       0.40      0.33      0.36        12
      similar       0.56      0.62      0.59        16
  wasm-better       0.00      0.00      0.00         2

     accuracy                           0.47        30
    macro avg       0.32      0.32      0.32        30
 weighted avg       0.46      0.47      0.46        30

```

**Random Forest (n=100)** — LOO Accuracy: **0.5333** (16/30)

```
               precision    recall  f1-score   support

native-better       0.46      0.50      0.48        12
      similar       0.59      0.62      0.61        16
  wasm-better       0.00      0.00      0.00         2

     accuracy                           0.53        30
    macro avg       0.35      0.38      0.36        30
 weighted avg       0.50      0.53      0.52        30

```

**Logistic Regression** — LOO Accuracy: **0.5667** (17/30)

```
               precision    recall  f1-score   support

native-better       0.50      0.58      0.54        12
      similar       0.62      0.62      0.62        16
  wasm-better       0.00      0.00      0.00         2

     accuracy                           0.57        30
    macro avg       0.38      0.40      0.39        30
 weighted avg       0.53      0.57      0.55        30

```

**Random Forest Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| ls_ratio | 0.1409 |
| compute_mem_ratio | 0.1294 |
| call_density | 0.0965 |
| br_density | 0.0891 |
| avg_bb_size | 0.0819 |
| call_bb_ratio | 0.0768 |
| compute_density | 0.0756 |
| mem_instr_count | 0.0630 |
| compute_instr_count | 0.0446 |
| total_instr_count | 0.0428 |

### PolyBench (AOT label) (label=`label_aot`, n=30)

**Label distribution**: {'similar': 16, 'native-better': 12, 'wasm-better': 2}

**Decision Tree (depth=3)** — LOO Accuracy: **0.4667** (14/30)

```
               precision    recall  f1-score   support

native-better       0.40      0.33      0.36        12
      similar       0.56      0.62      0.59        16
  wasm-better       0.00      0.00      0.00         2

     accuracy                           0.47        30
    macro avg       0.32      0.32      0.32        30
 weighted avg       0.46      0.47      0.46        30

```

**Random Forest (n=100)** — LOO Accuracy: **0.5333** (16/30)

```
               precision    recall  f1-score   support

native-better       0.46      0.50      0.48        12
      similar       0.59      0.62      0.61        16
  wasm-better       0.00      0.00      0.00         2

     accuracy                           0.53        30
    macro avg       0.35      0.38      0.36        30
 weighted avg       0.50      0.53      0.52        30

```

**Logistic Regression** — LOO Accuracy: **0.5667** (17/30)

```
               precision    recall  f1-score   support

native-better       0.50      0.58      0.54        12
      similar       0.62      0.62      0.62        16
  wasm-better       0.00      0.00      0.00         2

     accuracy                           0.57        30
    macro avg       0.38      0.40      0.39        30
 weighted avg       0.53      0.57      0.55        30

```

**Random Forest Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| ls_ratio | 0.1409 |
| compute_mem_ratio | 0.1294 |
| call_density | 0.0965 |
| br_density | 0.0891 |
| avg_bb_size | 0.0819 |
| call_bb_ratio | 0.0768 |
| compute_density | 0.0756 |
| mem_instr_count | 0.0630 |
| compute_instr_count | 0.0446 |
| total_instr_count | 0.0428 |

## 3. 连续 Ratio 回归建模分析


### Microbench JIT Ratio (target=`ratio_jit_over_native`, n=34)

**Ratio stats**: mean=1.4390, std=1.0857, min=0.0430, max=6.2940

| Model | LOO R² | MAE | RMSE |
|-------|--------|-----|------|
| Linear Regression | -128.2824 | 4.0811 | 12.3449 |
| Ridge (α=1.0) | -0.5696 | 0.8997 | 1.3602 |
| Lasso (α=0.01) | -2.2196 | 1.3132 | 1.9481 |
| Random Forest (n=100) | -0.5637 | 0.7880 | 1.3577 |
| Gradient Boosting | -1.1149 | 0.8736 | 1.5789 |

Best LOO R²: **Random Forest (n=100)** (-0.5637)

**RF Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| total_instr_count | 0.3653 |
| compute_instr_count | 0.1471 |
| br_density | 0.1024 |
| avg_bb_size | 0.0834 |
| compute_density | 0.0802 |
| compute_mem_ratio | 0.0484 |
| call_bb_ratio | 0.0377 |
| call_density | 0.0280 |
| ls_ratio | 0.0247 |
| syscall_density | 0.0206 |

**Ridge Regression Coefficients (standardized, top 10)**

| Feature | Coefficient |
|---------|-------------|
| syscall_density | 0.7960 |
| avg_bb_size | 0.7565 |
| basic_block_count | 0.7515 |
| call_bb_ratio | 0.7485 |
| ls_ratio | 0.5980 |
| call_instr_count | -0.5408 |
| compute_density | -0.4728 |
| io_call_count | -0.4438 |
| io_density | -0.3166 |
| br_instr_count | 0.2938 |

### Microbench AOT Ratio (target=`ratio_aot_over_native`, n=34)

**Ratio stats**: mean=1.4508, std=1.1171, min=0.0422, max=6.3289

| Model | LOO R² | MAE | RMSE |
|-------|--------|-----|------|
| Linear Regression | -127.3232 | 4.1950 | 12.6540 |
| Ridge (α=1.0) | -0.5644 | 0.9284 | 1.3971 |
| Lasso (α=0.01) | -2.1254 | 1.3402 | 1.9748 |
| Random Forest (n=100) | -0.5293 | 0.8008 | 1.3814 |
| Gradient Boosting | -1.0432 | 0.8723 | 1.5967 |

Best LOO R²: **Random Forest (n=100)** (-0.5293)

**RF Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| total_instr_count | 0.3567 |
| compute_instr_count | 0.1410 |
| br_density | 0.1245 |
| compute_density | 0.0803 |
| avg_bb_size | 0.0722 |
| compute_mem_ratio | 0.0455 |
| call_bb_ratio | 0.0433 |
| call_density | 0.0286 |
| ls_ratio | 0.0258 |
| io_density | 0.0157 |

**Ridge Regression Coefficients (standardized, top 10)**

| Feature | Coefficient |
|---------|-------------|
| syscall_density | 0.8056 |
| basic_block_count | 0.7841 |
| avg_bb_size | 0.7809 |
| call_bb_ratio | 0.7608 |
| ls_ratio | 0.5956 |
| call_instr_count | -0.5753 |
| compute_density | -0.5010 |
| io_call_count | -0.4477 |
| io_density | -0.3150 |
| br_instr_count | 0.2784 |

### PolyBench JIT Ratio (target=`ratio_jit_over_native`, n=30)

**Ratio stats**: mean=1.3046, std=0.6154, min=0.8087, max=3.3888

| Model | LOO R² | MAE | RMSE |
|-------|--------|-----|------|
| Linear Regression | -6.0102 | 1.1036 | 1.6293 |
| Ridge (α=1.0) | -0.3483 | 0.4631 | 0.7145 |
| Lasso (α=0.01) | -0.3746 | 0.4529 | 0.7215 |
| Random Forest (n=100) | -0.3486 | 0.4716 | 0.7146 |
| Gradient Boosting | -1.0705 | 0.5455 | 0.8855 |

Best LOO R²: **Ridge (α=1.0)** (-0.3483)

**RF Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| ls_ratio | 0.3256 |
| compute_mem_ratio | 0.1503 |
| mem_instr_count | 0.0867 |
| br_density | 0.0836 |
| compute_density | 0.0676 |
| avg_bb_size | 0.0638 |
| total_instr_count | 0.0619 |
| call_density | 0.0456 |
| max_loop_depth | 0.0344 |
| compute_instr_count | 0.0324 |

**Ridge Regression Coefficients (standardized, top 10)**

| Feature | Coefficient |
|---------|-------------|
| call_bb_ratio | 0.3613 |
| compute_density | 0.3052 |
| avg_bb_size | -0.2385 |
| br_density | 0.1912 |
| call_density | -0.1475 |
| basic_block_count | -0.1136 |
| mem_instr_count | -0.1102 |
| br_instr_count | -0.1087 |
| compute_mem_ratio | 0.0732 |
| call_instr_count | 0.0732 |

### PolyBench AOT Ratio (target=`ratio_aot_over_native`, n=30)

**Ratio stats**: mean=1.3005, std=0.6192, min=0.8067, max=3.3993

| Model | LOO R² | MAE | RMSE |
|-------|--------|-----|------|
| Linear Regression | -6.1677 | 1.1142 | 1.6577 |
| Ridge (α=1.0) | -0.3703 | 0.4685 | 0.7248 |
| Lasso (α=0.01) | -0.3942 | 0.4558 | 0.7311 |
| Random Forest (n=100) | -0.3496 | 0.4698 | 0.7193 |
| Gradient Boosting | -1.0783 | 0.5421 | 0.8926 |

Best LOO R²: **Random Forest (n=100)** (-0.3496)

**RF Feature Importances (top 10)**

| Feature | Importance |
|---------|------------|
| ls_ratio | 0.3215 |
| compute_mem_ratio | 0.1503 |
| mem_instr_count | 0.0973 |
| compute_density | 0.0714 |
| br_density | 0.0709 |
| avg_bb_size | 0.0699 |
| total_instr_count | 0.0599 |
| call_density | 0.0446 |
| max_loop_depth | 0.0339 |
| compute_instr_count | 0.0321 |

**Ridge Regression Coefficients (standardized, top 10)**

| Feature | Coefficient |
|---------|-------------|
| call_bb_ratio | 0.3627 |
| compute_density | 0.3104 |
| avg_bb_size | -0.2239 |
| br_density | 0.1938 |
| call_density | -0.1567 |
| mem_instr_count | -0.1108 |
| basic_block_count | -0.1074 |
| br_instr_count | -0.1025 |
| call_instr_count | 0.0911 |
| max_loop_depth | 0.0774 |



以下是三部分分析的关键结论：

---

## 1. 特征相关性分析

**Microbench（34 个样本）：** 没有任何单一特征与 JIT/AOT ratio 呈现统计显著相关（所有 p > 0.05）。最高 Spearman |ρ| 仅约 0.26（`mem_instr_count`、`compute_mem_ratio`）。这说明 microbench 中各程序的结构差异巨大（涵盖 compute、memory、branch、call、host、alloc 六大类），单一特征无法线性预测性能差异。

**PolyBench（30 个样本）：** 有三个特征达到统计显著水平（p < 0.05）：
- `ls_ratio`（内存占比）：ρ ≈ −0.47，**内存指令比例越高，Wasm ratio 越低**（越接近 native 甚至超越）
- `compute_mem_ratio`（计算/内存比）：ρ ≈ +0.39，**计算密集程度越高，ratio 越大**（Wasm 越慢于 native）
- `compute_density`：r ≈ +0.38，同方向

这个发现非常有意义——说明 **PolyBench 中计算密集型 kernel（如 gemm、heat-3d）Wasm 开销更大，而内存密集型 kernel Wasm 接近 native。**

**特征互相关（|ρ| > 0.8）：** 两个数据集均存在严重的多重共线性，例如 `basic_block_count` ↔ `br_instr_count`（ρ=0.98）、`avg_bb_size` ↔ `br_density`（ρ=−0.92）。后续建模需要注意特征选择。

---

## 2. 分类模型建模分析

三类标签（native-better / similar / wasm-better）的分类效果总体偏弱：

| 数据集 | 模型 | LOO 准确率 |
|--------|------|------------|
| Microbench | Decision Tree | 41.2% |
| Microbench | Random Forest | 47.1% |
| Microbench | Logistic Regression | 35.3% |
| PolyBench | Decision Tree | 46.7% |
| PolyBench | Random Forest | 53.3% |
| PolyBench | Logistic Regression | **56.7%** |

核心问题：
- **wasm-better 类（minority class）** 在所有模型中的 recall 均为 0，说明模型无法区分少数类。
- Microbench 中 label_jit 和 label_aot 完全一致，说明 JIT 与 AOT 对微基准程序的性能分类结果一样。
- 分类建模不适合当前样本量和标签分布。

**RF 特征重要性**方面：
- Microbench 中 `compute_density`、`total_instr_count`、`br_density` 排前三
- PolyBench 中 `ls_ratio`、`compute_mem_ratio`、`call_density` 排前三，与相关性分析一致

---

## 3. 连续 Ratio 回归建模分析

所有模型的 **LOO R² 均为负值**，说明在 leave-one-out 交叉验证下，模型的预测能力不如直接使用均值：

| 数据集 | 目标 | 最佳模型 | LOO R² | MAE |
|--------|------|----------|--------|-----|
| Microbench | JIT ratio | Random Forest | −0.56 | 0.79 |
| Microbench | AOT ratio | Random Forest | −0.53 | 0.80 |
| PolyBench | JIT ratio | Ridge | −0.35 | 0.46 |
| PolyBench | AOT ratio | Random Forest | −0.35 | 0.47 |

**解读：**
- R² 为负不意味着特征完全无关，而是 **样本量太小（30–34）+ 特征维度太高（16–20）** 导致过拟合严重，泛化能力不足。
- Microbench 中有极端 ratio（如 `host_time_loop` ratio ≈ 6.3、`host_getcwd_loop` ratio ≈ 0.04），少数 outlier 严重影响回归模型。
- **Ridge 回归系数**提供了有价值的定性信息：PolyBench 中 `compute_density` 系数为正（计算密集 → ratio 高 → Wasm 慢），`avg_bb_size` 系数为负（基本块越大、控制流越简单 → ratio 越低 → Wasm 相对更快）。

**RF 特征重要性**在回归中同样指向：
- Microbench：`total_instr_count` 占 36%（程序规模效应）
- PolyBench：`ls_ratio` 占 32%（内存/计算结构是最强解释变量）

---

**总结建议（写入论文时）：**
1. 相关性分析适合论文第 4 章"实验结果"部分——PolyBench 中 `ls_ratio`/`compute_mem_ratio`/`compute_density` 与 ratio 的显著相关性是核心发现。
2. 分类模型受限于样本量和标签不均衡，建议在论文中诚实报告局限性，不强调分类准确率，而是聚焦于 **特征重要性排序** 提供的结构性解释。
3. 回归建模同样受样本量制约，但 **Ridge 系数方向** 和 **RF 特征重要性排序** 可作为定性结论的定量佐证。


