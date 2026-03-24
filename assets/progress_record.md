学习路线记录
1. wasm 了解 & emscripten 使用 & wasmtime 使用 环境搭建
2. 各类程序 编译选项 定量结果统计
3. 静态分析 & IR 学习 （寻找相关的静态特征）
4. 模型选择/设计

数据：
&& 常用的 wasm 应用场景的 workload 有哪些？ 
之前论文好像读到过wasm设计之初是有设计目标的常用使用场景的


papers
Wasm 性能研究
WebAssembly for Container Runtime: Are We There Yet? [2025]
Not So Fast: Analyzing the Performance of WebAssembly vs. Native Code [2019]
Benchmarking Native Code Against WebAssembly In WebAssembly System Interface Compliant Environments [2024] [学士论文]
A comparative analysis of Wasm performance for different programming paradigms [25]
Understanding the Performance of WebAssembly Applications [21]
Leaps and bounds: Analyzing WebAssembly’s performance with a focus on bounds checking - 飞书云文档 [22]
23 A Systematic Review of WebAssembly VS Javascript Performance Comparison.pdf - 飞书云文档[23]


静态分析 + ML 方法类论文：
A Static Analysis-based Cross-Architecture Performance Prediction Using Machine Learning [2019]
很有参考价值的一篇论文（方法论部分），可惜没有开源代码
Mira：A Framework for Static Performance Analysis [2017]
有点没太看明白 12/27




论文复现

复现 Benchmarking Native Code Against WebAssembly In WebAssembly System Interface Compliant Environments 论文实验代码，结果：

本地环境 WSL
- 选用语言：C，编译器： clang（18.1.3）    wasi-sdk（29.0） ，编译选项（优化选项）： o2，WASM 代码运行环境：Wasmtime（38.0.4）

各类操作程序结果
- fib（计算） :  wasmtime 运行与 native 接近， 原实验会慢 75%， 是因为优化级别改变吗？ -o0  -->   -o2 ;  在 wasmtime 使用 wasm 跑高计算型任务与 native 接近（小型计算量）    在 -o0优化级别下与原实验一致，所以 -o2优化下，wasmtime 优化计算型任务表现较好，能取得与 native 相近的性能
- get_wd（获取当前工作目录---系统调用） :  wasmtime 运行时显著优于 native，与原实验结果一致； 可能的解释：wasm运行时通过缓存第一次 get_wd 系统调用的结果来优化性能。
- loop（空循环）:  性能基准，wasmtime 运行时显著慢于 native（53.47倍），原实验仅慢 42%， 是因为优化级别改变吗？ native 代码会把空循环直接优化掉吗 ？     在 -o0优化下，wasmtme 为 native 5.64倍，所以应该是native把空循环优化了
- dynamic_memory（动态内存分配）：wasmtime 运行优于 native （50% 左右），与原实验结果一致； 可能的解释：wasm 运行时可能在固定段中预分配动态内存。
- std_output（标准输出 IO类）：wasmtime 约为 native 2 倍，与原实验一致；可能的解释：与操作系统交互受限于 wasi ？
- time（获取当前时间 系统调用）：wasmtime 约为 native 100倍，原实验仅 18 倍； 是因为系统操作会更慢吗？ 在 -o0优化级别下也是100多倍，所以不是优化级别的问题； 可能的解释： wsl / 操作系统 变更导致？



后续：
更多类型程序（覆盖全面类型的程序）
抽象规则+程序验证
静态分析（llvm IR指令）学习了解
抽象出具体静态特征，训练模型进行判别？


实验意义：
在不同环境架构下，不同程序的 native 和 wasm 表现都不一样。那我研究这个“什么样的程序适合用wasm”也只是针对我的环境下的，而且我肯定无法覆盖所有程序，适用性不足；同时我只是针对程序运行时间而言，真正实际应用场景肯定还要考虑内存等其它因素，实用性也不足；此外，目前wasm还在快速发展，随着wasm编译器/运行时的发展进步，说不定研究结果就更与现实不符了。 那么该研究意义是什么呢？
环境依赖性强（平台 / 架构 / runtime）
程序覆盖不全（无法穷举 workload）
评价维度单一（只看时间，不看内存 / 安全 / 部署）
技术快速演进（wasm 在变，结论可能过期）
在给定约束下，什么样的程序更可能从 WASM 中受益 / 受损？
本研究并非试图给出 WASM 与 native 性能的绝对优劣结论，而是通过静态程序特征与实际性能测量的结合，探索不同程序结构在 WASM 执行环境下的性能趋势与影响因素。
尽管实验结果依赖于具体平台与运行时实现，但所提出的分析框架为理解 WASM 性能行为、指导 workload 选择与 runtime 优化提供了一种可复用的方法论。



静态特征 & llvm IR学习
version1
（……）
静态特征设计：
syscall density = #system_calls / #function_calls 系统调用密度
MemAccessRatio = (load + store) / total_instr 内存访问密度
ALURatio = arithmetic_instr / total_instr 计算密度
branch density 分支密度
FunctionCallDensity 函数调用密度



