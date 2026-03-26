#include <stdio.h>

#ifndef N
#define N 14000000
#endif

volatile double sink_f64 = 0.0;

int main(void) {
    double x = 0.731;
    double y = 1.217;
    for (int i = 0; i < N; ++i) {
        x = x * 1.00000031 + y * 0.00000073;
        y = y * 0.99999971 + x * 0.00000119;
        x += (double)(i & 15) * 0.03125;
    }
    sink_f64 = x + y;
    printf("%.8f\n", sink_f64);
    return 0;
}
