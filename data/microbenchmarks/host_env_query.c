#include <stdio.h>
#include <stdlib.h>

#ifndef N
#define N 600000
#endif

volatile int sink_i32 = 0;

int main(void) {
    int total = 0;
    for (int i = 0; i < N; ++i) {
        const char *v = getenv("PATH");
        if (v && v[0]) total += (int)v[0];
    }
    sink_i32 = total;
    printf("%d\n", total);
    return 0;
}
