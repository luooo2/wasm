#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <unistd.h>

#ifndef N
#define N 500
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
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
    printf("%llu\n", (unsigned long long)count);
    return 0;
}
