#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef N
#define N 512
#endif
#ifndef BUF_SIZE
#define BUF_SIZE (1 << 20)
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t acc = 0;
    for (int i = 0; i < N; ++i) {
        unsigned char *buf = (unsigned char *)malloc(BUF_SIZE);
        if (!buf) return 1;
        memset(buf, i & 255, BUF_SIZE);
        for (int j = 0; j < BUF_SIZE; j += 64) acc += buf[j];
        free(buf);
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
