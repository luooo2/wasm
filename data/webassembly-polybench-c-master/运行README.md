进入容器后：

- 编译各内核
cd /code
python3 src/build_polybench.py

- 运行
python3 src/run_polybench.py

- 特征提取
python3 src/extract_polybench_features.py --out-csv data/results/dataset_polybench.csv