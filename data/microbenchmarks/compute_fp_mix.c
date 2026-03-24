#include <math.h>
#include <stdio.h>

#ifndef N
#define N 12000000
#endif

volatile double sink_f64 = 0.0;

int main(void) {
    double x = 0.6180339887;
    double y = 1.4142135623;
    for (int i = 0; i < N; ++i) {
        x = x * 1.0000001 + y * 0.9999993;
        y = y * 1.0000003 - x * 0.0000007;
        x += (double)(i & 7) * 0.125;
    }
    sink_f64 = x + y;
    printf("%.8f\n", sink_f64);
    return 0;
}
