#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifndef N
#define N 600000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    const int slots = 64;
    uint32_t *arr[64] = {0};
    uint64_t acc = 0;

    for (int i = 0; i < N; ++i) {
        int s = i % slots;
        if (arr[s]) {
            acc += arr[s][0];
            free(arr[s]);
            arr[s] = NULL;
        } else {
            int sz = (i % 128) + 8;
            arr[s] = (uint32_t *)malloc(sizeof(uint32_t) * sz);
            if (!arr[s]) return 1;
            arr[s][0] = (uint32_t)(i ^ sz);
        }
    }

    for (int s = 0; s < slots; ++s) {
        if (arr[s]) {
            acc += arr[s][0];
            free(arr[s]);
        }
    }

    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
