#include <math.h>
#include <stdio.h>
#include <time.h>

#ifndef N
#define N 12000000
#endif

volatile double sink_f64 = 0.0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    double x = 0.6180339887;
    double y = 1.4142135623;
    for (int i = 0; i < N; ++i) {
        x = x * 1.0000001 + y * 0.9999993;
        y = y * 1.0000003 - x * 0.0000007;
        x += (double)(i & 7) * 0.125;
    }
    sink_f64 = x + y;
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
