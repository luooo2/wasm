#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef POOL
#define POOL 262144
#endif
#ifndef N
#define N 8000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint32_t *pool = (uint32_t *)malloc(sizeof(uint32_t) * POOL);
    if (!pool) return 1;

    for (int i = 0; i < POOL; ++i) pool[i] = (uint32_t)i;

    uint64_t acc = 0;
    for (int i = 0; i < N; ++i) {
        int idx = i % POOL;
        pool[idx] = pool[idx] + (uint32_t)(i & 31);
        acc += pool[idx];
    }

    free(pool);
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
