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
    char *buf = (char *)malloc(16);
    if (!buf) return 1;
    size_t cap = 16;
    uint64_t acc = 0;

    for (int i = 0; i < N; ++i) {
        if ((i & 7) == 0) {
            cap = cap < 4096 ? cap * 2 : 16;
            char *nb = (char *)realloc(buf, cap);
            if (!nb) return 1;
            buf = nb;
        }
        buf[i % (int)cap] = (char)(i & 0x7F);
        acc += (uint8_t)buf[i % (int)cap];
    }

    free(buf);
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
