你现在的研究不应该再停留在“解释 wasm 为什么慢”，而是要往下一步讲成：

> 我已经发现：wasm/native 性能差异主要来自指令数、周期、I-cache、分支和函数调用相关开销，而不是单纯访存。  
> 所以后续目标是：让 LLM 根据这些静态结构和运行反馈，自动选择或生成 wasm/IR 层优化候选，并通过工具链验证，只接受语义正确且真实变快的版本。

这就是老师说的“类似编译器后端优化的智能体框架”。

## 研究主线怎么讲

可以把故事讲成四段：

1. **现象发现**：同一程序编译到 wasm 后，相对 native 的 slowdown 在 wasmtime/wasmer 上高度一致。慢的核心不是 loads/stores，而是 `instructions_retired`、`cpu_cycles`、`I-cache misses`、`branches` 等执行路径膨胀。

2. **结构归因**：`function_count`、`loop_count`、`basic_block_count`、`branch_density`、`IR instruction count` 等静态特征能解释 slowdown，说明 wasm 的性能劣势和程序结构有关。

3. **优化假设**：既然静态结构能预测慢，LLM 就可以作为“优化机会分析器”，根据结构特征、perf 反馈、wasm/WAT/IR 片段，判断应该做哪类后端优化，例如内联、控制流简化、局部变量合并、死代码删除、分支简化、循环相关优化。

4. **智能体框架**：LLM 不直接当可信编译器，而是生成候选优化策略或 transform；真正改写由 `wasm-opt`、WAT transform、LLVM pass 或脚本执行；正确性由验证器、差分测试、round-trip、benchmark 决定。

你的论文题目方向可以类似：

> A Feedback-Guided LLM Agent for WebAssembly Backend Optimization  
> 或  
> Static-Feature-Guided LLM Optimization for Reducing WebAssembly Native Performance Gap

## 重点放在哪里

重点不要继续无限扩运行时。两个运行时已经足够证明规律不是偶然。后续最多再加一个 runtime 做泛化验证，但主线应转向：

**从“分析 wasm 为什么慢”转向“利用这些规律自动优化 wasm”。**

优先级建议是：

1. **最高优先级：wasm-level pass/transform 智能体**
   不建议一上来手改二进制字节流，而是把 wasm 反汇编成 WAT，或使用 Binaryen `wasm-opt` pass。这样仍然是在 wasm 层优化，但工程可控。

2. **中等优先级：LLM 生成优化策略，而不是直接生成新 wasm**
   让模型输出 `wasm-opt` pass list、优化计划、局部 transform 规则。工具执行，模型不直接决定最终代码。

3. **兜底方案：LLVM IR 层**
   如果 wasm/WAT transform 太难，可以退到 LLVM IR。优点是可以借鉴 Alive2 做形式化等价验证，也更贴近 `LLM Compiler` 和 `Verified Learning for Compiler Optimization`。

## 和相关论文的关系

`Large Language Models for Compiler Optimization` 和 `Meta LLM Compiler` 的核心启发是：LLM 最安全的位置不是直接生成优化后代码，而是预测 pass list。最终代码仍由 LLVM 执行。你可以把这个思想迁移到 wasm：让 LLM 预测 `wasm-opt` pass list 或 LLVM pass list，目标从 code size 改成 runtime 和 wasm/native gap。

`CompilerGPT` 的启发是：优化应该是反馈闭环。输入不只是代码，还要有编译器报告、perf 数据、运行时间和失败信息。你的系统可以把静态特征、perf ratio、wasm-opt 输出、benchmark 结果都塞进 agent loop。

`Verified Learning for Compiler Optimization` 最重要的是正确性边界：LLM 只负责 proposal，验证器负责裁决。如果在 LLVM IR 层，可以用 Alive2；如果在 wasm 层，可以用 `wasm-validate`、差分执行、测试输入、多个 runtime、wasm-to-C/round-trip 作为组合验证。

`Don’t Transform the Code, Code the Transforms` 对你很有价值：不要让 LLM 每次直接改 wasm，而是让它生成可复用的 transform/pass/script。这样更可解释，也更像“后端优化规则学习”。

`SmellDetector` 的启发是“先检测机会，再执行优化”。你可以把 code smell 换成 wasm optimization smell，例如：函数过多、基本块碎、分支密度高、局部变量冗余、重复 load、死分支、短函数调用频繁等。

Refactoring 类论文主要给你评价方法启发：多候选生成、validator 过滤、pass@k / correct@k、消融实验。它们不能直接证明 LLM 能做编译优化，但能支持“候选生成 + 自动验证”的方法论。

## 你具体该做什么

建议设计一个三层 agent：

```text
输入：wasm/WAT/LLVM IR + 静态特征 + perf ratio + baseline runtime
        ↓
LLM 诊断：判断 slowdown 类型
        ↓
候选生成：wasm-opt pass list / WAT transform / LLVM pass list
        ↓
工具执行：Binaryen / LLVM / 自定义 transform
        ↓
验证：wasm-validate + 差分测试 + benchmark + round-trip
        ↓
接受或回退：只保留语义正确且性能收益稳定的版本
```

第一版最好从 **LLM 选择 `wasm-opt` pass list** 做起，因为它最容易落地，也仍然符合“优先改 wasm 字节码”的方向。baseline 可以设为：

- 原始 wasm
- `wasm-opt -O2/-O3/-Oz`
- 随机 pass search
- 固定 pass sequence
- LLM agent with static features
- LLM agent with static features + perf feedback

评价指标：

- runtime speedup
- wasm/native time ratio 是否降低
- `instructions_retired`、`cpu_cycles`、`L1-icache-load-misses`、`branches_retired` 是否下降
- binary size
- validation pass rate
- regression rate
- agent 成功率
- ablation：无静态特征、无 perf 反馈、无多轮反馈、无 few-shot 示例

## 可写成的研究问题

你可以这样组织 RQ：

- **RQ1**：静态结构特征能否指导 wasm 优化机会识别？
- **RQ2**：LLM agent 是否能在 `wasm-opt -O3` 等强 baseline 之上获得额外 runtime 收益？
- **RQ3**：优化后的 wasm 是否真正降低了指令、周期、I-cache、分支等 slowdown 相关事件？
- **RQ4**：反馈闭环、静态特征、perf 信息分别贡献多少？
- **RQ5**：该方法在 wasmtime 和 wasmer 上是否都有效？

## 一句话定位

你的研究不要讲成“用 LLM 改代码”，而要讲成：

> 基于前期发现的 wasm slowdown 结构规律，构建一个静态特征与运行反馈驱动的 LLM 优化智能体，在 wasm/IR 层生成受约束的优化候选，并通过工具链验证实现类似编译器后端优化的自动化性能收益。

这条线比继续扩 runtime 更有论文价值，也更贴合老师说的“智能体框架 + 后端优化 + 语义验证”。