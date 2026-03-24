#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 60000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t sum = 0;
    for (uint64_t i = 0; i < N; ++i) {
        if ((i & 1u) == 0) sum += i;
        else sum += 3u;
    }
    sink_u64 = sum;
    printf("%llu\n", (unsigned long long)sum);
    return 0;
}
