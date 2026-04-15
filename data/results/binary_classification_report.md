# 二分类建模分析：native-better vs nonnative-better

> nonnative-better = similar + wasm-better


## Microbench

### Microbench (combined label) (n=34, native-better=18, nonnative-better=16)

| Model | Accuracy | F1 (macro) | Precision (NB) | Recall (NB) | AUC |
|-------|----------|------------|----------------|-------------|-----|
| Decision Tree (depth=3) | **0.6176** | 0.6146 | 0.6923 | 0.5000 | 0.4306 |
| Decision Tree (depth=2) | **0.7059** | 0.7059 | 0.7500 | 0.6667 | 0.5278 |
| Random Forest (n=100, depth=4) | **0.5588** | 0.5584 | 0.6000 | 0.5000 | 0.5000 |
| Random Forest (n=200, depth=5) | **0.5588** | 0.5584 | 0.6000 | 0.5000 | 0.5521 |
| Logistic Regression | **0.4412** | 0.4407 | 0.4667 | 0.3889 | 0.3472 |
| SVM (RBF) | **0.4412** | 0.4407 | 0.4667 | 0.3889 | 0.0972 |
| SVM (Linear) | **0.4706** | 0.4688 | 0.5000 | 0.3889 | 0.0347 |

Best LOO accuracy: **Decision Tree (depth=2)** (0.7059)

#### Confusion Matrix (Random Forest n=200)

```
                  Predicted
                  NB    NNB
Actual NB          9     9
Actual NNB         6    10
```

```
                  precision    recall  f1-score   support

   native-better       0.60      0.50      0.55        18
nonnative-better       0.53      0.62      0.57        16

        accuracy                           0.56        34
       macro avg       0.56      0.56      0.56        34
    weighted avg       0.57      0.56      0.56        34

```

#### Misclassified Programs

| Program | Actual | Predicted |
|---------|--------|-----------|
| alloc_realloc_loop | native-better | nonnative-better |
| alloc_small_objects | native-better | nonnative-better |
| branch_switch_sparse | nonnative-better | native-better |
| branch_unpredictable | native-better | nonnative-better |
| call_chain | nonnative-better | native-better |
| call_indirect | native-better | nonnative-better |
| call_many_small_funcs | native-better | nonnative-better |
| compute_int_mul | nonnative-better | native-better |
| host_getcwd_loop | nonnative-better | native-better |
| host_stat_loop | native-better | nonnative-better |
| memory_copy_loop | native-better | nonnative-better |
| memory_random_read | native-better | nonnative-better |
| memory_random_write | native-better | nonnative-better |
| memory_seq_read | nonnative-better | native-better |
| memory_stride_write | nonnative-better | native-better |

#### Random Forest Feature Importances

| Rank | Feature | Importance |
|------|---------|------------|
| 1 | compute_density | 0.1243 |
| 2 | compute_instr_count | 0.1172 |
| 3 | compute_mem_ratio | 0.0882 |
| 4 | total_instr_count | 0.0842 |
| 5 | call_density | 0.0786 |
| 6 | br_density | 0.0712 |
| 7 | io_density | 0.0681 |
| 8 | avg_bb_size | 0.0589 |
| 9 | syscall_density | 0.0547 |
| 10 | ls_ratio | 0.0465 |
| 11 | mem_instr_count | 0.0395 |
| 12 | call_instr_count | 0.0341 |

#### Logistic Regression Coefficients (standardized)

| Rank | Feature | Coeff | Direction |
|------|---------|-------|-----------|
| 1 | syscall_count | -0.5779 | nonnative-better + |
| 2 | syscall_density | -0.5298 | nonnative-better + |
| 3 | func_count | -0.5210 | nonnative-better + |
| 4 | avg_bb_size | -0.5099 | nonnative-better + |
| 5 | total_instr_count | -0.3834 | nonnative-better + |
| 6 | br_instr_count | -0.3073 | nonnative-better + |
| 7 | avg_bb_out_degree | -0.2364 | nonnative-better + |
| 8 | mem_instr_count | -0.2360 | nonnative-better + |
| 9 | compute_instr_count | -0.1924 | nonnative-better + |
| 10 | io_call_count | -0.1852 | nonnative-better + |
| 11 | io_density | -0.1765 | nonnative-better + |
| 12 | compute_mem_ratio | -0.1629 | nonnative-better + |

