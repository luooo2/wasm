#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

#ifndef N
#define N 8
#endif
#ifndef BUF_MB
#define BUF_MB 8
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    size_t bytes = (size_t)BUF_MB * 1024u * 1024u;
    uint8_t *src = (uint8_t *)malloc(bytes);
    uint8_t *dst = (uint8_t *)malloc(bytes);
    if (!src || !dst) return 1;

    for (size_t i = 0; i < bytes; ++i) src[i] = (uint8_t)(i & 255u);

    for (int r = 0; r < N; ++r) {
        memcpy(dst, src, bytes);
        uint8_t *tmp = src;
        src = dst;
        dst = tmp;
    }

    uint64_t sum = 0;
    for (size_t i = 0; i < bytes; i += 4096u) sum += src[i];
    sink_u64 = sum;
    free(src);
    free(dst);
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
