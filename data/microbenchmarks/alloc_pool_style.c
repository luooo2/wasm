#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#ifndef POOL
#define POOL 262144
#endif
#ifndef N
#define N 250000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    uint32_t *pool = (uint32_t *)malloc(sizeof(uint32_t) * POOL);
    if (!pool) return 1;

    for (int i = 0; i < POOL; ++i) pool[i] = (uint32_t)i;

    uint64_t acc = 0;
    for (int i = 0; i < N; ++i) {
        int idx = i % POOL;
        pool[idx] = pool[idx] + (uint32_t)(i & 31);
        acc += pool[idx];
    }

    free(pool);
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
