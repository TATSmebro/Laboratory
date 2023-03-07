#include <stdio.h>
#include <stdlib.h>

int Z(int n){
    if(n == 0){
        return 1;
    }
    else{
        return Z(n-1) * 2;
    }
}

int myPow(int base, int exp){
    int result = 1;
    for(int i = 0; i < exp; i++){
        result *= base;
    }

    return result;
}

int main(){
    int val = Z(6);
    int check = myPow(2, 6);
    printf("Z value is %d\n", val);
    printf("myPow value is %d", check);
    return 0;
}