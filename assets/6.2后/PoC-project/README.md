# PoC：面向 WebAssembly `wasm-opt` Pass 选择的反馈驱动 LLM 智能体

这是 `../plan.md` 和 `../最小原型试验 PoC.md` 中研究方向对应的**最小原型实验（PoC）**。它验证的是一个完整闭环：

> **结构诊断 → 策略生成 → 工具执行 → 正确性验证 → 性能收益**

LLM **不直接重写 wasm**。它根据程序的静态结构特征，以及可选的 wasm/native perf 比值，为每个程序选择一小组 Binaryen `wasm-opt` pass。随后由工具链实际应用这些 pass，验证 wasm 模块，对比 native 参考输出做差分测试，并在 **wasmer（cranelift）** 运行时上 benchmark。只有语义正确且真实变快的候选才会被接受。

实验程序来自已经构建好的 `llvm-test-suite` `SingleSource/Benchmarks`，对应的 wasm/native 产物位于 `<repo>/data/build/llvm_direct/`。

---

## 1. 流水线

```
llvm-test-suite C  ──（已预构建）──►  baseline .wasm  +  .native  (data/build/llvm_direct 下)
                                           │
              s02_extract_features.py  ───┤  wasm-opt --metrics  →  静态特征
                                           │  既有 wasmer perf CSV → wasm/native perf 比值
                                           ▼
              s03_make_prompts.py        prompts（static / static+perf 两种变体）
                                           ▼
              s04_llm_select.py          LLM 从允许列表中选择 ≤5 个 pass
                                           │   provider: manual | openai | heuristic
                                           ▼
              s05_strategies.py          将策略解析为 wasm-opt 调用
              s06_evaluate.py            wasm-opt → wasm-validate → diff-test → benchmark
                                           ▼
              s07_run_all.py             遍历所有程序 → results/results.csv
              s08_summarize.py           results/summary.md, pivot.csv, figures/*.png
```

## 2. 目录结构

```
PoC-project/
├── README.md
├── requirements.txt
├── run_poc.sh                 # 一键端到端运行脚本
├── config/
│   ├── allowed_passes.txt     # LLM 可选择的 16 个 wasm-opt pass
│   └── programs.csv           # 12 个选定 benchmark（含类别、baseline ratio）
├── poc/                       # 流水线脚本（可 import，仅依赖标准库）
│   ├── common.py              # 路径、wasmer/native 运行 harness、TIME_NS 解析、统计函数
│   ├── s02_extract_features.py
│   ├── s03_make_prompts.py
│   ├── s04_llm_select.py
│   ├── s05_strategies.py
│   ├── s06_evaluate.py
│   ├── s07_run_all.py
│   └── s08_summarize.py
├── work/                      # 中间产物
│   ├── features.json          # 每个程序的静态特征、分桶和 perf 比值
│   ├── perf_summary.csv
│   ├── prompts/               # <program>.<variant>.txt + index.json
│   ├── llm_responses/         # <program>.<variant>.json（LLM 的回答）
│   └── selections.json        # 归一化并验证后的 pass 列表
├── candidates/                # 优化后的 <program>.<strategy>.wasm（以及 .wasmu）
└── results/
    ├── results.csv            # 每个（program, strategy）一行
    ├── pivot.csv              # 每个程序一行，横向对比所有策略
    ├── summary.md             # 面向 RQ 的实验总结
    ├── run_log.txt
    └── figures/               # ratio_by_program.png, speedup_over_O3.png
```

## 3. 选定程序（12 个）

从 30 个可运行的 `llvm_direct` benchmark 中选择，优先考虑 wasmer 上 wasm/native slowdown 较高的程序，并覆盖三类结构特征：

| 类别 | 程序 |
|---|---|
| `control_flow`（分支/控制流密集） | benchmarkgame_puzzle, misc_evalloop, stanford_puzzle, stanford_queens |
| `loop_compute`（循环计算密集） | misc_matmul_f64_4x4, misc_salsa20, misc_flops, misc_flops-1, stanford_floatmm |
| `call_dense`（大量小函数调用） | misc_richards_benchmark, stanford_perm, stanford_towers |

各程序的 baseline wasmer-aot ratio 见 `config/programs.csv`。

## 4. 对比策略

| 策略 | 含义 |
|---|---|
| `raw` | baseline wasm，不运行 `wasm-opt`；作为每个程序的 speedup 参考 |
| `O2` / `O3` | 固定的强 `wasm-opt` 优化等级；作为需要超越的 baseline |
| `random` | 从允许 pass 集合中按固定 seed 随机选择的 pass list |
| `llm_static` | LLM 只根据**静态特征**选择 pass（消融：无 perf） |
| `llm_static_perf` | LLM 根据**静态特征 + perf 反馈**选择 pass |

## 5. LLM 输入与允许 pass

Prompt（见 `work/prompts/`）向模型提供：程序类别、baseline wasm/native ratio、定性静态特征（函数/循环/基本块数量，branch/call/memory/compute density 的 low/medium/high 分桶），以及在 `static_perf` 变体中提供 `instructions_retired`、`cpu_cycles`、`L1-icache-load-misses`、`branches_retired`、`branch_misses`、loads/stores 等 wasm/native perf 比值。这些 perf 数据复用了此前的 wasmer perf-stat 采集结果。

模型必须只返回 JSON：

```json
{ "diagnosis": "...", "passes": ["--pass-a", "--pass-b"], "expected_effect": "..." }
```

