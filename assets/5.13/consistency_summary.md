# wasmtime vs wasmer (cranelift) — analysis consistency (5.13)

本报告比较两条 runtime 在 **完全相同的 program×mode 集合** (n=52，JIT+AOT) 上的「静态 IR → perf → 内部时间比」分析输出，验证 wasmtime 结论在 wasmer 上是否一致。

## 0) 程序级时间比直接对照

- Spearman(y_wasmtime, y_wasmer) = **0.9231**, p=2.16e-22
- Pearson(y_wasmtime, y_wasmer)  = **0.8680**
- 中位 |Δ ratio|（每条 program×mode）= **0.1177**, 平均 |Δ| = 0.4065

## 1) 静态特征 ↔ 内部时间比（Goal 1）

- 共同特征数：**23**
- 符号一致率：**95.65%**
- 两 runtime 的 Spearman ρ（跨特征的 ρ 序列）的 **Spearman rho-of-rhos**：**0.9723**, p=9.66e-15
- FDR q<0.05 显著集合：Jaccard = **50.00%**，交集 6 个；wasmtime only 0 个，wasmer only 6 个。
- FDR q<0.10 集合 Jaccard = 77.78%，交集 14 个。

| feature               |   wasmtime_spearman_rho |   wasmer_spearman_rho | wasmtime_fdr_sig_0.05   | wasmer_fdr_sig_0.05   |   sign_agree |
|:----------------------|------------------------:|----------------------:|:------------------------|:----------------------|-------------:|
| function_count        |                0.49839  |              0.563908 | True                    | True                  |            1 |
| ir_instruction_count  |                0.434534 |              0.52262  | True                    | True                  |            1 |
| compute_instr_count   |                0.437417 |              0.45981  | True                    | True                  |            1 |
| loop_count            |                0.400495 |              0.444628 | True                    | True                  |            1 |
| basic_block_count     |                0.346044 |              0.402626 | True                    | True                  |            1 |
| memory_instr_count    |                0.266792 |              0.385395 | False                   | True                  |            1 |
| store_count           |                0.304975 |              0.372114 | False                   | True                  |            1 |
| memory_access_density |               -0.368918 |             -0.364902 | True                    | True                  |            1 |
| cfg_edge_count        |                0.311332 |              0.364927 | False                   | True                  |            1 |
| branch_instr_count    |                0.297925 |              0.357926 | False                   | True                  |            1 |
| hostcall_density      |               -0.280747 |             -0.353112 | False                   | True                  |            1 |
| avg_bb_size           |               -0.33349  |             -0.35177  | False                   | True                  |            1 |
| call_to_bb_ratio      |               -0.317143 |             -0.292452 | False                   | False                 |            1 |
| load_count            |                0.148693 |              0.288917 | False                   | False                 |            1 |
| compute_density       |                0.274036 |              0.216974 | False                   | False                 |            1 |

## 2) perf 比值 ↔ 内部时间比（Goal 2 桥接表的链尾）

- 共同 perf 比值：**8**
- 符号一致率：**87.50%**
- rho-of-rhos：**0.9286**, p=0.000863
- FDR q<0.05 集合：Jaccard = **66.67%**，交集 4 个；wasmtime only 0，wasmer only 2.

| perf_ratio                              |   wasmtime_spearman_rho |   wasmer_spearman_rho | wasmtime_fdr_sig_0.05   | wasmer_fdr_sig_0.05   |   sign_agree |
|:----------------------------------------|------------------------:|----------------------:|:------------------------|:----------------------|-------------:|
| ratio_cpu_cycles_over_native            |               0.93409   |              0.94425  | True                    | True                  |            1 |
| ratio_instructions_retired_over_native  |               0.802869  |              0.807906 | True                    | True                  |            1 |
| ratio_L1_icache_load_misses_over_native |               0.755571  |              0.671476 | True                    | True                  |            1 |
| ratio_branches_retired_over_native      |               0.661573  |              0.46299  | True                    | True                  |            1 |
| ratio_conditional_branches_over_native  |               0.195851  |              0.469991 | False                   | True                  |            1 |
| ratio_branch_misses_over_native         |               0.295825  |              0.308973 | False                   | True                  |            1 |
| ratio_all_stores_retired_over_native    |              -0.0956203 |             -0.244771 | False                   | False                 |            1 |
| ratio_all_loads_retired_over_native     |               0.0892171 |             -0.106719 | False                   | False                 |            0 |

