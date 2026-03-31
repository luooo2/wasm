#include <stdint.h>
#include <stdio.h>
#include <sys/stat.h>

#ifndef N
#define N 500
#endif

volatile uint64_t sink_u64 = 0;

int main(void) {
    struct stat st;
    uint64_t acc = 0;
    for (int i = 0; i < N; ++i) {
        if (stat(".", &st) != 0) return 1;
        acc += (uint64_t)(st.st_mode & 0xFFFFu);
    }
    sink_u64 = acc;
    printf("%llu\n", (unsigned long long)acc);
    return 0;
}
