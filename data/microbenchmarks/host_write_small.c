#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

#ifndef N
#define N 500
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    const char *path = "bench_tmp_write.dat";
    uint64_t total = 0;

    char buf[64];
    for (int i = 0; i < 64; ++i) buf[i] = (char)(i * 3 + 1);

    for (int i = 0; i < N; ++i) {
        int fd = open(path, O_CREAT | O_WRONLY | O_TRUNC, 0644);
        if (fd < 0) return 1;
        ssize_t n = write(fd, buf, sizeof(buf));
        if (n < 0) return 1;
        total += (uint64_t)n;
        close(fd);
    }

    sink_u64 = total;
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
