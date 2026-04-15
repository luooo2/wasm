# PolyBench core 3-feature regression summary

Core features: `compute_density`, `ls_ratio`, `compute_mem_ratio`

## JIT
- In-sample R^2: 0.2699
- Adjusted R^2: 0.1856
- LOOCV Q^2: -0.6345
- LOOCV MAE: 0.4580
- LOOCV RMSE: 0.7867
- Coefficients [intercept, compute_density, ls_ratio, compute_mem_ratio]: [6.4244, 60.621, -13.9025, -20.5279]

## AOT
- In-sample R^2: 0.2672
- Adjusted R^2: 0.1827
- LOOCV Q^2: -0.6039
- LOOCV MAE: 0.4578
- LOOCV RMSE: 0.7841
- Coefficients [intercept, compute_density, ls_ratio, compute_mem_ratio]: [6.4956, 61.5717, -14.0887, -20.9042]
