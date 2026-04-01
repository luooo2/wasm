#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

#ifndef N
#define N 800
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct timespec __ts_start, __ts_end;
    unsigned long long __time_ns = 0;
    clock_gettime(CLOCK_MONOTONIC, &__ts_start);
    const char *path = "bench_tmp_openclose.dat";
    int init_fd = open(path, O_CREAT | O_WRONLY | O_TRUNC, 0644);
    if (init_fd < 0) return 1;
    (void)write(init_fd, "x", 1);
    close(init_fd);

    uint64_t count = 0;
    for (int i = 0; i < N; ++i) {
        int fd = open(path, O_RDONLY);
        if (fd < 0) return 1;
        count += (uint64_t)(fd & 255);
        close(fd);
    }

    sink_u64 = count;
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
