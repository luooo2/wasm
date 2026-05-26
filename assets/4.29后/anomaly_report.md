# 异常样本报告

- input: `/home/luomz/wasm/assets/4.29后/static_perf_join_llvm_direct.csv`
- iqr_k: `3.0`
- total anomalies: `55`

## Top anomalies (by metric/value)

| program                     | mode     | metric                                  |     value |      q1 |      q3 |      iqr |   lower_bound |   upper_bound | reason                      |
|:----------------------------|:---------|:----------------------------------------|----------:|--------:|--------:|---------:|--------------:|--------------:|:----------------------------|
| llvmss_shootout_hello       | wasm-jit | ratio_L1_icache_load_misses_over_native |  12.798   | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_oscar       | wasm-jit | ratio_L1_icache_load_misses_over_native |  11.8309  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_shootout_hello       | wasm-aot | ratio_L1_icache_load_misses_over_native |  11.5375  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_intmm       | wasm-jit | ratio_L1_icache_load_misses_over_native |  11.517   | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_realmm      | wasm-jit | ratio_L1_icache_load_misses_over_native |  11.4517  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_oscar       | wasm-aot | ratio_L1_icache_load_misses_over_native |  10.7863  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_queens      | wasm-jit | ratio_L1_icache_load_misses_over_native |  10.5691  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_intmm       | wasm-aot | ratio_L1_icache_load_misses_over_native |  10.4432  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_perm        | wasm-jit | ratio_L1_icache_load_misses_over_native |  10.4257  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_bubblesort  | wasm-jit | ratio_L1_icache_load_misses_over_native |  10.4198  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_towers      | wasm-jit | ratio_L1_icache_load_misses_over_native |  10.2864  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_stanford_realmm      | wasm-aot | ratio_L1_icache_load_misses_over_native |  10.0662  | 4.36512 | 9.54363 | 5.17851  |     -11.1704  |      25.0792  | ratio_gt_10                 |
| llvmss_misc_flops-4         | wasm-jit | ratio_all_loads_retired_over_native     | 294.466   | 1.6129  | 3.92252 | 2.30962  |      -5.31596 |      10.8514  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_flops-4         | wasm-aot | ratio_all_loads_retired_over_native     | 293.988   | 1.6129  | 3.92252 | 2.30962  |      -5.31596 |      10.8514  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_flops-7         | wasm-jit | ratio_all_loads_retired_over_native     | 255.015   | 1.6129  | 3.92252 | 2.30962  |      -5.31596 |      10.8514  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_mandel-2        | wasm-jit | ratio_all_loads_retired_over_native     | 254.705   | 1.6129  | 3.92252 | 2.30962  |      -5.31596 |      10.8514  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_flops-7         | wasm-aot | ratio_all_loads_retired_over_native     | 254.596   | 1.6129  | 3.92252 | 2.30962  |      -5.31596 |      10.8514  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_mandel-2        | wasm-aot | ratio_all_loads_retired_over_native     | 254.455   | 1.6129  | 3.92252 | 2.30962  |      -5.31596 |      10.8514  | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-jit | ratio_all_loads_retired_over_native     |  20.5531  | 1.6129  | 3.92252 | 2.30962  |      -5.31596 |      10.8514  | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-aot | ratio_all_loads_retired_over_native     |  18.0022  | 1.6129  | 3.92252 | 2.30962  |      -5.31596 |      10.8514  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_flops-8         | wasm-jit | ratio_all_stores_retired_over_native    | 422.568   | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_flops-8         | wasm-aot | ratio_all_stores_retired_over_native    | 422.37    | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_mandel-2        | wasm-jit | ratio_all_stores_retired_over_native    | 256.294   | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_mandel-2        | wasm-aot | ratio_all_stores_retired_over_native    | 256.102   | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-jit | ratio_all_stores_retired_over_native    |  20.9566  | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-aot | ratio_all_stores_retired_over_native    |  18.7127  | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_stanford_intmm       | wasm-jit | ratio_all_stores_retired_over_native    |  14.4343  | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_stanford_realmm      | wasm-jit | ratio_all_stores_retired_over_native    |  13.9011  | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_stanford_intmm       | wasm-aot | ratio_all_stores_retired_over_native    |  13.0696  | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_stanford_realmm      | wasm-aot | ratio_all_stores_retired_over_native    |  12.366   | 1.53512 | 4.11785 | 2.58274  |      -6.21309 |      11.8661  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_salsa20         | wasm-aot | ratio_branch_misses_over_native         |  26.3587  | 2.43998 | 7.15957 | 4.71959  |     -11.7188  |      21.3183  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_salsa20         | wasm-jit | ratio_branch_misses_over_native         |  25.2736  | 2.43998 | 7.15957 | 4.71959  |     -11.7188  |      21.3183  | above_iqr_bound;ratio_gt_10 |
| llvmss_stanford_floatmm     | wasm-jit | ratio_branch_misses_over_native         |  13.9093  | 2.43998 | 7.15957 | 4.71959  |     -11.7188  |      21.3183  | ratio_gt_10                 |
| llvmss_stanford_floatmm     | wasm-aot | ratio_branch_misses_over_native         |  13.894   | 2.43998 | 7.15957 | 4.71959  |     -11.7188  |      21.3183  | ratio_gt_10                 |
| llvmss_stanford_intmm       | wasm-jit | ratio_branch_misses_over_native         |  11.5633  | 2.43998 | 7.15957 | 4.71959  |     -11.7188  |      21.3183  | ratio_gt_10                 |
| llvmss_shootout_hello       | wasm-jit | ratio_branch_misses_over_native         |  11.0433  | 2.43998 | 7.15957 | 4.71959  |     -11.7188  |      21.3183  | ratio_gt_10                 |
| llvmss_stanford_intmm       | wasm-aot | ratio_branch_misses_over_native         |  10.325   | 2.43998 | 7.15957 | 4.71959  |     -11.7188  |      21.3183  | ratio_gt_10                 |
| llvmss_stanford_realmm      | wasm-jit | ratio_branch_misses_over_native         |  10.2907  | 2.43998 | 7.15957 | 4.71959  |     -11.7188  |      21.3183  | ratio_gt_10                 |
| llvmss_benchmarkgame_puzzle | wasm-jit | ratio_branches_retired_over_native      |  29.0981  | 1.0192  | 3.69597 | 2.67677  |      -7.01111 |      11.7263  | above_iqr_bound;ratio_gt_10 |
| llvmss_benchmarkgame_puzzle | wasm-aot | ratio_branches_retired_over_native      |  29.087   | 1.0192  | 3.69597 | 2.67677  |      -7.01111 |      11.7263  | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-jit | ratio_branches_retired_over_native      |  20.5391  | 1.0192  | 3.69597 | 2.67677  |      -7.01111 |      11.7263  | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-aot | ratio_branches_retired_over_native      |  18.5677  | 1.0192  | 3.69597 | 2.67677  |      -7.01111 |      11.7263  | above_iqr_bound;ratio_gt_10 |
| llvmss_stanford_intmm       | wasm-jit | ratio_branches_retired_over_native      |  12.6444  | 1.0192  | 3.69597 | 2.67677  |      -7.01111 |      11.7263  | above_iqr_bound;ratio_gt_10 |
| llvmss_stanford_intmm       | wasm-aot | ratio_branches_retired_over_native      |  11.8229  | 1.0192  | 3.69597 | 2.67677  |      -7.01111 |      11.7263  | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_evalloop        | wasm-jit | ratio_conditional_branches_over_native  |  31.6274  | 1.00221 | 1.97386 | 0.971644 |      -1.91272 |       4.88879 | above_iqr_bound;ratio_gt_10 |
| llvmss_misc_evalloop        | wasm-aot | ratio_conditional_branches_over_native  |  31.3383  | 1.00221 | 1.97386 | 0.971644 |      -1.91272 |       4.88879 | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-jit | ratio_conditional_branches_over_native  |  21.4884  | 1.00221 | 1.97386 | 0.971644 |      -1.91272 |       4.88879 | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-aot | ratio_conditional_branches_over_native  |  19.6407  | 1.00221 | 1.97386 | 0.971644 |      -1.91272 |       4.88879 | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-jit | ratio_cpu_cycles_over_native            |  20.0719  | 1.00199 | 2.81167 | 1.80968  |      -4.42705 |       8.24071 | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-aot | ratio_cpu_cycles_over_native            |  18.0325  | 1.00199 | 2.81167 | 1.80968  |      -4.42705 |       8.24071 | above_iqr_bound;ratio_gt_10 |
| llvmss_stanford_intmm       | wasm-jit | ratio_cpu_cycles_over_native            |  10.4218  | 1.00199 | 2.81167 | 1.80968  |      -4.42705 |       8.24071 | above_iqr_bound;ratio_gt_10 |
| llvmss_stanford_intmm       | wasm-aot | ratio_cpu_cycles_over_native            |   9.15881 | 1.00199 | 2.81167 | 1.80968  |      -4.42705 |       8.24071 | above_iqr_bound             |
| llvmss_stanford_realmm      | wasm-jit | ratio_cpu_cycles_over_native            |   8.29412 | 1.00199 | 2.81167 | 1.80968  |      -4.42705 |       8.24071 | above_iqr_bound             |
| llvmss_shootout_hello       | wasm-jit | ratio_instructions_retired_over_native  |  20.8552  | 1.00278 | 2.44672 | 1.44395  |      -3.32906 |       6.77856 | above_iqr_bound;ratio_gt_10 |
| llvmss_shootout_hello       | wasm-aot | ratio_instructions_retired_over_native  |  18.4167  | 1.00278 | 2.44672 | 1.44395  |      -3.32906 |       6.77856 | above_iqr_bound;ratio_gt_10 |
