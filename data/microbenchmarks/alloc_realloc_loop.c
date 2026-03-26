#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef N
#define N 1000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    char *buf = (char *)malloc(16);
    if (!buf) return 1;
    size_t cap = 16;
    uint64_t acc = 0;

    for (int i = 0; i < N; ++i) {
        if ((i & 7) == 0) {
            cap = cap < 4096 ? cap * 2 : 16;
            char *nb = (char *)realloc(buf, cap);
            if (!nb) return 1;
            buf = nb;
        }
        buf[i % (int)cap] = (char)(i & 0x7F);
        acc += (uint8_t)buf[i % (int)cap];
    }

    free(buf);
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
