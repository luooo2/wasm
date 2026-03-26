#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <unistd.h>

#ifndef N
#define N 80000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
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
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
