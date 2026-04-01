#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

#ifndef N
#define N 512
#endif
#ifndef BUF_SIZE
#define BUF_SIZE (1 << 20)
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    uint64_t acc = 0;
    for (int i = 0; i < N; ++i) {
        unsigned char *buf = (unsigned char *)malloc(BUF_SIZE);
        if (!buf) return 1;
        memset(buf, i & 255, BUF_SIZE);
        for (int j = 0; j < BUF_SIZE; j += 64) acc += buf[j];
        free(buf);
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