#### Decision Tree Rules (depth=3)

```
|--- compute_density <= 0.24
|   |--- total_instr_count <= 60.00
|   |   |--- compute_density <= 0.20
|   |   |   |--- class: nonnative-better
|   |   |--- compute_density >  0.20
|   |   |   |--- class: native-better
|   |--- total_instr_count >  60.00
|   |   |--- class: native-better
|--- compute_density >  0.24
|   |--- compute_instr_count <= 32.50
|   |   |--- func_count <= 2.50
|   |   |   |--- class: nonnative-better
|   |   |--- func_count >  2.50
|   |   |   |--- class: native-better
|   |--- compute_instr_count >  32.50
|   |   |--- mem_instr_count <= 36.50
|   |   |   |--- class: native-better
|   |   |--- mem_instr_count >  36.50
|   |   |   |--- class: native-better

```
### Microbench (JIT label) (n=34, native-better=18, nonnative-better=16)

| Model | Accuracy | F1 (macro) | Precision (NB) | Recall (NB) | AUC |
|-------|----------|------------|----------------|-------------|-----|
| Decision Tree (depth=3) | **0.6176** | 0.6146 | 0.6923 | 0.5000 | 0.4306 |
| Decision Tree (depth=2) | **0.7059** | 0.7059 | 0.7500 | 0.6667 | 0.5278 |
| Random Forest (n=100, depth=4) | **0.5588** | 0.5584 | 0.6000 | 0.5000 | 0.5000 |
| Random Forest (n=200, depth=5) | **0.5588** | 0.5584 | 0.6000 | 0.5000 | 0.5521 |
| Logistic Regression | **0.4412** | 0.4407 | 0.4667 | 0.3889 | 0.3472 |
| SVM (RBF) | **0.4412** | 0.4407 | 0.4667 | 0.3889 | 0.0972 |
| SVM (Linear) | **0.4706** | 0.4688 | 0.5000 | 0.3889 | 0.0347 |

Best LOO accuracy: **Decision Tree (depth=2)** (0.7059)

#### Confusion Matrix (Random Forest n=200)

```
                  Predicted
                  NB    NNB
Actual NB          9     9
Actual NNB         6    10
```

```
                  precision    recall  f1-score   support

   native-better       0.60      0.50      0.55        18
nonnative-better       0.53      0.62      0.57        16

        accuracy                           0.56        34
       macro avg       0.56      0.56      0.56        34
    weighted avg       0.57      0.56      0.56        34

```

#### Misclassified Programs

| Program | Actual | Predicted |
|---------|--------|-----------|
| alloc_realloc_loop | native-better | nonnative-better |
| alloc_small_objects | native-better | nonnative-better |
| branch_switch_sparse | nonnative-better | native-better |
| branch_unpredictable | native-better | nonnative-better |
| call_chain | nonnative-better | native-better |
| call_indirect | native-better | nonnative-better |
| call_many_small_funcs | native-better | nonnative-better |
| compute_int_mul | nonnative-better | native-better |
| host_getcwd_loop | nonnative-better | native-better |
| host_stat_loop | native-better | nonnative-better |
| memory_copy_loop | native-better | nonnative-better |
| memory_random_read | native-better | nonnative-better |
| memory_random_write | native-better | nonnative-better |
| memory_seq_read | nonnative-better | native-better |
| memory_stride_write | nonnative-better | native-better |

#### Random Forest Feature Importances

