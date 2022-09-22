#include <stdio.h>
#include <stdlib.h>

int getGCD(int a, int b){
    if(a < b){
    return getGCD(b, a);
    }
    if(a == 0){
        return b;
    }
    if(b == 0){
        return a;
    }
    return getGCD(b, a % b);
}

int main(){
    //input
    int numerator;
    int denominator;
    scanf("%d", &numerator);
    scanf("%d", &denominator);

    //get gcd
    int gcd = getGCD(numerator, denominator);

    //output
    printf("%d\n", numerator / gcd);
    printf("%d\n", denominator / gcd);
    return 0;
}
