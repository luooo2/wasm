#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 30000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t acc = 17;
    for (uint64_t i = 1; i <= N; ++i) {
        uint64_t q = acc / ((i & 255u) + 1u);
        uint64_t r = acc % ((i & 127u) + 1u);
        acc = q + r + i;
        acc ^= (acc << 9) ^ (acc >> 5);
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
