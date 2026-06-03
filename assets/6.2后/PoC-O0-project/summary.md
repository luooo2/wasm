## 6.3 思路整理
研究重点：wasm 性能优化
如何使用从 wasm vs native 性能差异研究中发现的规律（程序静态结构对性能差距的影响），利用 LLM 改写 wasm 字节码/给出 opt pass 序列来提升 wasm 运行性能。
现在看起来 idea 不 work 的原因： 
- 本身的 baseline AOT 运行效果已经较好，在此基础上使用 wasm-opt -o3效果也并不好，idea 使用 llm 的效果也不好
- 当前 PoC 使用的 prompt 有待优化，可以从 few-shot设计、prompt 优化、反馈迭代框架设计等角度进行优化
- 要想想怎么把之前发现的规律融入 prompt 中，让 llm 根据这个规律来改写代码/设计优化 pass
- 进一步调研现有 wasm 性能研究，wasm 性能优化研究，wasm 编译优化研究等方向的研究，它们是如何设置 baseline 的？一般是以什么为基准？ 到达怎么的程度可以说 idea work？