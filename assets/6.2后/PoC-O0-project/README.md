# PoC-O0-project：以 `-O0` 为 baseline 的 LLM 引导 wasm-opt pass 选择实验

本项目在原 `PoC-project` 的基础上重做实验：编译源文件时使用 **`-O0`** 生成 raw wasm baseline，然后再比较 `wasm-opt -O3`、随机 pass 序列和 LLM 选择 pass 序列的效果。

这样做的原因是：原实验的 raw wasm 已经由 `-O2` 编译得到，后续再使用 `wasm-opt -O3` 或 LLM 选择 pass 时可优化空间较小；改为 `-O0` 后，wasm 中会保留更多未优化结构，例如冗余 locals、未内联小函数、死代码、未合并基本块等，更适合验证“LLM 能否根据静态特征和 perf 数据选择合适 pass 序列”这一想法。

## 实验假设

> 当 raw baseline 改为 `-O0` 后，`wasm-opt -O3` 应该相对 raw 有更明显提升；LLM 可以根据 O0 wasm 的结构特征识别出更合适的 pass 组合，例如 local cleanup、inlining、DCE、CFG cleanup；static features + perf data 链路可能暴露出与 O2 baseline 不同的规律。

## 实际运行结论

本项目已经完成一次完整运行：

- 12 个程序均成功以 `-O0` 编译。
- 采集了 O0 raw wasm 的 static features 和 perf 数据。
- 生成了 24 个 prompt，并由手工 LLM 响应写入 `work/llm_responses/`。
- 使用 `repeats=6, warmup=2` 跑完 60 条策略结果。
- 输出结果在 `results/summary.md`、`results/pivot.csv` 和 `results/figures/`。

关键观察：

- `wasm-opt -O3` 相比 O0 raw 的平均加速只有 **3.9%**，不如预期中“大幅提升”。主要原因是 wasmer/cranelift AOT 会对 wasm 再做后端优化，而 native 侧仍是 `-O0`，所以一些程序的 raw wasm/native ratio 甚至小于 1。
- LLM 方案在部分程序上能超过 `-O3`：`llm_static` 在 5/12 个程序上快于 `-O3`，`llm_static_perf` 在 4/12 个程序上快于 `-O3`。
- `static+perf` 的获胜数量少于 `static-only`，但获胜程序的平均幅度更大（4.6% vs 2.1%）。
- `misc_flops` 的 raw/O3/LLM 都未通过差分测试，原因不是 pass 破坏语义，而是该 benchmark 会输出内部 RunTime/MFLOPS 和浮点 signed-zero，native 与 wasm 输出本身存在格式差异。
- `stanford_floatmm` 的 random 策略有一次 Binaryen 构建失败，错误为 “IR must be flat: run --flatten beforehand”，属于随机 pass 序列不稳定导致的无效候选。

## 目录结构

```
PoC-O0-project/
├── config/
│   ├── programs.csv          # 12 个程序；s01 会写入 O0 baseline ratio
│   └── allowed_passes.txt    # 允许 LLM 选择的 pass 列表
├── build/                    # s01 生成的 O0 *.native / *.wasm / *.ll
├── perf/
│   ├── collect_perf_o0.sh    # 对 O0 raw wasm 采集 perf stat
│   └── perf_raw_events_o0_wasmer_cranelift.csv
├── poc/
│   ├── common.py             # 共享路径和 benchmark helper
│   ├── s01_build_o0.py       # 使用 -O0 编译并测量 baseline
│   ├── s02_extract_features.py  # static features + perf ratios
│   ├── s03_make_prompts.py   # 生成 O0-aware LLM prompt
│   ├── s04_llm_select.py     # manual / openai / heuristic provider
│   ├── s05_strategies.py     # raw | O3 | random | llm_static | llm_static_perf
│   ├── s06_evaluate.py       # build + validate + diff-test + benchmark
│   ├── s07_run_all.py        # 跑完整策略实验
│   └── s08_summarize.py      # 生成中文 summary.md、pivot.csv 和图表
├── work/                     # 中间文件
│   ├── features.json
│   ├── perf_summary.csv
│   ├── prompts/
│   ├── llm_responses/        # manual provider 使用的 LLM JSON 响应
│   └── selections.json
├── candidates/               # 各策略生成的 wasm 候选
├── results/                  # 实验结果
│   ├── summary.md
│   ├── pivot.csv
│   ├── run_log.txt
│   └── figures/
├── requirements.txt
└── run_poc_o0.sh             # end-to-end orchestration script
```

