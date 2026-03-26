#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 45000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t acc = 3;
    for (uint64_t i = 1; i <= N; ++i) {
        acc = acc * 1664525u + (i * 1013904223u);
        acc ^= (acc >> 11);
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
