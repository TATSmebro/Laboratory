#include <stdio.h>
#include <stdlib.h>

int isprime(int x){
    // 1 = True; 0 = False
    for(int i = 2; i < x; i++){
        if((x % i) == 0){
            return 0;
        }
    }
    return 1;
}

int main(){
    //input
    int a, b;
    scanf("%d", &a);
    scanf("%d", &b);
    int isthereprime = 0;

    for(int i = a; i <= b; i++){
        if(isprime(i) == 1){
            printf("%d ", i);
            isthereprime = 1;
        }
    }

    if(isthereprime == 0){
        printf("None");
    }

    return 0;
}