#include <limits.h>
#include <stdio.h>
#include <unistd.h>

#ifndef N
#define N 300000
#endif

volatile int sink_i32 = 0;

int main(void) {
    char buf[PATH_MAX];
    int total = 0;
    for (int i = 0; i < N; ++i) {
        if (getcwd(buf, sizeof(buf)) == NULL) return 1;
        total += (int)buf[0];
    }
    sink_i32 = total;
    printf("%d\n", total);
    return 0;
}
