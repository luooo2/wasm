# 结论加固报告

- 目标变量: `ratio_instructions_retired_over_native`
- 特征子集: 来自 `final_feature_subset_v1.csv`（共 8 个）
- Winsorize: 对 y 在分位数 [0.025, 0.975] 处截断后再做 OLS

> **说明**：`mode_wasm-*` 每组仅约 26 个样本、8 个特征，K 折交叉验证的 `R²` 可能为负或波动极大，**不宜作为泛化能力结论**；分层部分请以 **同号 Spearman** 与 **回归系数方向** 为主，CV 仅作参考。

## 1) 关键特征系数符号是否一致（pooled：OLS vs RLM vs Winsor-OLS）

| feature               |   sign_ols |   sign_rlm_huber |   sign_ols_winsor_y |   all_three_agree |
|:----------------------|-----------:|-----------------:|--------------------:|------------------:|
| memory_access_density |         -1 |               -1 |                  -1 |                 1 |
| hostcall_density      |          1 |                1 |                   1 |                 1 |
| ir_instruction_count  |          1 |                1 |                   1 |                 1 |
| max_loop_depth        |          1 |                1 |                   1 |                 1 |

> `all_three_agree=1` 表示三种模型下系数符号一致且非零。

## 2) 拟合度与交叉验证（按 pooled / 分 mode）

| scope            |   n |   cv_n_splits |   ols_r2 |   ols_adj_r2 |   ols_winsor_y_r2 |   cv_r2_mean |   cv_r2_std |   cv_r2_mean_winsor_y |   cv_r2_std_winsor_y |
|:-----------------|----:|--------------:|---------:|-------------:|------------------:|-------------:|------------:|----------------------:|---------------------:|
| pooled_all_modes |  52 |             5 | 0.850272 |     0.822416 |          0.803329 |     0.292513 |    0.574399 |               0.37781 |             0.47398  |
| mode_wasm-aot    |  26 |             2 | 0.845628 |     0.772982 |          0.724332 |    -1.51309  |    0.50441  |              -1.75854 |             0.252563 |
| mode_wasm-jit    |  26 |             2 | 0.861264 |     0.795977 |          0.740453 |    -1.39687  |    0.768949 |              -1.40401 |             0.132465 |

## 3) 输出文件

- `robustness_models_coefficients.csv`
- `robustness_key_feature_signs.csv`
- `stratified_spearman.csv`
- `stratified_regression_coefficients.csv`
- `stratified_regression_metrics.csv`
- `anomaly_case_notes.md`
