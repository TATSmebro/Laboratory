#include <stdio.h>

#define S '*' //define S as '*'

int main() {
    int N, B;

    //Input N and B
    printf("Enter N: ");
    scanf("%d", &N);
    printf("Enter B: ");
    scanf("%d", &B);

    int mid = (B + 1) / 2; //Midpoint of the base

    //Print the first half of the triangle wave
    for(int i = 1; i <= mid; i++){
        for(int j = 1; j <= N; j++){
            for(int k = 1; k <= mid; k++){
                if(k == i && j == N){
                    printf("%c", S);
                    break;
                }else{
                    if(k <= i){
                        printf("%c ", S);
                    }else{
                        printf("  ");
                    }
                }
            }
        }
        printf("\n");
    }
    

    //Print the second half of the triangle wave
    for(int i = mid - 1; i >= 1; i--){    
        for(int j = 1; j <= N; j++){
            for(int k = 1; k <= mid; k++){
                if(k == i && j == N){
                    printf("%c", S);
                    break;
                }else{
                    if(k <= i){
                        printf("%c ", S);
                    }else{
                        printf("  ");
                    }
                }
            }
        }
        printf("\n");
    }

    return 0;
}
