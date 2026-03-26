#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 35000000
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    uint64_t sum = 0;
    for (uint64_t i = 0; i < N; ++i) {
        if ((i & 1u) == 0) {
            if ((i & 3u) == 0) {
                sum += i;
            } else {
                sum += i >> 1;
            }
        } else {
            if ((i & 7u) == 1u) {
                sum -= i;
            } else {
                sum += (i ^ 0x9e37u);
            }
        }
    }
    sink_u64 = sum;
    printf("%llu\n", (unsigned long long)sum);
    return 0;
}
