#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef N
#define N 2000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t acc = 0;
    for (int i = 0; i < N; ++i) {
        uint32_t *p = (uint32_t *)malloc(sizeof(uint32_t) * 8);
        if (!p) return 1;
        for (int j = 0; j < 8; ++j) p[j] = (uint32_t)(i + j);
        for (int j = 0; j < 8; ++j) acc += p[j];
        free(p);
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
