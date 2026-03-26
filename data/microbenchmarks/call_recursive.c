#include <stdint.h>
#include <stdio.h>

#ifndef DEPTH
#define DEPTH 26
#endif
#ifndef N
#define N 300000
#endif

static uint64_t recur(uint64_t x, int d) {
    if (d <= 0) return x + 1u;
    return recur((x ^ (uint64_t)d) + (x << 1), d - 1) + (uint64_t)d;
}

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t acc = 0;
    for (int i = 0; i < N; ++i) {
        acc += recur((uint64_t)i, DEPTH);
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