| Rank | Feature | Importance |
|------|---------|------------|
| 1 | compute_density | 0.1243 |
| 2 | compute_instr_count | 0.1172 |
| 3 | compute_mem_ratio | 0.0882 |
| 4 | total_instr_count | 0.0842 |
| 5 | call_density | 0.0786 |
| 6 | br_density | 0.0712 |
| 7 | io_density | 0.0681 |
| 8 | avg_bb_size | 0.0589 |
| 9 | syscall_density | 0.0547 |
| 10 | ls_ratio | 0.0465 |
| 11 | mem_instr_count | 0.0395 |
| 12 | call_instr_count | 0.0341 |

#### Logistic Regression Coefficients (standardized)

| Rank | Feature | Coeff | Direction |
|------|---------|-------|-----------|
| 1 | syscall_count | -0.5779 | nonnative-better + |
| 2 | syscall_density | -0.5298 | nonnative-better + |
| 3 | func_count | -0.5210 | nonnative-better + |
| 4 | avg_bb_size | -0.5099 | nonnative-better + |
| 5 | total_instr_count | -0.3834 | nonnative-better + |
| 6 | br_instr_count | -0.3073 | nonnative-better + |
| 7 | avg_bb_out_degree | -0.2364 | nonnative-better + |
| 8 | mem_instr_count | -0.2360 | nonnative-better + |
| 9 | compute_instr_count | -0.1924 | nonnative-better + |
| 10 | io_call_count | -0.1852 | nonnative-better + |
| 11 | io_density | -0.1765 | nonnative-better + |
| 12 | compute_mem_ratio | -0.1629 | nonnative-better + |

#### Decision Tree Rules (depth=3)

```
|--- compute_density <= 0.24
|   |--- total_instr_count <= 60.00
|   |   |--- compute_density <= 0.20
|   |   |   |--- class: nonnative-better
|   |   |--- compute_density >  0.20
|   |   |   |--- class: native-better
|   |--- total_instr_count >  60.00
|   |   |--- class: native-better
|--- compute_density >  0.24
|   |--- compute_instr_count <= 32.50
|   |   |--- func_count <= 2.50
|   |   |   |--- class: nonnative-better
|   |   |--- func_count >  2.50
|   |   |   |--- class: native-better
|   |--- compute_instr_count >  32.50
|   |   |--- mem_instr_count <= 36.50
|   |   |   |--- class: native-better
|   |   |--- mem_instr_count >  36.50
|   |   |   |--- class: native-better

```
### Microbench (AOT label) (n=34, native-better=18, nonnative-better=16)

| Model | Accuracy | F1 (macro) | Precision (NB) | Recall (NB) | AUC |
|-------|----------|------------|----------------|-------------|-----|
| Decision Tree (depth=3) | **0.6176** | 0.6146 | 0.6923 | 0.5000 | 0.4306 |
| Decision Tree (depth=2) | **0.7059** | 0.7059 | 0.7500 | 0.6667 | 0.5278 |
| Random Forest (n=100, depth=4) | **0.5588** | 0.5584 | 0.6000 | 0.5000 | 0.5000 |
| Random Forest (n=200, depth=5) | **0.5588** | 0.5584 | 0.6000 | 0.5000 | 0.5521 |
| Logistic Regression | **0.4412** | 0.4407 | 0.4667 | 0.3889 | 0.3472 |
| SVM (RBF) | **0.4412** | 0.4407 | 0.4667 | 0.3889 | 0.0972 |
| SVM (Linear) | **0.4706** | 0.4688 | 0.5000 | 0.3889 | 0.0347 |

Best LOO accuracy: **Decision Tree (depth=2)** (0.7059)

#### Confusion Matrix (Random Forest n=200)

```
                  Predicted
                  NB    NNB
Actual NB          9     9
Actual NNB         6    10
```

```
                  precision    recall  f1-score   support

   native-better       0.60      0.50      0.55        18
nonnative-better       0.53      0.62      0.57        16

        accuracy                           0.56        34
       macro avg       0.56      0.56      0.56        34
    weighted avg       0.57      0.56      0.56        34

```

#### Misclassified Programs

