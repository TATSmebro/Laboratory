#include <stdio.h>
#include <stdlib.h>

void randomizeInPlace(int arrLen, int* arr, int* indx){
    for(int i = 0; i < arrLen; i++){
        int temp = arr[indx[i]];
        arr[indx[i]] = arr[i];
        arr[i] = temp;
        for(int j = 0; j < arrLen; j++){
            printf("%d_", arr[j]);
        }
        printf("\n");
    }
}

int main(){
    int arrLen, arr[arrLen + 1], indx[arrLen + 1];
    
    scanf("%d", &arrLen);

    for(int i = 0; i < arrLen; i++){
        scanf("%d", &arr[i]);
    }

    for(int i = 0; i < arrLen; i++){
        scanf("%d", &indx[i]);
    }

    randomizeInPlace(arrLen, arr, indx);
}