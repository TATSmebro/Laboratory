#include <stdio.h>
#include <stdlib.h>

void tri(int a, int b, int c){
    if((a + b) > c && (a + c) > b && (b + c) > a){
        printf("YES\n");
    }
    else{
        printf("NO\n");
    }
}

int main(){
    int testCases, a, b, c;
    
    scanf("%d", &testCases);

    for(int i = 0; i < testCases; i++){
        scanf("%d %d %d", &a, &b, &c);
        tri(a, b, c);
    }

    return 0;
}