perf 指标集（V2）：

all-loads-retired
all-stores-retired
branches-retired
conditional-branches
instructions-retired
cpu-cycles
L1-icache-load-misses
branch-misses

采集命令：
perf stat \
  -e r81d0 \      # all-loads-retired
  -e r82d0 \      # all-stores-retired
  -e r00c4 \      # branches-retired
  -e r01c4 \      # conditional-branches
  -e r1c0 \       # instructions-retired
  -e cpu-cycles \
  -e L1-icache-load-misses \
  ./your_program