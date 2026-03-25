# V1 结果分析

- [x] Phase1 补强测量可靠性

**数据分析结果**：

1. 大多数样本是 native-better
2. 纯计算类更接近 similar
3. `memory_stride_write` 也接近 similar
4. `host_getcwd_loop` 出现了 `wasm-better`

> 说明计算密集型任务 wasm的优化做的比较好可以接近 native
> 同时，在某些规则化访存模式下，wasm也能接近native
> 甚至，在host_getcwd_loop中wasm能超越wasm（原因可能是wasm会缓存第一次getcwd的结果进行优化）
> 而大多数情况下wasm性能都劣于native，可能来自一些结构性消耗（结构敏感特征）
>
> - wasi系统调用固定消耗
> - 频繁内存分配（wasm内存管理优化不足）
> - 函数调用（wasm函数调用要先查询函数表等消耗）
> - 分支结构（边界检查消耗）