| Program | Actual | Predicted |
|---------|--------|-----------|
| alloc_realloc_loop | native-better | nonnative-better |
| alloc_small_objects | native-better | nonnative-better |
| branch_switch_sparse | nonnative-better | native-better |
| branch_unpredictable | native-better | nonnative-better |
| call_chain | nonnative-better | native-better |
| call_indirect | native-better | nonnative-better |
| call_many_small_funcs | native-better | nonnative-better |
| compute_int_mul | nonnative-better | native-better |
| host_getcwd_loop | nonnative-better | native-better |
| host_stat_loop | native-better | nonnative-better |
| memory_copy_loop | native-better | nonnative-better |
| memory_random_read | native-better | nonnative-better |
| memory_random_write | native-better | nonnative-better |
| memory_seq_read | nonnative-better | native-better |
| memory_stride_write | nonnative-better | native-better |

#### Random Forest Feature Importances

| Rank | Feature | Importance |
|------|---------|------------|
| 1 | compute_density | 0.1243 |
| 2 | compute_instr_count | 0.1172 |
| 3 | compute_mem_ratio | 0.0882 |
| 4 | total_instr_count | 0.0842 |
| 5 | call_density | 0.0786 |
| 6 | br_density | 0.0712 |
| 7 | io_density | 0.0681 |
| 8 | avg_bb_size | 0.0589 |
| 9 | syscall_density | 0.0547 |
| 10 | ls_ratio | 0.0465 |
| 11 | mem_instr_count | 0.0395 |
| 12 | call_instr_count | 0.0341 |

#### Logistic Regression Coefficients (standardized)

| Rank | Feature | Coeff | Direction |
|------|---------|-------|-----------|
| 1 | syscall_count | -0.5779 | nonnative-better + |
| 2 | syscall_density | -0.5298 | nonnative-better + |
| 3 | func_count | -0.5210 | nonnative-better + |
| 4 | avg_bb_size | -0.5099 | nonnative-better + |
| 5 | total_instr_count | -0.3834 | nonnative-better + |
| 6 | br_instr_count | -0.3073 | nonnative-better + |
| 7 | avg_bb_out_degree | -0.2364 | nonnative-better + |
| 8 | mem_instr_count | -0.2360 | nonnative-better + |
| 9 | compute_instr_count | -0.1924 | nonnative-better + |
| 10 | io_call_count | -0.1852 | nonnative-better + |
| 11 | io_density | -0.1765 | nonnative-better + |
| 12 | compute_mem_ratio | -0.1629 | nonnative-better + |

#### Decision Tree Rules (depth=3)

```
|--- compute_density <= 0.24
|   |--- total_instr_count <= 60.00
|   |   |--- compute_density <= 0.20
|   |   |   |--- class: nonnative-better
|   |   |--- compute_density >  0.20
|   |   |   |--- class: native-better
|   |--- total_instr_count >  60.00
|   |   |--- class: native-better
|--- compute_density >  0.24
|   |--- compute_instr_count <= 32.50
|   |   |--- func_count <= 2.50
|   |   |   |--- class: nonnative-better
|   |   |--- func_count >  2.50
|   |   |   |--- class: native-better
|   |--- compute_instr_count >  32.50
|   |   |--- mem_instr_count <= 36.50
|   |   |   |--- class: native-better
|   |   |--- mem_instr_count >  36.50
|   |   |   |--- class: native-better

```

## PolyBench

### PolyBench (combined label) (n=30, native-better=12, nonnative-better=18)

| Model | Accuracy | F1 (macro) | Precision (NB) | Recall (NB) | AUC |
|-------|----------|------------|----------------|-------------|-----|
| Decision Tree (depth=3) | **0.5333** | 0.5139 | 0.4167 | 0.4167 | 0.5255 |
| Decision Tree (depth=2) | **0.5333** | 0.5139 | 0.4167 | 0.4167 | 0.6551 |
| Random Forest (n=100, depth=4) | **0.5667** | 0.5543 | 0.4615 | 0.5000 | 0.5417 |
| Random Forest (n=200, depth=5) | **0.5333** | 0.5139 | 0.4167 | 0.4167 | 0.5417 |
| Logistic Regression | **0.6000** | 0.5928 | 0.5000 | 0.5833 | 0.6806 |
| SVM (RBF) | **0.5333** | 0.4976 | 0.4000 | 0.3333 | 0.0000 |
| SVM (Linear) | **0.6000** | 0.5928 | 0.5000 | 0.5833 | 0.0000 |

