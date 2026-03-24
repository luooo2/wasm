#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 50000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t acc = 1;
    for (uint64_t i = 1; i <= N; ++i) {
        acc += i * 3u;
        acc ^= (acc << 7) ^ (acc >> 3);
        acc += 11u;
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
