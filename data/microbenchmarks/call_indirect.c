#include <stdint.h>
#include <stdio.h>
#include <time.h>

#ifndef N
#define N 25000000
#endif

typedef uint64_t (*op_t)(uint64_t);

uint64_t op_add(uint64_t x) { return x + 3u; }
uint64_t op_mul(uint64_t x) { return x * 5u; }
uint64_t op_mix(uint64_t x) { return (x ^ (x << 7)) + 11u; }

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    op_t ops[3] = {op_add, op_mul, op_mix};
    uint64_t acc = 1;
    for (uint64_t i = 0; i < N; ++i) {
        acc = ops[i % 3](acc + i);
    }
    sink_u64 = acc;
        clock_gettime(CLOCK_MONOTONIC, &__ts_end);
    __time_ns = (unsigned long long)(__ts_end.tv_sec - __ts_start.tv_sec) * 1000000000ull;
    if (__ts_end.tv_nsec >= __ts_start.tv_nsec) {
        __time_ns += (unsigned long long)(__ts_end.tv_nsec - __ts_start.tv_nsec);
    } else {
        __time_ns -= 1000000000ull;
        __time_ns += (unsigned long long)(__ts_end.tv_nsec + 1000000000L - __ts_start.tv_nsec);
    }
    printf("TIME_NS:%llu\n", __time_ns);
    return 0;
}