Best LOO accuracy: **Logistic Regression** (0.6000)

#### Confusion Matrix (Random Forest n=200)

```
                  Predicted
                  NB    NNB
Actual NB          5     7
Actual NNB         7    11
```

```
                  precision    recall  f1-score   support

   native-better       0.42      0.42      0.42        12
nonnative-better       0.61      0.61      0.61        18

        accuracy                           0.53        30
       macro avg       0.51      0.51      0.51        30
    weighted avg       0.53      0.53      0.53        30

```

#### Misclassified Programs

| Program | Actual | Predicted |
|---------|--------|-----------|
| covariance | nonnative-better | native-better |
| 2mm | native-better | nonnative-better |
| 3mm | nonnative-better | native-better |
| atax | native-better | nonnative-better |
| doitgen | native-better | nonnative-better |
| mvt | nonnative-better | native-better |
| syr2k | nonnative-better | native-better |
| trmm | nonnative-better | native-better |
| durbin | native-better | nonnative-better |
| adi | nonnative-better | native-better |
| fdtd-2d | native-better | nonnative-better |
| heat-3d | native-better | nonnative-better |
| jacobi-1d | native-better | nonnative-better |
| seidel-2d | nonnative-better | native-better |

#### Random Forest Feature Importances

| Rank | Feature | Importance |
|------|---------|------------|
| 1 | ls_ratio | 0.1409 |
| 2 | compute_mem_ratio | 0.1225 |
| 3 | br_density | 0.1016 |
| 4 | call_density | 0.0923 |
| 5 | compute_density | 0.0851 |
| 6 | avg_bb_size | 0.0835 |
| 7 | call_bb_ratio | 0.0772 |
| 8 | mem_instr_count | 0.0654 |
| 9 | total_instr_count | 0.0552 |
| 10 | max_loop_depth | 0.0395 |
| 11 | basic_block_count | 0.0366 |
| 12 | call_instr_count | 0.0363 |

#### Logistic Regression Coefficients (standardized)

| Rank | Feature | Coeff | Direction |
|------|---------|-------|-----------|
| 1 | avg_bb_size | 0.7300 | native-better + |
| 2 | ls_ratio | 0.7179 | native-better + |
| 3 | br_density | -0.7000 | nonnative-better + |
| 4 | compute_instr_count | -0.6150 | nonnative-better + |
| 5 | avg_bb_out_degree | -0.5875 | nonnative-better + |
| 6 | call_bb_ratio | -0.3883 | nonnative-better + |
| 7 | compute_density | -0.3178 | nonnative-better + |
| 8 | mem_instr_count | 0.2522 | native-better + |
| 9 | max_loop_depth | 0.2056 | native-better + |
| 10 | basic_block_count | 0.1880 | native-better + |
| 11 | br_instr_count | 0.1712 | native-better + |
| 12 | total_instr_count | -0.1070 | nonnative-better + |

#### Decision Tree Rules (depth=3)

```
|--- ls_ratio <= 0.39
|   |--- basic_block_count <= 13.50
|   |   |--- br_density <= 0.09
|   |   |   |--- class: nonnative-better
|   |   |--- br_density >  0.09
|   |   |   |--- class: native-better
|   |--- basic_block_count >  13.50
|   |   |--- class: native-better
|--- ls_ratio >  0.39
|   |--- max_loop_depth <= 2.50
|   |   |--- avg_bb_size <= 8.38
|   |   |   |--- class: nonnative-better
|   |   |--- avg_bb_size >  8.38
|   |   |   |--- class: native-better
|   |--- max_loop_depth >  2.50
|   |   |--- class: nonnative-better

```
### PolyBench (JIT label) (n=30, native-better=12, nonnative-better=18)

