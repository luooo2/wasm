#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 20000000
#endif

static inline uint64_t f0(uint64_t x) { return x + 1u; }
static inline uint64_t f1(uint64_t x) { return x * 3u + 7u; }
static inline uint64_t f2(uint64_t x) { return (x ^ (x << 3)) + 11u; }
static inline uint64_t f3(uint64_t x) { return x + (x >> 5); }
static inline uint64_t f4(uint64_t x) { return x * 5u + 13u; }

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t acc = 1;
    for (uint64_t i = 0; i < N; ++i) {
        acc = f0(acc);
        acc = f1(acc + i);
        acc = f2(acc + 3u);
        acc = f3(acc ^ i);
        acc = f4(acc + 1u);
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