老师，我最近遇到一点问题想问问你的看法~  
我目前的进展是： 有看到一篇相关论文并复现了代码，得到初步结论（纯计算任务有稳定的小幅损耗；内存管理类任务可能因运行时优化反超原生；但涉及系统 I/O 和调用时，不同语言、不同运行时的表现天差地别）。       
后续的话，本来我是打算根据实验结果，将程序 先编译成 IR ，然后从 IR 抽象出一些静态特征（比如系统调用密度、内存访问密度）等特征，然后根据这些特征来看看能不能训一个模型来自动化判断是 prefer-wasm 还是 prefer-native。  但是我有点问题在于： 
1. 我不确定这个可行性/合理性。就是目前我是选用 c 语言源程序， 用 clang -> native,在本地运行, 用 wasi-sdk-clang -> wasm,在 wasmtime运行。 静态特征我是打算将 c 先编译为 llvm IR，再解析 IR，用指令数统计得到 系统调用密度 等静态特征。 我不太确定这样得到的静态特征最后是不是能用于判断是否适合wasm。我这样做是合理的吗？真的能在不运行的情况下仅靠静态特征就判断出用wasm/native更快吗？   
趋势判断 而非 数值预测 
2. 如果要训模型的话，必然需要很多数据，可是比如 PolybenchC 这种基准套件，它总共也就几十个程序，数据会不会不够。    
3. 研究意义。 我的研究环境依赖性强（特定架构 / runtime）；程序覆盖不全（无法穷举 workload）；评价维度单一（只看运行时间）；技术快速演进（wasm 在变，结论可能过期），适用性感觉很差，那么研究意义是什么呢？


answer11
- 研究意义：找到wasm劣于native的原因，从而对wasm做进一步的优化，以期达到或超越native的性能
- 先从各种 wasm 论文（性能分析，设计机理，应用场景等） 寻找与wasm 运行性能相关的因素， 设计全面的各类程序验证寻找性能差异， 设计相关的静态特征， 建模性能趋势预测模型 。
- 思路不清晰的时候可以看更多的论文
- 本研究探索：是否可以仅通过程序的静态特征，在无需运行程序的情况下，预测其在 WebAssembly 与 native 执行环境中的性能相对优势，从而为 WebAssembly 的性能优化、程序部署决策和编译器改进提供依据。




特征设计

3/7
从文献中寻找一些可能影响的特征因素：
1. wasm容器在IPC（每周期指令数）较低的计算任务中具有优势 
1. 低 IPC 通常意味着原生执行效率低下，例如存在内存停顿或使用复杂的混合指令，而 Wasm 由于其紧凑的内存和简单的指令可能表现得更好
2. 寄存器使用、分支指令数量、代码体积/缓存缺失 等参数
1. 寄存器使用 -> web场景中 
2. 分支指令数量 -> 边界检查 
3. 代码体积 
3. 边界检查密度
4. 系统调用密度
5. 计算密度
6. I/O密度
7. 内存访问

特征：
系统调用密度 （I/O、文件操作等）
计算密度
内存访问 （边界检查）

GPT老师推荐加上：
分支密度（控制流复杂度）
函数调用密度 



特征提取：
python快速原型（手写）？ 各种指令类别关键词我感觉手写有点麻烦啊
Llvm clang opt工具 ？ 各种版本改动以及英文文档我看得有点头大
静态分析工具汇总 https://github.com/analysis-tools-dev/static-analysis?tab=readme-ov-file#c

不做预测做分类（运行时间）：
wasm更快、native更快、两者相近

模型选择： 随机森林
随机森林并不要求使用独立无关变量

数据集：
按类别搜罗各种源码？
公开数据集？

标签获取：
wasm-score 基准项目 好像这个项目是一个“Wasm 跑分工具”，可以给出代码 wasm 相对 native 的性能得分？不知道能不能直接拿来用
或者我自己写个脚本把所有数据的label  wasm_faster = 0/1 先跑出来

  

---
计算密度：
简单定义：  \frac{所有算数/逻辑指令数}{所有指令数}
若考虑循环、分支结构等，则：

可是估计的执行次数权重这个不太好获取吧（可能与输入有关）

---
系统调用密度
Q1：哪些操作属于系统调用？
系统调用白名单：

Q2：从哪层识别系统调用？
源码？ AST层？ IR层？

定义同上，两种定义选择

---
内存访问密度


---
分支密度
这个咋定义？

---
函数调用密度


---



对于 输入动态性对预测影响 的解决方法，论文 A Static Analysis-based Cross-Architecture Performance Prediction Using Machine Learning（https://arxiv.org/pdf/1906.07840） 附录A中的解决方法可供参考？



And 为了实验结果是由 wasm 和 native 本身导致的，编译时是不是应该使用 -o0优化？ 排除编译器优化影响
但是到wasm runtime这种后续的执行还会产生进一步的干扰吗？



3/12
answer22:
结果导向
先使用最简单的定义，进行快速原型验证
特征： 每周期指令数 IPC、系统调用密度、计算密度、内存访问
标签： native、各个wasm运行时（先选用一个进行尝试）
lmz你自己考虑一下要扩展到多个运行时吗？ 因为如果要扩展到多个运行时的话，就不止要考虑影响 wasm 和 native 性能差异的因素了，还得考虑不同运行时的设计差异导致的不同运行时性能差异……你得定一个内容，你具体是要解决什么问题！
先选一个来先做
数据集：PolybenchC
模型：随机森林
参考论文：WRCF: ML-Guided Multi-Runtime Orchestrator for WebAssembly Services