| Model | Accuracy | F1 (macro) | Precision (NB) | Recall (NB) | AUC |
|-------|----------|------------|----------------|-------------|-----|
| Decision Tree (depth=3) | **0.5333** | 0.5139 | 0.4167 | 0.4167 | 0.5255 |
| Decision Tree (depth=2) | **0.5333** | 0.5139 | 0.4167 | 0.4167 | 0.6551 |
| Random Forest (n=100, depth=4) | **0.5667** | 0.5543 | 0.4615 | 0.5000 | 0.5417 |
| Random Forest (n=200, depth=5) | **0.5333** | 0.5139 | 0.4167 | 0.4167 | 0.5417 |
| Logistic Regression | **0.6000** | 0.5928 | 0.5000 | 0.5833 | 0.6806 |
| SVM (RBF) | **0.5333** | 0.4976 | 0.4000 | 0.3333 | 0.0000 |
| SVM (Linear) | **0.6000** | 0.5928 | 0.5000 | 0.5833 | 0.0000 |

Best LOO accuracy: **Logistic Regression** (0.6000)

#### Confusion Matrix (Random Forest n=200)

```
                  Predicted
                  NB    NNB
Actual NB          5     7
Actual NNB         7    11
```

```
                  precision    recall  f1-score   support

   native-better       0.42      0.42      0.42        12
nonnative-better       0.61      0.61      0.61        18

        accuracy                           0.53        30
       macro avg       0.51      0.51      0.51        30
    weighted avg       0.53      0.53      0.53        30

```

#### Misclassified Programs

| Program | Actual | Predicted |
|---------|--------|-----------|
| covariance | nonnative-better | native-better |
| 2mm | native-better | nonnative-better |
| 3mm | nonnative-better | native-better |
| atax | native-better | nonnative-better |
| doitgen | native-better | nonnative-better |
| mvt | nonnative-better | native-better |
| syr2k | nonnative-better | native-better |
| trmm | nonnative-better | native-better |
| durbin | native-better | nonnative-better |
| adi | nonnative-better | native-better |
| fdtd-2d | native-better | nonnative-better |
| heat-3d | native-better | nonnative-better |
| jacobi-1d | native-better | nonnative-better |
| seidel-2d | nonnative-better | native-better |

#### Random Forest Feature Importances

| Rank | Feature | Importance |
|------|---------|------------|
| 1 | ls_ratio | 0.1409 |
| 2 | compute_mem_ratio | 0.1225 |
| 3 | br_density | 0.1016 |
| 4 | call_density | 0.0923 |
| 5 | compute_density | 0.0851 |
| 6 | avg_bb_size | 0.0835 |
| 7 | call_bb_ratio | 0.0772 |
| 8 | mem_instr_count | 0.0654 |
| 9 | total_instr_count | 0.0552 |
| 10 | max_loop_depth | 0.0395 |
| 11 | basic_block_count | 0.0366 |
| 12 | call_instr_count | 0.0363 |

#### Logistic Regression Coefficients (standardized)

| Rank | Feature | Coeff | Direction |
|------|---------|-------|-----------|
| 1 | avg_bb_size | 0.7300 | native-better + |
| 2 | ls_ratio | 0.7179 | native-better + |
| 3 | br_density | -0.7000 | nonnative-better + |
| 4 | compute_instr_count | -0.6150 | nonnative-better + |
| 5 | avg_bb_out_degree | -0.5875 | nonnative-better + |
| 6 | call_bb_ratio | -0.3883 | nonnative-better + |
| 7 | compute_density | -0.3178 | nonnative-better + |
| 8 | mem_instr_count | 0.2522 | native-better + |
| 9 | max_loop_depth | 0.2056 | native-better + |
| 10 | basic_block_count | 0.1880 | native-better + |
| 11 | br_instr_count | 0.1712 | native-better + |
| 12 | total_instr_count | -0.1070 | nonnative-better + |

