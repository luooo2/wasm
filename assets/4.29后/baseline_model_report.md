# 最小可解释基线模型

- target: `ratio_instructions_retired_over_native`
- selected feature count: `8`
- selected features: `memory_access_density, hostcall_density, ir_instruction_count, compute_to_memory_ratio, max_loop_depth, branch_density, call_instr_count, load_store_ratio`

## 交叉验证指标

|   n_samples |   n_features |   cv_folds |   cv_rmse_mean |   cv_rmse_std |   cv_r2_mean |   cv_r2_std |   ols_r2 |   ols_adj_r2 |   ols_f_pvalue |
|------------:|-------------:|-----------:|---------------:|--------------:|-------------:|------------:|---------:|-------------:|---------------:|
|          52 |            8 |          5 |        1.61428 |      0.345245 |     0.292513 |    0.574399 | 0.850272 |     0.822416 |    2.52458e-15 |

## OLS 标准化系数（可解释）

| feature                 |       coef |     p_value |   std_err |   t_value |
|:------------------------|-----------:|------------:|----------:|----------:|
| hostcall_density        |  3.2681    | 7.29941e-10 |  0.415371 |  7.86791  |
| const                   |  2.82377   | 1.7675e-16  |  0.217424 | 12.9874   |
| max_loop_depth          |  1.12498   | 0.0104254   |  0.419958 |  2.6788   |
| memory_access_density   | -0.925333  | 0.0226464   |  0.391366 | -2.36437  |
| ir_instruction_count    |  0.688223  | 0.0341009   |  0.314451 |  2.18865  |
| load_store_ratio        | -0.651562  | 0.0623937   |  0.340558 | -1.91322  |
| branch_density          | -0.352239  | 0.329186    |  0.356895 | -0.986955 |
| compute_to_memory_ratio | -0.161643  | 0.704351    |  0.423161 | -0.381989 |
| call_instr_count        | -0.0257577 | 0.94677     |  0.383555 | -0.067155 |

## OLS 摘要（截断）

```text
                                      OLS Regression Results                                      
==================================================================================================
Dep. Variable:     ratio_instructions_retired_over_native   R-squared:                       0.850
Model:                                                OLS   Adj. R-squared:                  0.822
Method:                                     Least Squares   F-statistic:                     30.52
Date:                                    Wed, 29 Apr 2026   Prob (F-statistic):           2.52e-15
Time:                                            22:53:36   Log-Likelihood:                -92.229
No. Observations:                                      52   AIC:                             202.5
Df Residuals:                                          43   BIC:                             220.0
Df Model:                                               8                                         
Covariance Type:                                nonrobust                                         
===========================================================================================
                              coef    std err          t      P>|t|      [0.025      0.975]
-------------------------------------------------------------------------------------------
const                       2.8238      0.217     12.987      0.000       2.385       3.262
memory_access_density      -0.9253      0.391     -2.364      0.023      -1.715      -0.136
hostcall_density            3.2681      0.415      7.868      0.000       2.430       4.106
ir_instruction_count        0.6882      0.314      2.189      0.034       0.054       1.322
compute_to_memory_ratio    -0.1616      0.423     -0.382      0.704      -1.015       0.692
max_loop_depth              1.1250      0.420      2.679      0.010       0.278       1.972
branch_density             -0.3522      0.357     -0.987      0.329      -1.072       0.368
call_instr_count           -0.0258      0.384     -0.067      0.947      -0.799       0.748
load_store_ratio           -0.6516      0.341     -1.913      0.062      -1.338       0.035
==============================================================================
Omnibus:                        1.077   Durbin-Watson:                   1.179
Prob(Omnibus):                  0.584   Jarque-Bera (JB):                0.936
Skew:                           0.320   Prob(JB):                        0.626
Kurtosis:                       2.846   Cond. No.                         5.26
==============================================================================

Notes:
[1] Standard Errors assume that the covariance matrix of the errors is correctly specified.
... (truncated)
```