pass 被限制在 `config/allowed_passes.txt` 中的 16 个候选内，覆盖 inlining、控制流简化、死代码删除、local/CSE 清理、常量折叠和 peephole 指令优化。`s04_llm_select.py` 会对选择结果进行校验、去重，并限制最多 5 个 pass。

### LLM provider

- `manual`（默认）：读取 `work/llm_responses/<program>.<variant>.json` 中预先生成的回答。当前提交的回答由 LLM（Claude）基于每个程序的 `features.json` 条目推理得到。这一路径可复现且无需网络。
- `openai`：调用 OpenAI 兼容的 chat API。设置 `OPENAI_API_KEY`，可选设置 `OPENAI_BASE_URL`、`OPENAI_MODEL`，然后运行 `python3 s04_llm_select.py --provider openai`。返回结果会缓存到 `work/llm_responses/`，之后可再走 `manual` 路径复现。
- `heuristic`：透明的规则选择器（不是 LLM），作为确定性兜底和额外消融点。

## 6. 正确性验证与接受规则

对每个候选：

1. `wasm-validate` 必须通过。
2. wasmer stdout 在去掉计时行和运行时噪声后，必须与 native 二进制的参考输出**完全一致**（差分测试）。
3. Benchmark 使用 N 次重复的内部 `TIME_NS` median。AOT 模式下先 `wasmer compile` 一次，再重复 `wasmer run x.wasmu`。

接受规则与 PoC 文档一致：候选只有在 valid、correct，且 median runtime 比 `raw` 至少快 **3%** 时才被标记为 **accepted**。小于 3% 的变化视为测量噪声。

## 7. 如何运行

`PATH` 上需要有：`wasmer`（cranelift）、`wasm-opt`、`wasm-validate`、`python3`。仓库中还需要已经存在预构建产物 `data/build/llvm_direct/*.wasm` / `*.native`。

```bash
# 使用已提交的（manual）LLM 回答运行完整流水线
bash run_poc.sh

# 或从 poc/ 目录分步运行
python3 s02_extract_features.py
python3 s03_make_prompts.py
python3 s04_llm_select.py --provider manual
python3 s07_run_all.py --repeats 8 --warmup 2
python3 s08_summarize.py
```

可调参数：`run_poc.sh` 支持通过环境变量设置 `REPEATS`、`WARMUP`、`TIMEOUT`、`PROVIDER`；`s07_run_all.py` 可通过 `--programs a,b,c` 只运行部分程序。

## 8. 本 PoC 回答的研究问题

- **RQ1**：静态结构能否指导优化选择？本 PoC 的 prompt 由静态特征构成，其中一个变体额外加入 perf。
- **RQ2**：LLM 能否超过 `wasm-opt -O3`？每个程序的 `speedup_vs_O3` 记录在 `results/results.csv`，汇总见 `summary.md`。
- **RQ3**：优化是否降低 wasm/native ratio？见每个策略的 `wasm_native_ratio`。
- **RQ4**：static-only 与 static+perf 的消融效果如何？比较 `llm_static` 与 `llm_static_perf`。
- **RQ5**：方法在 wasmer 上是否有效？整个闭环均运行在 wasmer/cranelift 上。

## 9. 预期与限制

baseline wasm 已经由 `clang -O2` 生成，因此 `wasm-opt` 和 LLM 的额外优化空间有限；许多程序相对 `-O3` 的差异在 ±1–2% 内。本 PoC 的核心目标是证明闭环能够端到端运行且可测量，而不是声称存在普遍的大幅加速。短时 benchmark（towers、queens、perm，约 10–25 ms）噪声更大；运行时间更长的程序（puzzle、matmul、richards、salsa20、evalloop、flops）更可靠。

### 最新运行的关键结果（`results/summary.md`）

- 共 72 条策略结果；**70/72 通过验证且差分正确**。仅有 2 个失败来自 `random` 策略在 `richards` 和 `floatmm` 上生成了不可构建的 pass 顺序，说明验证闸门能正确拒绝坏候选。**所有 LLM 选择的 pass list 都成功构建并通过验证。**
- **LLM（static）在 5/12 个程序上超过 `wasm-opt -O3`**（获胜样本平均 +3.0%）；**LLM（static+perf）在 4/12 个程序上超过 -O3**（获胜样本平均 +4.6%）；random 只有 1/12 超过 -O3。
- 最清晰、最符合诊断预期的胜例是 **`richards_benchmark`（call-dense）**：LLM 诊断出调用开销，并优先选择 `--inlining-optimizing`，获得 **相对 -O3 +6.2%** 的提升（ratio 1.85 → 1.73）。在 `floatmm` 和 `perm` 上，LLM 也超过 -O3，部分原因是 -O3 本身会让这些程序回退，而 LLM 的保守 pass list 避免了这种回退。
- 相对 raw 的平均 wasm/native ratio 变化：-O3 为 −0.031，LLM static 为 −0.047，LLM static+perf 为 −0.056。LLM 变体平均上至少不差于 -O3，且 perf 反馈变体略好，支持 RQ4 中“perf 反馈有帮助”的消融结论。

这些是诚实的混合结果：在已经优化过的模块上，`-O3` 在算术密集 kernel（salsa20、evalloop、matmul）上仍然更强；而 LLM 针对性生成、经过验证的 pass list 在调用/控制流密集程序上更容易获胜。完整闭环——诊断 → 选择 → 应用 → 验证 → 差分测试 → benchmark → 接受/拒绝——已经在 wasmer 上端到端跑通。完整表格见 `results/summary.md` 和 `results/pivot.csv`。