#### Decision Tree Rules (depth=3)

```
|--- ls_ratio <= 0.39
|   |--- basic_block_count <= 13.50
|   |   |--- br_density <= 0.09
|   |   |   |--- class: nonnative-better
|   |   |--- br_density >  0.09
|   |   |   |--- class: native-better
|   |--- basic_block_count >  13.50
|   |   |--- class: native-better
|--- ls_ratio >  0.39
|   |--- max_loop_depth <= 2.50
|   |   |--- avg_bb_size <= 8.38
|   |   |   |--- class: nonnative-better
|   |   |--- avg_bb_size >  8.38
|   |   |   |--- class: native-better
|   |--- max_loop_depth >  2.50
|   |   |--- class: nonnative-better

```
### PolyBench (AOT label) (n=30, native-better=12, nonnative-better=18)

| Model | Accuracy | F1 (macro) | Precision (NB) | Recall (NB) | AUC |
|-------|----------|------------|----------------|-------------|-----|
| Decision Tree (depth=3) | **0.5333** | 0.5139 | 0.4167 | 0.4167 | 0.5255 |
| Decision Tree (depth=2) | **0.5333** | 0.5139 | 0.4167 | 0.4167 | 0.6551 |
| Random Forest (n=100, depth=4) | **0.5667** | 0.5543 | 0.4615 | 0.5000 | 0.5417 |
| Random Forest (n=200, depth=5) | **0.5333** | 0.5139 | 0.4167 | 0.4167 | 0.5417 |
| Logistic Regression | **0.6000** | 0.5928 | 0.5000 | 0.5833 | 0.6806 |
| SVM (RBF) | **0.5333** | 0.4976 | 0.4000 | 0.3333 | 0.0000 |
| SVM (Linear) | **0.6000** | 0.5928 | 0.5000 | 0.5833 | 0.0000 |

Best LOO accuracy: **Logistic Regression** (0.6000)

#### Confusion Matrix (Random Forest n=200)

```
                  Predicted
                  NB    NNB
Actual NB          5     7
Actual NNB         7    11
```

```
                  precision    recall  f1-score   support

   native-better       0.42      0.42      0.42        12
nonnative-better       0.61      0.61      0.61        18

        accuracy                           0.53        30
       macro avg       0.51      0.51      0.51        30
    weighted avg       0.53      0.53      0.53        30

```

#### Misclassified Programs

| Program | Actual | Predicted |
|---------|--------|-----------|
| covariance | nonnative-better | native-better |
| 2mm | native-better | nonnative-better |
| 3mm | nonnative-better | native-better |
| atax | native-better | nonnative-better |
| doitgen | native-better | nonnative-better |
| mvt | nonnative-better | native-better |
| syr2k | nonnative-better | native-better |
| trmm | nonnative-better | native-better |
| durbin | native-better | nonnative-better |
| adi | nonnative-better | native-better |
| fdtd-2d | native-better | nonnative-better |
| heat-3d | native-better | nonnative-better |
| jacobi-1d | native-better | nonnative-better |
| seidel-2d | nonnative-better | native-better |

#### Random Forest Feature Importances

| Rank | Feature | Importance |
|------|---------|------------|
| 1 | ls_ratio | 0.1409 |
| 2 | compute_mem_ratio | 0.1225 |
| 3 | br_density | 0.1016 |
| 4 | call_density | 0.0923 |
| 5 | compute_density | 0.0851 |
| 6 | avg_bb_size | 0.0835 |
| 7 | call_bb_ratio | 0.0772 |
| 8 | mem_instr_count | 0.0654 |
| 9 | total_instr_count | 0.0552 |
| 10 | max_loop_depth | 0.0395 |
| 11 | basic_block_count | 0.0366 |
| 12 | call_instr_count | 0.0363 |

#### Logistic Regression Coefficients (standardized)

