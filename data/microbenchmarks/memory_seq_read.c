#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef N
#define N 4000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint32_t *arr = (uint32_t *)malloc(sizeof(uint32_t) * N);
    if (!arr) return 1;
    for (int i = 0; i < N; ++i) arr[i] = (uint32_t)(i * 17u + 3u);

    uint64_t sum = 0;
    for (int i = 0; i < N; ++i) sum += arr[i];

    sink_u64 = sum;
    printf("%llu\n", (unsigned long long)sum);
    free(arr);
    return 0;
}
