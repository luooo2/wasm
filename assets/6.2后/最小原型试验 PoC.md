我理解你现在要的是一个能尽快证明“LLM 智能体确实能利用现有规律改进 wasm 性能”的最小 PoC，而不是完整论文系统。我会把它压缩成可落地的实验闭环：选少量程序、少量优化动作、明确 baseline、明确接受标准。
可以把最小 PoC 设计成：

> LLM 不直接改 wasm，而是根据静态特征 + perf 结果，为每个 wasm 程序选择一组 `wasm-opt` 优化 pass；系统自动编译、验证、benchmark，只接受比 baseline 更快的结果。

这样最小、可控、容易写成论文雏形。

## PoC 目标

证明一件事就够：

> 相比固定优化策略，LLM 根据程序特征选择 wasm 优化策略，能在部分 benchmark 上降低 wasm/native slowdown，并且这种收益能被自动验证。

不要一开始做“LLM 直接修改 wasm 字节码”。那个工程风险太高。PoC 先做 **LLM-guided wasm pass selection**，仍然属于 wasm 层优化。

## 实验对象

先选 10-20 个程序，不要全量。

优先选你现有数据中：

- wasm/native time ratio 高的程序；
- `instructions_retired`、`cpu_cycles`、`L1-icache-load-misses`、`branches_retired` 膨胀明显的程序；
- 静态特征上有代表性：函数多、循环多、基本块多、分支密度高。

最好分三类：

- 函数/调用密集型：`function_count` 高；
- 控制流复杂型：`basic_block_count`、`branch_density` 高；
- 循环计算型：`loop_count`、`compute_instr_count` 高。

PoC 不追求覆盖全部 workload，而是验证框架能跑通。

## 最小系统流程

```text
C source
  ↓ clang/emcc
baseline wasm
  ↓ extract static features + baseline perf
LLM selects wasm-opt pass list
  ↓ wasm-opt executes selected passes
optimized wasm
  ↓ wasm-validate + differential test
benchmark on wasmtime/wasmer
  ↓ accept if correct and faster
```

核心文件可以只做 4 个脚本：

```text
scripts/
  build_wasm.py          # C -> wasm
  measure.py             # 运行 wasmtime/wasmer + perf
  llm_select_passes.py   # 调 LLM 生成 pass list
  evaluate_candidate.py  # wasm-opt + validate + benchmark + accept/reject
```

## LLM 输入设计

给模型的 prompt 不要直接塞完整 wasm。最小 PoC 只给摘要：

```text
Program: foo.c

Baseline:
- wasm/native time ratio: 2.31
- ratio_instructions_retired: 2.80
- ratio_cpu_cycles: 2.45
- ratio_L1_icache_load_misses: 3.10
- ratio_branches_retired: 2.20

Static features:
- function_count: high
- loop_count: medium
- basic_block_count: high
- branch_density: high
- memory_access_density: low

Task:
Choose up to 5 wasm-opt passes from the allowed list.
Goal: reduce runtime without changing semantics.
Return JSON only:
{
  "diagnosis": "...",
  "passes": ["..."],
  "expected_effect": "..."
}
```

限制 allowed pass 很重要。先只允许 10-15 个 pass，例如：

```text
--flatten
--rereloop
--remove-unused-brs
--remove-unused-names
--dce
--remove-unused-module-elements
--local-cse
--code-folding
--precompute
--optimize-instructions
--simplify-locals
--vacuum
--inlining
--inlining-optimizing
--merge-blocks
```

最终执行：

```bash
wasm-opt input.wasm -o output.wasm <LLM passes...>
```

## Baseline 设计

最小 PoC 至少比较 4 组：

1. `raw wasm`
2. `wasm-opt -O3`
3. `random pass list`
4. `LLM selected pass list`

如果时间允许，加一个：

5. `LLM + feedback`：第一轮失败或变慢后，把结果反馈给 LLM，再选一次。

这样就能回答：LLM 是不是比固定策略或随机策略更有用。

## 正确性验证

PoC 阶段不用追求完全形式化，但必须有自动验证。

最低配：

```text
1. wasm-validate 通过
2. 对同一输入，raw wasm 和 optimized wasm 输出一致
3. 多组测试输入输出一致
4. benchmark 至少重复 10 次，取 median
```

如果程序来自 `llvm-test-suite`，尽量复用它自带的 reference output。

接受规则：

```text
accept candidate if:
- wasm-validate passes
- output matches baseline on all test inputs
- median runtime improves by >= 3%
```

小于 3% 先不算，避免测量噪声。

## 最小实验指标

表格不需要太复杂，先记录这些：

```text
program
baseline_time
O3_time
random_time
llm_time
llm_speedup_over_O3
wasm_native_ratio_before
wasm_native_ratio_after
instructions_ratio_before
instructions_ratio_after
correctness_passed
selected_passes
```

关键结果看三点：

- LLM 是否能找到至少若干个比 `wasm-opt -O3` 更快的 case；
- LLM 优化后 slowdown ratio 是否下降；
- perf 指标是否沿着你前期发现的链条下降，例如 instructions/cycles/I-cache/branches。

## 最小实验假设

你可以先写成三个 hypothesis：

- **H1**：LLM 根据静态特征和 perf 摘要选择的 wasm pass list，在部分程序上能超过固定 `wasm-opt -O3`。
- **H2**：性能收益主要来自 `instructions_retired`、`cpu_cycles`、`L1-icache-load-misses`、`branches_retired` 的下降。
- **H3**：加入 perf 反馈的 LLM 比只看静态特征的 LLM 更稳定。

## 最小消融

PoC 做两个消融就够：

1. **Static-only LLM**：只给静态特征，不给 perf。
2. **Static + perf LLM**：给静态特征和 perf ratio。

如果第二个更好，就能把你前期研究自然接上：

> 前期统计发现的 perf 链条不只是解释变量，也可以作为 LLM 优化决策的反馈信号。

## 最小结论形态

哪怕只得到这样的结果，也能算 PoC 成功：

```text
在 15 个高 slowdown benchmark 上，
LLM selected pass list 有 6 个程序超过 wasm-opt -O3，
平均在成功样本上获得 5-12% runtime speedup，
且优化后的 instructions/cycles ratio 同步下降。
```

不要求所有程序都提升。编译优化本来就不是全局稳定收益，重点是证明框架可行。

## 推荐第一版实现顺序

1. 先手工选 10 个 slowdown 明显的 wasm 程序。
2. 写脚本跑 `raw wasm`、`wasm-opt -O3`、随机 pass。
3. 写一个 prompt，让 LLM 输出 pass list JSON。
4. 自动调用 `wasm-opt` 生成候选。
5. 跑 `wasm-validate` 和输出一致性测试。
6. 跑 wasmtime benchmark，记录 median runtime。
7. 如果候选变慢，把结果反馈给 LLM，再尝试第二轮。
8. 汇总 CSV，画 `before/after slowdown ratio` 和 `speedup over O3`。

最小 PoC 的核心不是“模型多聪明”，而是先证明这个闭环存在：**规律诊断 → 策略生成 → 工具执行 → 正确性验证 → 性能收益**。