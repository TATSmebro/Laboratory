#include <stdio.h>
#include <stdlib.h>

void print_list(int* A, int p, int r){
    for(int i = p; i < r; i++){
        printf("%d ", A[i]);
    }
    printf("\n");
}

int partition(int* list, int p, int r){
    int x = list[r];
    int i = p - 1;
    
    for(int j = p; j < r; j++){
        if(list[j] <= x){
            i++;
            int temp = list[i];
            list[i] = list[j];
            list[j] = temp;
        }
    }
    
    int temp_i = list[i + 1];
    list[i + 1] = list[r];
    list[r] = temp_i;

    print_list(list, p, r + 1);

    return i + 1;
}

void quicksort(int* A, int p, int r){
    if(p < r){
        int q = partition(A, p, r);
        quicksort(A, p, q - 1);
        quicksort(A, q + 1, r);
    }
}

int* shuffle(int* idx_list, int M){
    int P = 524287;

    for(int i = 1; i < M + 1; i++){
        idx_list[i - 1] = (i * P) % M;
    }
    
    return idx_list;
}

int main(){
    int M = 1000;
    int test_cases;
    int shuffled_list[M];

    scanf("%d", &test_cases);

    int idx_list[M];
    shuffle(idx_list, M);

    for(int i = 0; i < test_cases; i++){        
        int A[M];

        for(int j = 0; j < M; j++){
            scanf("%d", &A[j]);
        }

        for(int i = 0; i < M; i++){
            shuffled_list[i] = A[idx_list[i]];
        }

        print_list(shuffled_list, 0, M);
        quicksort(shuffled_list, 0, M - 1);
        print_list(shuffled_list, 0, M);    
    }

    return 0;
}