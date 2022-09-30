#include <stdio.h>
#include <stdlib.h>

void update(int *a, int *b) {
    /* Write your code for update() here */
    int tmpA = *a;
    int tmpB = *b;

    *a = tmpA + tmpB;
    *b = abs(tmpA - tmpB);
}

int main() {
    int a, b;
    scanf("%d", &a);
    scanf("%d", &b);

    /* Supply code to call update() here */    
    update(&a, &b);

    printf("%d\n%d", a, b);

    return 0;
}