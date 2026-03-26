#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 45000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t x = 2463534242u;
    uint64_t sum = 0;
    for (uint64_t i = 0; i < N; ++i) {
        x ^= x << 13;
        x ^= x >> 17;
        x ^= x << 5;

        switch ((int)(x % 97u)) {
            case 0: sum += i; break;
            case 17: sum += (i << 1); break;
            case 53: sum ^= (i + x); break;
            case 89: sum -= (i & 255u); break;
            default: sum += (x & 15u); break;
        }
    }
    sink_u64 = sum;
    printf("%llu\n", (unsigned long long)sum);
    return 0;
}
