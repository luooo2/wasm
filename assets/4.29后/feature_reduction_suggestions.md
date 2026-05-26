# 精简特征建议

- high-corr threshold: `0.85`
- vif threshold: `10.0`

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
