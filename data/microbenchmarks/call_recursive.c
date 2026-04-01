#include <stdint.h>
#include <stdio.h>
#include <time.h>

#ifndef DEPTH
#define DEPTH 26
#endif
#ifndef N
#define N 3000000
#endif

static uint64_t recur(uint64_t x, int d) {
    if (d <= 0) return x + 1u;
    return recur((x ^ (uint64_t)d) + (x << 1), d - 1) + (uint64_t)d;
}

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    uint64_t acc = 0;
    for (int i = 0; i < N; ++i) {
        acc += recur((uint64_t)i, DEPTH);
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
