# wasm
my graduation project： wasm vs native 性能分析

## 项目运行说明

- `docker build -t wasm-dev .`  
  构建容器
- `docker run -it -v "%cd%":/code --name wasm-dev-container wasm-dev`  
  启动容器（不自动删除）
- `exit`  
  退出（容器仍在后台）
- `docker start -ai wasm-dev-container`  
  再次进入
- `docker rm wasm-dev-container`  
  彻底删除容器（当不再需要时）

> 若 wasmtime 安装失败，可手动执行：`curl https://wasmtime.dev/install.sh -sSf | bash`

## 环境说明（容器内）

- native 编译器：`clang`（Ubuntu clang version 18.1.3）
- wasm 编译器：`/opt/wasi-sdk/bin/clang`（22.1.0-wasi-sdk (https://github.com/llvm/llvm-project 4434dabb69916856b824f68a64b029c67175e532)）
- runtime：`wasmtime` 43.0.0 (be23469ec 2026-03-20)

---

## 研究流水线脚本（可直接执行）

当前项目使用以下 3 个脚本：

- 编译脚本：`src/build_benchmarks.py`
- 批量运行+打标签脚本：`src/run_benchmarks.py`
- 特征提取脚本：`src/extract_features.py`

### 1) 自动编译（native + LLVM IR + wasm）

在容器内项目根目录执行：

```bash
cd /code
python3 src/build_benchmarks.py \
  --src-dir data/microbenchmarks \
  --out-dir data/build \
  --native-cc clang \
  --wasi-cc /opt/wasi-sdk/bin/clang \
  --opt=-O2 \
  --wasi-target wasm32-wasip1
```

产物：
- `data/build/*.native`
- `data/build/*.ll`
- `data/build/*.wasm`
- `data/build/build_report.csv`

---

### 2) 批量运行 + 自动打标签

```bash
cd /code
python3 src/run_benchmarks.py \
  --build-dir data/build \
  --out-csv data/results/labels.csv \
  --wasmtime wasmtime \
  --repeats 5 \
  --timeout 180 \
  --threshold 0.10
```

标签规则（基于 \(r = T_{wasm}/T_{native}\)）：
- `r > 1 + threshold` → `native-better`
- `r < 1 - threshold` → `wasm-better`
- 其他 → `similar`

产物：
- `data/results/labels.csv`

---

### 3) 特征提取（基于 .c + .ll）

```bash
cd /code
python3 src/extract_features.py \
  --src-dir data/microbenchmarks \
  --ir-dir data/build \
  --out-csv data/results/features.csv
```

产物：
- `data/results/features.csv`

---

## 一键顺序执行（推荐）

每次更新微基准后，直接按下面顺序跑：

```bash
cd /code
python3 src/build_benchmarks.py --src-dir data/microbenchmarks --out-dir data/build --native-cc clang --wasi-cc /opt/wasi-sdk/bin/clang --opt=-O2 --wasi-target wasm32-wasip1
python3 src/run_benchmarks.py --build-dir data/build --out-csv data/results/labels.csv --wasmtime wasmtime --repeats 5 --timeout 180 --threshold 0.10
python3 src/extract_features.py --src-dir data/microbenchmarks --ir-dir data/build --out-csv data/results/features.csv
```

---

## 输出文件说明

- 编译报告：`data/build/build_report.csv`
- 标签结果：`data/results/labels.csv`
- 特征结果：`data/results/features.csv`
- 合并后数据集（若执行了合并步骤）：`data/results/dataset_labeled.csv`

---

## 常见问题

1. **wasm 编译失败，提示 target 参数问题**  
   请确认脚本使用的是 `-target wasm32-wasip1`（不是 `--target`）。

2. **容器里找不到 wasmtime**  
   在容器内安装后重试：

```bash
curl https://wasmtime.dev/install.sh -sSf | bash
```

3. **运行超时**  
   可适当提高 `--timeout`，例如 `--timeout 300`。