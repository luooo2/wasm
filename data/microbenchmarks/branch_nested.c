#include <stdint.h>
#include <stdio.h>
#include <time.h>

#ifndef N
#define N 35000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    uint64_t sum = 0;
    for (uint64_t i = 0; i < N; ++i) {
        if ((i & 1u) == 0) {
            if ((i & 3u) == 0) {
                sum += i;
            } else {
                sum += i >> 1;
            }
        } else {
            if ((i & 7u) == 1u) {
                sum -= i;
            } else {
                sum += (i ^ 0x9e37u);
            }
        }
    }
    sink_u64 = sum;
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