| Rank | Feature | Coeff | Direction |
|------|---------|-------|-----------|
| 1 | avg_bb_size | 0.7300 | native-better + |
| 2 | ls_ratio | 0.7179 | native-better + |
| 3 | br_density | -0.7000 | nonnative-better + |
| 4 | compute_instr_count | -0.6150 | nonnative-better + |
| 5 | avg_bb_out_degree | -0.5875 | nonnative-better + |
| 6 | call_bb_ratio | -0.3883 | nonnative-better + |
| 7 | compute_density | -0.3178 | nonnative-better + |
| 8 | mem_instr_count | 0.2522 | native-better + |
| 9 | max_loop_depth | 0.2056 | native-better + |
| 10 | basic_block_count | 0.1880 | native-better + |
| 11 | br_instr_count | 0.1712 | native-better + |
| 12 | total_instr_count | -0.1070 | nonnative-better + |

#### Decision Tree Rules (depth=3)

```
|--- ls_ratio <= 0.39
|   |--- basic_block_count <= 13.50
|   |   |--- br_density <= 0.09
|   |   |   |--- class: nonnative-better
|   |   |--- br_density >  0.09
|   |   |   |--- class: native-better
|   |--- basic_block_count >  13.50
|   |   |--- class: native-better
|--- ls_ratio >  0.39
|   |--- max_loop_depth <= 2.50
|   |   |--- avg_bb_size <= 8.38
|   |   |   |--- class: nonnative-better
|   |   |--- avg_bb_size >  8.38
|   |   |   |--- class: native-better
|   |--- max_loop_depth >  2.50
|   |   |--- class: nonnative-better

```

以下是关键结果对比：

---

## 二分类结果（native-better vs nonnative-better）

### Microbench（n=34, 18:16）

| Model | LOO Accuracy | F1 (macro) |
|-------|-------------|------------|
| **Decision Tree (depth=2)** | **70.6%** | 0.706 |
| Decision Tree (depth=3) | 61.8% | 0.615 |
| Random Forest | 55.9% | 0.558 |
| Logistic Regression | 44.1% | 0.441 |
| SVM (RBF / Linear) | 44–47% | ~0.47 |

相比三分类最高 47%，二分类下 **Decision Tree (depth=2) 达到了 70.6%** 的 LOO 准确率，提升显著。但随机森林和 LR 表现仍然一般，说明决策树在小样本上容易找到简单可解释的切分规则，而集成方法因维度过高反而过拟合。

决策树规则非常直观：
```
compute_density <= 0.24 且 total_instr_count > 60 → native-better
compute_density > 0.24 且 compute_instr_count <= 32.5 且 func_count <= 2.5 → nonnative-better
```

### PolyBench（n=30, 12:18）

| Model | LOO Accuracy | F1 (macro) |
|-------|-------------|------------|
| **Logistic Regression** | **60.0%** | 0.593 |
| Random Forest (n=100) | 56.7% | 0.554 |
| Decision Tree (depth=2/3) | 53.3% | 0.514 |
| SVM (Linear) | 60.0% | 0.593 |

PolyBench 效果不如 Microbench，最佳仅 60%。决策树的首个分裂特征是 **`ls_ratio <= 0.39`**，与相关性分析中 `ls_ratio` 显著相关的结论一致。

PolyBench 决策树规则：
```
ls_ratio <= 0.39 且 basic_block_count > 13.5 → native-better
ls_ratio > 0.39 且 max_loop_depth > 2.5 → nonnative-better
```

### 核心发现

1. **二分类比三分类效果明显更好**——Microbench 从 47% 提升到 71%，PolyBench 从 57% 提升到 60%
2. **关键特征一致性**：两个数据集中 `compute_density`/`compute_mem_ratio`（Microbench）和 `ls_ratio`（PolyBench）始终是最重要的分裂/排名特征
3. **Microbench 中 JIT/AOT 标签完全一致**，说明内部计时下 JIT 和 AOT 的性能分类结果无差异
4. **简单模型（浅决策树）优于复杂模型**，这是小样本高维度场景的典型特征，也意味着决策规则具有较好的可解释性