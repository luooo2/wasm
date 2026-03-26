#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef N
#define N 2500000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint32_t *arr = (uint32_t *)malloc(sizeof(uint32_t) * N);
    if (!arr) return 1;

    for (int i = 0; i < N; ++i) arr[i] = (uint32_t)i;

    uint32_t x = 123456789u;
    for (int round = 0; round < 20; ++round) {
        for (int i = 0; i < N; ++i) {
            x ^= x << 13;
            x ^= x >> 17;
            x ^= x << 5;
            int idx = (int)(x % (uint32_t)N);
            arr[idx] = arr[idx] + (uint32_t)(round + i);
        }
    }

    uint64_t sum = 0;
    for (int i = 0; i < N; i += 128) sum += arr[i];
    sink_u64 = sum;
    printf("%llu\n", (unsigned long long)sum);
    free(arr);
    return 0;
}
