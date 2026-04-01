#include <limits.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

#ifndef N
#define N 2000
#endif

volatile int sink_i32 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    char buf[PATH_MAX];
    int total = 0;
    for (int i = 0; i < N; ++i) {
        if (getcwd(buf, sizeof(buf)) == NULL) return 1;
        total += (int)buf[0];
    }
    sink_i32 = total;
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
