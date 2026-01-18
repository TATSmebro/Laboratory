#include "kernel/types.h"
#include "user/user.h"

int main(){
    int x;
    asm volatile("li t6, 48");

    while(1){
        asm volatile("mv %0, t6" : "=r"(x));
        printf("%c", x);
    }

    exit(0);
}