# Static-Perf 关联分析概览

- input: `/home/luomz/wasm/assets/4.29后/static_perf_join_llvm_direct.csv`
- top_k scatter: `9`
- corr_threshold: `0.85`
- vif_threshold: `10.0`

## 1) Spearman top relations

| x_feature               | y_metric                                |   n |   spearman_rho |     p_value |   abs_rho | direction   |
|:------------------------|:----------------------------------------|----:|---------------:|------------:|----------:|:------------|
| basic_block_count       | ratio_all_stores_retired_over_native    |  52 |      -0.581858 | 6.06308e-06 |  0.581858 | negative    |
| branch_instr_count      | ratio_all_stores_retired_over_native    |  52 |      -0.579982 | 6.60206e-06 |  0.579982 | negative    |
| branch_density          | ratio_all_stores_retired_over_native    |  52 |      -0.553539 | 2.07747e-05 |  0.553539 | negative    |
| memory_access_density   | ratio_branches_retired_over_native      |  52 |      -0.543039 | 3.18945e-05 |  0.543039 | negative    |
| branch_instr_count      | ratio_all_loads_retired_over_native     |  52 |      -0.542958 | 3.19985e-05 |  0.542958 | negative    |
| basic_block_count       | ratio_all_loads_retired_over_native     |  52 |      -0.540284 | 3.56074e-05 |  0.540284 | negative    |
| memory_access_density   | ratio_instructions_retired_over_native  |  52 |      -0.529284 | 5.47533e-05 |  0.529284 | negative    |
| branch_density          | ratio_all_loads_retired_over_native     |  52 |      -0.520907 | 7.52358e-05 |  0.520907 | negative    |
| avg_bb_size             | ratio_L1_icache_load_misses_over_native |  52 |      -0.475292 | 0.000369945 |  0.475292 | negative    |
| ir_instruction_count    | ratio_all_stores_retired_over_native    |  52 |      -0.473237 | 0.00039543  |  0.473237 | negative    |
| branch_density          | ratio_branch_misses_over_native         |  52 |      -0.472216 | 0.00040867  |  0.472216 | negative    |
| ir_instruction_count    | ratio_all_loads_retired_over_native     |  52 |      -0.471699 | 0.000415534 |  0.471699 | negative    |
| compute_density         | ratio_branches_retired_over_native      |  52 |       0.465383 | 0.000508174 |  0.465383 | positive    |
| compute_instr_count     | ratio_cpu_cycles_over_native            |  52 |       0.460493 | 0.000592275 |  0.460493 | positive    |
| avg_bb_size             | ratio_conditional_branches_over_native  |  52 |      -0.444539 | 0.000961204 |  0.444539 | negative    |
| ir_instruction_count    | ratio_cpu_cycles_over_native            |  52 |       0.441625 | 0.00104747  |  0.441625 | positive    |
| memory_access_density   | ratio_cpu_cycles_over_native            |  52 |      -0.4406   | 0.00107943  |  0.4406   | negative    |
| hostcall_density        | ratio_instructions_retired_over_native  |  52 |      -0.435303 | 0.00125892  |  0.435303 | negative    |
| ir_instruction_count    | ratio_instructions_retired_over_native  |  52 |       0.430177 | 0.00145758  |  0.430177 | positive    |
| compute_to_memory_ratio | ratio_branches_retired_over_native      |  52 |       0.415994 | 0.00216089  |  0.415994 | positive    |
| avg_bb_size             | ratio_all_stores_retired_over_native    |  52 |       0.393457 | 0.00390582  |  0.393457 | positive    |
| compute_instr_count     | ratio_branches_retired_over_native      |  52 |       0.392206 | 0.00403157  |  0.392206 | positive    |
| compute_instr_count     | ratio_instructions_retired_over_native  |  52 |       0.39212  | 0.00404029  |  0.39212  | positive    |
| memory_instr_count      | ratio_all_stores_retired_over_native    |  52 |      -0.386507 | 0.00465059  |  0.386507 | negative    |
| memory_instr_count      | ratio_all_loads_retired_over_native     |  52 |      -0.385908 | 0.00472022  |  0.385908 | negative    |
| memory_access_density   | ratio_L1_icache_load_misses_over_native |  52 |      -0.370883 | 0.00679473  |  0.370883 | negative    |
| branch_instr_count      | ratio_branch_misses_over_native         |  52 |      -0.370412 | 0.00687102  |  0.370412 | negative    |
| basic_block_count       | ratio_branch_misses_over_native         |  52 |      -0.369677 | 0.00699128  |  0.369677 | negative    |
| basic_block_count       | ratio_instructions_retired_over_native  |  52 |       0.36709  | 0.00742987  |  0.36709  | positive    |
| memory_access_density   | ratio_conditional_branches_over_native  |  52 |      -0.363621 | 0.00805525  |  0.363621 | negative    |
| avg_bb_size             | ratio_cpu_cycles_over_native            |  52 |      -0.359458 | 0.00886555  |  0.359458 | negative    |
| hostcall_density        | ratio_all_loads_retired_over_native     |  52 |       0.358922 | 0.00897498  |  0.358922 | positive    |
| compute_instr_count     | ratio_all_stores_retired_over_native    |  52 |      -0.357506 | 0.00926929  |  0.357506 | negative    |
| hostcall_density        | ratio_branches_retired_over_native      |  52 |      -0.349267 | 0.0111533   |  0.349267 | negative    |
| compute_instr_count     | ratio_all_loads_retired_over_native     |  52 |      -0.345456 | 0.0121311   |  0.345456 | negative    |
| avg_bb_size             | ratio_instructions_retired_over_native  |  52 |      -0.344424 | 0.012408    |  0.344424 | negative    |
| avg_bb_size             | ratio_all_loads_retired_over_native     |  52 |       0.343741 | 0.0125944   |  0.343741 | positive    |
| call_instr_count        | ratio_conditional_branches_over_native  |  52 |      -0.342239 | 0.0130124   |  0.342239 | negative    |
| basic_block_count       | ratio_cpu_cycles_over_native            |  52 |       0.341559 | 0.0132058   |  0.341559 | positive    |
| max_loop_depth          | ratio_branches_retired_over_native      |  52 |       0.340343 | 0.0135576   |  0.340343 | positive    |

