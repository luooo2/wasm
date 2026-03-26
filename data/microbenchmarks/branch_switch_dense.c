#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 45000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t acc = 0;
    for (uint64_t i = 0; i < N; ++i) {
        switch ((int)(i & 7u)) {
            case 0: acc += i + 1; break;
            case 1: acc += i + 3; break;
            case 2: acc += i + 5; break;
            case 3: acc += i + 7; break;
            case 4: acc += i + 11; break;
            case 5: acc += i + 13; break;
            case 6: acc += i + 17; break;
            default: acc += i + 19; break;
        }
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