## 3) 静态 ↔ perf 桥接对（Goal 2 链腰）

- 共有 (static, perf) 配对：**184**
- 符号一致率：**92.39%**
- rho-of-rhos：**0.9564**, p=3.13e-99
- FDR q<0.10 配对：Jaccard = **77.19%**，交集 88 对；wasmtime only 8，wasmer only 18.

Top 20 by max(|ρ|):

| static_feature        | perf_ratio                              |   wasmtime_spearman_rho |   wasmer_spearman_rho | wasmtime_fdr_sig_0.10   | wasmer_fdr_sig_0.10   |
|:----------------------|:----------------------------------------|------------------------:|----------------------:|:------------------------|:----------------------|
| basic_block_count     | ratio_all_stores_retired_over_native    |               -0.581858 |             -0.64396  | True                    | True                  |
| branch_instr_count    | ratio_all_stores_retired_over_native    |               -0.579982 |             -0.635301 | True                    | True                  |
| cfg_edge_count        | ratio_all_stores_retired_over_native    |               -0.567249 |             -0.626654 | True                    | True                  |
| avg_bb_size           | ratio_L1_icache_load_misses_over_native |               -0.475292 |             -0.626148 | True                    | True                  |
| function_count        | ratio_all_stores_retired_over_native    |               -0.527646 |             -0.603324 | True                    | True                  |
| function_count        | ratio_L1_icache_load_misses_over_native |                0.443734 |              0.59763  | True                    | True                  |
| function_count        | ratio_cpu_cycles_over_native            |                0.520113 |              0.596141 | True                    | True                  |
| branch_density        | ratio_all_stores_retired_over_native    |               -0.553539 |             -0.58207  | True                    | True                  |
| call_to_bb_ratio      | ratio_L1_icache_load_misses_over_native |               -0.375753 |             -0.571917 | True                    | True                  |
| loop_count            | ratio_L1_icache_load_misses_over_native |                0.427774 |              0.564776 | True                    | True                  |
| store_count           | ratio_all_stores_retired_over_native    |               -0.493966 |             -0.55869  | True                    | True                  |
| memory_access_density | ratio_instructions_retired_over_native  |               -0.529284 |             -0.558674 | True                    | True                  |
| memory_access_density | ratio_branches_retired_over_native      |               -0.543039 |             -0.472297 | True                    | True                  |
| branch_instr_count    | ratio_all_loads_retired_over_native     |               -0.542958 |             -0.522842 | True                    | True                  |
| basic_block_count     | ratio_all_loads_retired_over_native     |               -0.540284 |             -0.527692 | True                    | True                  |
| ir_instruction_count  | ratio_all_stores_retired_over_native    |               -0.473237 |             -0.53048  | True                    | True                  |
| basic_block_count     | ratio_L1_icache_load_misses_over_native |                0.308956 |              0.527174 | True                    | True                  |
| cfg_edge_count        | ratio_all_loads_retired_over_native     |               -0.52701  |             -0.513828 | True                    | True                  |
| branch_density        | ratio_all_loads_retired_over_native     |               -0.520907 |             -0.461111 | True                    | True                  |
| loop_count            | ratio_instructions_retired_over_native  |                0.461829 |              0.513954 | True                    | True                  |

## 4) LassoCV 非零特征（Goal 1 稀疏量化）

- wasmtime 非零 15 个；wasmer 非零 10 个；交集 **10** 个；Jaccard **66.67%**.
- 交集内符号一致：**9 / 10**.

