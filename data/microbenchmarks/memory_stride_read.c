#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef N
#define N 5000000
#endif
#ifndef STRIDE
#define STRIDE 16
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint32_t *arr = (uint32_t *)malloc(sizeof(uint32_t) * N);
    if (!arr) return 1;

    for (int i = 0; i < N; ++i) arr[i] = (uint32_t)(i * 3u + 7u);

    uint64_t sum = 0;
    for (int round = 0; round < 32; ++round) {
        for (int i = 0; i < N; i += STRIDE) {
            sum += arr[i] ^ (uint32_t)round;
        }
    }

    sink_u64 = sum;
    printf("%llu\n", (unsigned long long)sum);
    free(arr);
    return 0;
}
