#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

unsigned long f(unsigned long val) {
    return val + (val >> 64 );
}

int main(int num) {

    printf("calculado = %d\n", f(50));
}