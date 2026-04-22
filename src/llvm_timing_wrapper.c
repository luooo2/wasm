#include <stdint.h>
#include <stdio.h>
#include <time.h>

extern int llvm_bench_main(void);

static uint64_t nsec_now(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint64_t)ts.tv_sec * 1000000000ULL + (uint64_t)ts.tv_nsec;
}

int main(void) {
    uint64_t t0 = nsec_now();
    int rc = llvm_bench_main();
    uint64_t t1 = nsec_now();
    printf("TIME_NS:%llu\n", (unsigned long long)(t1 - t0));
    return rc;
}