## 2) Top scatter plots

|   rank | x_feature             | y_metric                                |   spearman_rho |     p_value |   n | plot_path                                                                                                               |
|-------:|:----------------------|:----------------------------------------|---------------:|------------:|----:|:------------------------------------------------------------------------------------------------------------------------|
|      1 | basic_block_count     | ratio_all_stores_retired_over_native    |      -0.581858 | 6.06308e-06 |  52 | /home/luomz/wasm/assets/4.29后/figures_top_scatter/01_basic_block_count__ratio_all_stores_retired_over_native.png       |
|      2 | branch_instr_count    | ratio_all_stores_retired_over_native    |      -0.579982 | 6.60206e-06 |  52 | /home/luomz/wasm/assets/4.29后/figures_top_scatter/02_branch_instr_count__ratio_all_stores_retired_over_native.png      |
|      3 | branch_density        | ratio_all_stores_retired_over_native    |      -0.553539 | 2.07747e-05 |  52 | /home/luomz/wasm/assets/4.29后/figures_top_scatter/03_branch_density__ratio_all_stores_retired_over_native.png          |
|      4 | memory_access_density | ratio_branches_retired_over_native      |      -0.543039 | 3.18945e-05 |  52 | /home/luomz/wasm/assets/4.29后/figures_top_scatter/04_memory_access_density__ratio_branches_retired_over_native.png     |
|      5 | branch_instr_count    | ratio_all_loads_retired_over_native     |      -0.542958 | 3.19985e-05 |  52 | /home/luomz/wasm/assets/4.29后/figures_top_scatter/05_branch_instr_count__ratio_all_loads_retired_over_native.png       |
|      6 | basic_block_count     | ratio_all_loads_retired_over_native     |      -0.540284 | 3.56074e-05 |  52 | /home/luomz/wasm/assets/4.29后/figures_top_scatter/06_basic_block_count__ratio_all_loads_retired_over_native.png        |
|      7 | memory_access_density | ratio_instructions_retired_over_native  |      -0.529284 | 5.47533e-05 |  52 | /home/luomz/wasm/assets/4.29后/figures_top_scatter/07_memory_access_density__ratio_instructions_retired_over_native.png |
|      8 | branch_density        | ratio_all_loads_retired_over_native     |      -0.520907 | 7.52358e-05 |  52 | /home/luomz/wasm/assets/4.29后/figures_top_scatter/08_branch_density__ratio_all_loads_retired_over_native.png           |
|      9 | avg_bb_size           | ratio_L1_icache_load_misses_over_native |      -0.475292 | 0.000369945 |  52 | /home/luomz/wasm/assets/4.29后/figures_top_scatter/09_avg_bb_size__ratio_L1_icache_load_misses_over_native.png          |

