#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#ifndef N
#define N 3000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    uint32_t *arr = (uint32_t *)malloc(sizeof(uint32_t) * N);
    if (!arr) return 1;

    for (int i = 0; i < N; ++i) arr[i] = (uint32_t)(i ^ 0x5a5a5a5a);

    uint32_t x = 2463534242u;
    uint64_t sum = 0;
    for (int round = 0; round < 24; ++round) {
        for (int i = 0; i < N; ++i) {
            x ^= x << 13;
            x ^= x >> 17;
            x ^= x << 5;
            sum += arr[x % N];
        }
    }

    sink_u64 = sum;
    free(arr);
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
