#include <stdint.h>
#include <stdio.h>

#ifndef N
#define N 25000000
#endif

typedef uint64_t (*op_t)(uint64_t);

uint64_t op_add(uint64_t x) { return x + 3u; }
uint64_t op_mul(uint64_t x) { return x * 5u; }
uint64_t op_mix(uint64_t x) { return (x ^ (x << 7)) + 11u; }

volatile uint64_t sink_u64 = 0;

int main(void) {
    op_t ops[3] = {op_add, op_mul, op_mix};
    uint64_t acc = 1;
    for (uint64_t i = 0; i < N; ++i) {
        acc = ops[i % 3](acc + i);
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
