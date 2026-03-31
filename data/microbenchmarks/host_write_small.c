#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <unistd.h>

#ifndef N
#define N 500
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
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
    printf("%llu\n", (unsigned long long)total);
    return 0;
}
