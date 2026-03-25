## 参数化微基准清单

### B1. Compute-heavy


| ID  | 文件名                 | 主要目标特征            | 说明       |
| --- | ------------------- | ----------------- | -------- |
| M01 | `compute_int_add.c` | `compute_density` | 整数算术密集循环 |
| M02 | `compute_fp_mix.c`  | `compute_density` | 浮点算术混合循环 |


### B2. Memory-heavy


| ID  | 文件名                     | 主要目标特征                  | 说明    |
| --- | ----------------------- | ----------------------- | ----- |
| M03 | `memory_seq_read.c`     | `memory_access_density` | 顺序扫描读 |
| M04 | `memory_stride_write.c` | `memory_access_density` | 跨步写入  |


### B3. Branch-heavy


| ID  | 文件名                      | 主要目标特征           | 说明     |
| --- | ------------------------ | ---------------- | ------ |
| M05 | `branch_predictable.c`   | `branch_density` | 高可预测分支 |
| M06 | `branch_unpredictable.c` | `branch_density` | 伪随机分支  |


### B4. Call-heavy


| ID  | 文件名               | 主要目标特征                                | 说明      |
| --- | ----------------- | ------------------------------------- | ------- |
| M07 | `call_chain.c`    | `call_density`                        | 深层直接调用链 |
| M08 | `call_indirect.c` | `call_density`, `indirect_call_count` | 函数指针调用  |


### B5. Host-interaction-heavy


| ID  | 文件名                  | 主要目标特征                                      | 说明     |
| --- | -------------------- | ------------------------------------------- | ------ |
| M09 | `host_time_loop.c`   | `time_call_count`, `hostcall_density`       | 高频时间查询 |
| M10 | `host_getcwd_loop.c` | `filesystem_call_count`, `hostcall_density` | 高频路径查询 |


### B6. Allocation-heavy


| ID  | 文件名                     | 主要目标特征                                      | 说明         |
| --- | ----------------------- | ------------------------------------------- | ---------- |
| M11 | `alloc_small_objects.c` | `alloc_call_count`                          | 高频小对象分配释放  |
| M12 | `alloc_bulk_buffer.c`   | `alloc_call_count`, `memory_access_density` | 大块缓冲区分配与访问 |


