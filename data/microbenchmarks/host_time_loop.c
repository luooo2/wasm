#include <stdio.h>
#include <time.h>

#ifndef N
#define N 2000000
#endif

volatile long long sink_i64 = 0;

int main(void) {
    struct timespec ts;
    long long acc = 0;
    for (int i = 0; i < N; ++i) {
        clock_gettime(CLOCK_REALTIME, &ts);
        acc += ts.tv_nsec & 1023;
    }
    sink_i64 = acc;
    printf("%lld\n", acc);
    return 0;
}
