#include <stdio.h>

int main() {
    int k;
    double x;
    scanf("%i %lf", &k, &x);

    double series = 1;
    double numerator = 1;
    double denominator = 1;

    for (int i = 1; i <= k; i++) {
        numerator *= x;
        denominator *= i;
        series += numerator / denominator;
    }

    printf("e^x = %f\n", series);
    return 0;
}