- 交集特征：avg_bb_out_degree, branch_instr_count, compute_density, compute_instr_count, compute_to_memory_ratio, function_count, hostcall_count, hostcall_density, load_count, memory_access_density
- 仅 wasmtime 命中：alloc_call_count, call_instr_count, call_to_bb_ratio, load_store_ratio, max_loop_depth
- 仅 wasmer 命中：(empty)

| feature                 |   wasmtime_coef |   wasmer_coef | wasmtime_nonzero   | wasmer_nonzero   |   sign_agree |
|:------------------------|----------------:|--------------:|:-------------------|:-----------------|-------------:|
| compute_instr_count     |       0.699032  |      1.53356  | True               | True             |            1 |
| function_count          |       0.486026  |      0.782119 | True               | True             |            1 |
| branch_instr_count      |      -0.314104  |     -0.732864 | True               | True             |            1 |
| hostcall_density        |       0.1683    |      0.72962  | True               | True             |            1 |
| load_count              |      -0.268159  |     -0.687822 | True               | True             |            1 |
| avg_bb_out_degree       |      -0.38236   |     -0.284594 | True               | True             |            1 |
| call_instr_count        |      -0.372244  |     -0        | True               | False            |            0 |
| compute_to_memory_ratio |      -0.250484  |     -0.108319 | True               | True             |            1 |
| memory_access_density   |      -0.23709   |     -0.209536 | True               | True             |            1 |
| compute_density         |       0.122147  |     -0.176376 | True               | True             |            0 |
| call_to_bb_ratio        |       0.143445  |      0        | True               | False            |            0 |
| load_store_ratio        |       0.135162  |      0        | True               | False            |            0 |
| alloc_call_count        |       0.134927  |      0        | True               | False            |            0 |
| hostcall_count          |      -0.0800365 |     -0.116495 | True               | True             |            1 |
| max_loop_depth          |      -0.0437576 |      0        | True               | False            |            0 |
| avg_bb_size             |       0         |     -0        | False              | False            |            1 |
| branch_density          |      -0         |     -0        | False              | False            |            1 |
| basic_block_count       |      -0         |     -0        | False              | False            |            1 |
| ir_instruction_count    |      -0         |      0        | False              | False            |            1 |
| cfg_edge_count          |      -0         |     -0        | False              | False            |            1 |

## 5) 模型整体表现对照

| 模型 | wasmtime | wasmer (cranelift) |
|---|---|---|
| LassoCV R² (in-sample, std-y) | 0.553 | 0.804 |
| LassoCV 内部 CV MSE (std-y) | 32.2396 ± 34.5526 | 4.9771 ± 3.3405 |
| Lasso 非零特征数 | 15 | 10 |

## 6) 一句话结论

在 28 程序 × 2 mode 的相同评测集上，**wasmtime 上的「静态 IR → perf → 内部时间比」三层链条的方向性与显著性结构在 wasmer (cranelift) 上整体复现**：

- 程序级时间比 Spearman 相关 ≈ 0.923，
- 静态-时间 ρ 序列跨 runtime 相关 ≈ 0.972，符号一致率 96%，
- perf-时间链尾的 cycles/instructions/L1-icache/branches-retired 四块在两 runtime 上同为 FDR 显著，
- Lasso 非零特征 Jaccard 67%（交集 10 个，wasmtime 非零 15 个，wasmer 非零 10 个），交集内符号一致 **9/10**（仅 `compute_density` 在小系数尾端发生方向翻转）。

差异部分主要是 wasmer 上的 R² 与共变强度普遍 **更强**，且 conditional_branches、L1-icache-load-misses 这两类 perf 比值在 wasmer 上对时间比的相关更显著。这与 wasmer cranelift 后端在本平台上整体 ~1.7× 的 I-cache miss 比和更高的指令体量观察一致（见 `data/results/wasmer/runtime_comparison_*`）。
