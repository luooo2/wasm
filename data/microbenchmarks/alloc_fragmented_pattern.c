#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#ifndef N
#define N 100000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    const int slots = 64;
    uint32_t *arr[64] = {0};
    uint64_t acc = 0;

    for (int i = 0; i < N; ++i) {
        int s = i % slots;
        if (arr[s]) {
            acc += arr[s][0];
            free(arr[s]);
            arr[s] = NULL;
        } else {
            int sz = (i % 128) + 8;
            arr[s] = (uint32_t *)malloc(sizeof(uint32_t) * sz);
            if (!arr[s]) return 1;
            arr[s][0] = (uint32_t)(i ^ sz);
        }
    }

    for (int s = 0; s < slots; ++s) {
        if (arr[s]) {
            acc += arr[s][0];
            free(arr[s]);
        }
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
