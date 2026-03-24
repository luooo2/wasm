#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 40000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint32_t x = 2463534242u;
    uint64_t sum = 0;
    for (uint64_t i = 0; i < N; ++i) {
        x ^= x << 13;
        x ^= x >> 17;
        x ^= x << 5;
        if (x & 1u) sum += (x & 255u);
        else sum -= (x & 127u);
    }
    sink_u64 = sum;
    printf("%llu\n", (unsigned long long)sum);
    return 0;
}