## 运行步骤

### 步骤 0：编译 O0 binaries

```bash
python3 poc/s01_build_o0.py [--wasi-cc /opt/wasi-sdk/bin/clang]
```

该步骤会把 12 个程序用 `-O0` 编译到 `build/`，并跑一个快速 benchmark，将 O0 baseline timing 写回 `config/programs.csv`。

### 步骤 1：提取静态特征

```bash
python3 poc/s02_extract_features.py
```

### 步骤 P：采集 perf 数据

```bash
bash perf/collect_perf_o0.sh --repeats 5 --warmup 1
python3 poc/s02_extract_features.py   # 重新运行，将 perf ratios 合并进 features.json
```

### 步骤 2：生成 prompts

```bash
python3 poc/s03_make_prompts.py
```

prompt 会写入 `work/prompts/<program>.static.txt` 和 `work/prompts/<program>.static_perf.txt`。其中系统提示强调 O0 wasm 的典型冗余：local bloat、缺少 inlining、DCE 未执行、基本块未合并等。

### 步骤 3：获取 LLM pass selections

**manual provider（推荐用于复现）**

将 LLM 响应放入 `work/llm_responses/<program>.static.json` 和 `<program>.static_perf.json`。每个文件格式如下：

```json
{
  "diagnosis": "...",
  "passes": ["--simplify-locals", "--inlining-optimizing", "..."],
  "expected_effect": "..."
}
```

然后运行：

```bash
python3 poc/s04_llm_select.py --provider manual
```

**OpenAI API**

```bash
export OPENAI_API_KEY=sk-...
export OPENAI_MODEL=gpt-4o
python3 poc/s04_llm_select.py --provider openai
```

**heuristic provider（无需 LLM）**

```bash
python3 poc/s04_llm_select.py --provider heuristic
```

### 步骤 4：运行实验

```bash
python3 poc/s07_run_all.py --repeats 15 --warmup 3
```

本次实际运行使用的是：

```bash
python3 poc/s07_run_all.py --repeats 6 --warmup 2 --timeout 300
```

### 步骤 5：汇总结果

```bash
python3 poc/s08_summarize.py
```

### 一键运行

```bash
# heuristic baseline（无需 LLM）
PROVIDER=heuristic bash run_poc_o0.sh

# OpenAI API + perf 数据
PROVIDER=openai WITH_PERF=1 REPEATS=15 WARMUP=3 bash run_poc_o0.sh
```

## 与原 PoC-project（O2 baseline）的差异

| | PoC-project | PoC-O0-project |
|---|---|---|
| 编译 baseline | `-O2` | **`-O0`** |
| build 目录 | `data/build/llvm_direct` | `build/`（项目内） |
| perf 数据 | `data/results/wasmer/perf_llvm/...` | `perf/perf_raw_events_o0_...` |
| 策略集合 | raw, O2, O3, random, llm_static, llm_static_perf | raw, **O3**, random, llm_static, llm_static_perf |
| pass 列表 | 15 个 | **19 个**（增加 `ssa`, `merge-locals`, `reorder-locals`） |
| prompt | 通用 wasm-opt 指导 | **O0-specific**：强调 local bloat、missing inlining、DCE、unmerged blocks |
| 新增静态特征 | 无 | `local_bloat`, `block_density` |

## 如何解读结果

- **RQ1**：`wasm-opt -O3` 相比 O0 raw 有多少提升，用来判断 O0 baseline 的优化空间。
- **RQ2**：LLM 选择的 pass 序列能否超过 `wasm-opt -O3`。
- **RQ3**：LLM 优化是否降低 wasm/native ratio。
- **RQ4**：static-only 与 static+perf 的消融对比。

`results/summary.md` 和 `results/figures/` 给出了完整答案。
