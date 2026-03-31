# JIT vs AOT 对比分析

## 1) 覆盖情况

- 对比程序数：64
- JIT 行数：64
- AOT 行数：64

## 2) 标签分布对比

- JIT native-better: 57
- JIT similar: 5
- JIT wasm-better: 2

- AOT native-better: 56
- AOT similar: 7
- AOT wasm-better: 1

## 3) ratio 总体变化

- mean(ratio)_jit: 1.637648
- mean(ratio)_aot: 1.688614
- mean delta (aot-jit): 0.050966

## 4) 标签翻转样本

- 翻转数量：2

| program | label_jit | label_aot | ratio_jit | ratio_aot | delta |
|---|---|---|---:|---:|---:|
| branch_switch_dense | wasm-better | similar | 0.885517 | 0.939829 | 0.054312 |
| host_write_small | native-better | similar | 1.112137 | 1.074341 | -0.037796 |

## 5) ratio 下降最多的 Top10（AOT 更优）

| program | ratio_jit | ratio_aot | delta |
|---|---:|---:|---:|
| host_time_loop | 2.901097 | 2.467023 | -0.434074 |
| call_indirect | 2.229101 | 1.819179 | -0.409922 |
| alloc_medium_objects | 2.167657 | 1.996183 | -0.171474 |
| call_recursive | 2.583209 | 2.424890 | -0.158319 |
| alloc_fragmented_pattern | 2.106029 | 1.949370 | -0.156659 |
| memory_random_write | 1.312288 | 1.208436 | -0.103852 |
| compute_int_divmod | 1.070556 | 0.973140 | -0.097416 |
| poly_cholesky | 1.497648 | 1.438160 | -0.059488 |
| branch_unpredictable | 1.955541 | 1.900469 | -0.055072 |
| branch_nested | 2.124185 | 2.079255 | -0.044930 |

## 6) ratio 上升最多的 Top10（AOT 更劣）

| program | ratio_jit | ratio_aot | delta |
|---|---:|---:|---:|
| poly_durbin | 2.280626 | 2.738631 | 0.458005 |
| poly_jacobi_2d | 1.900146 | 2.294246 | 0.394100 |
| poly_gemm | 2.065966 | 2.443874 | 0.377908 |
| poly_jacobi_1d | 2.256214 | 2.562288 | 0.306074 |
| poly_gramschmidt | 1.183299 | 1.442389 | 0.259090 |
| poly_bicg | 1.941036 | 2.199675 | 0.258639 |
| poly_atax | 2.166546 | 2.424887 | 0.258341 |
| host_getcwd_loop | 1.783211 | 2.021655 | 0.238444 |
| poly_nussinov | 1.315353 | 1.506146 | 0.190793 |
| poly_mvt | 2.047322 | 2.223197 | 0.175875 |
