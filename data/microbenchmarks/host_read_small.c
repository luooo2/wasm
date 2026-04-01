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
    const char *path = "bench_tmp_read.dat";
    int fdw = open(path, O_CREAT | O_WRONLY | O_TRUNC, 0644);
    if (fdw < 0) return 1;
    char seed[64];
    for (int i = 0; i < 64; ++i) seed[i] = (char)(i + 1);
    if (write(fdw, seed, sizeof(seed)) < 0) return 1;
    close(fdw);

    uint64_t acc = 0;
    char buf[64];
    for (int i = 0; i < N; ++i) {
        int fdr = open(path, O_RDONLY);
        if (fdr < 0) return 1;
        ssize_t n = read(fdr, buf, sizeof(buf));
        if (n < 0) return 1;
        for (ssize_t k = 0; k < n; ++k) acc += (uint8_t)buf[k];
        close(fdr);
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
