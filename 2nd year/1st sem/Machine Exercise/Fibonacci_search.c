#include <stdio.h>
#include <stdlib.h>

int fiboSearch(int* T, int K, int n){
    
    //nearest Fibonacci number
    int t, q, p = 0, i = 1, third = p + i;

    while(third <= n){
        q = p;
        p = i;
        i = third;
        third = p + i;
    }

    int m = third - 1 - n;

    if(K > T[i - 1]){
        i -= m;
    }

    while(1){
        printf("Current key: %d\n", T[i - 1]);
        if(K == T[i - 1]){
            printf("key found at position: %d\n", i);
            return i;
        }
        if(K < T[i - 1]){
            if(q == 0){
                printf("key not found\n");
                return 0;
            }else{
                i -= q;
                t = p;
                p = q;
                q = t - q;
            }
        }
        if(K > T[i - 1]){
            if(p == 1){
                printf("key not found\n");
                return 0;
            }else{
                i += q;
                p -= q;
                q -= p;
            }
        }
    }
}

int main(){
    int K, n;
    scanf("%d", &n);

    int T[n + 1];

    for(int i = 0; i < n; i++){
        scanf("%d", &T[i]);
    }

    scanf("%d", &K);

    fiboSearch(T, K, n);

    return 0;
}