## 3) Feature reduction suggestions

| kind           | feature_a               | feature_b               |   pair_spearman_corr |   mean_abs_corr_to_y_a |   mean_abs_corr_to_y_b | suggest_keep         | suggest_drop            | reason              |        vif |
|:---------------|:------------------------|:------------------------|---------------------:|-----------------------:|-----------------------:|:---------------------|:------------------------|:--------------------|-----------:|
| high_corr_pair | ir_instruction_count    | basic_block_count       |             0.879722 |               0.322782 |               0.365429 | basic_block_count    | ir_instruction_count    | |rho| >= 0.85       |  nan       |
| high_corr_pair | ir_instruction_count    | branch_instr_count      |             0.859368 |               0.322782 |               0.346925 | branch_instr_count   | ir_instruction_count    | |rho| >= 0.85       |  nan       |
| high_corr_pair | ir_instruction_count    | compute_instr_count     |             0.908998 |               0.322782 |               0.287969 | ir_instruction_count | compute_instr_count     | |rho| >= 0.85       |  nan       |
| high_corr_pair | basic_block_count       | branch_instr_count      |             0.994057 |               0.365429 |               0.346925 | basic_block_count    | branch_instr_count      | |rho| >= 0.85       |  nan       |
| high_corr_pair | basic_block_count       | branch_density          |             0.855753 |               0.365429 |               0.289946 | basic_block_count    | branch_density          | |rho| >= 0.85       |  nan       |
| high_corr_pair | branch_instr_count      | branch_density          |             0.87449  |               0.346925 |               0.289946 | branch_instr_count   | branch_density          | |rho| >= 0.85       |  nan       |
| high_corr_pair | compute_density         | compute_to_memory_ratio |             0.857583 |               0.209734 |               0.192917 | compute_density      | compute_to_memory_ratio | |rho| >= 0.85       |  nan       |
| vif            | ir_instruction_count    |                         |           nan        |               0.322782 |             nan        |                      | ir_instruction_count    | VIF=1365.458 > 10.0 | 1365.46    |
| vif            | basic_block_count       |                         |           nan        |               0.365429 |             nan        |                      | basic_block_count       | VIF=1341.890 > 10.0 | 1341.89    |
| vif            | branch_instr_count      |                         |           nan        |               0.346925 |             nan        |                      | branch_instr_count      | VIF=1039.203 > 10.0 | 1039.2     |
| vif            | compute_instr_count     |                         |           nan        |               0.287969 |             nan        |                      | compute_instr_count     | VIF=646.364 > 10.0  |  646.364   |
| vif            | memory_instr_count      |                         |           nan        |               0.188112 |             nan        |                      | memory_instr_count      | VIF=170.667 > 10.0  |  170.667   |
| vif            | hostcall_density        |                         |           nan        |               0.267419 |             nan        |                      | hostcall_density        | VIF=86.490 > 10.0   |   86.49    |
| vif            | avg_bb_out_degree       |                         |           nan        |               0.218844 |             nan        |                      | avg_bb_out_degree       | VIF=49.644 > 10.0   |   49.6445  |
| vif            | avg_bb_size             |                         |           nan        |               0.355956 |             nan        |                      | avg_bb_size             | VIF=48.634 > 10.0   |   48.6341  |
| vif            | memory_access_density   |                         |           nan        |               0.358281 |             nan        |                      | memory_access_density   | VIF=44.247 > 10.0   |   44.2472  |
| vif            | branch_density          |                         |           nan        |               0.289946 |             nan        |                      | branch_density          | VIF=44.183 > 10.0   |   44.183   |
| vif            | compute_density         |                         |           nan        |               0.209734 |             nan        |                      | compute_density         | VIF=42.265 > 10.0   |   42.2649  |
| vif            | load_store_ratio        |                         |           nan        |               0.180909 |             nan        |                      | load_store_ratio        | VIF=31.257 > 10.0   |   31.257   |
| vif            | compute_to_memory_ratio |                         |           nan        |               0.192917 |             nan        |                      | compute_to_memory_ratio | VIF=24.095 > 10.0   |   24.0953  |
| vif            | max_loop_depth          |                         |           nan        |               0.199028 |             nan        |                      | max_loop_depth          | VIF=12.357 > 10.0   |   12.3573  |
| vif            | call_instr_count        |                         |           nan        |               0.14514  |             nan        | call_instr_count     |                         | VIF=7.407           |    7.40654 |
