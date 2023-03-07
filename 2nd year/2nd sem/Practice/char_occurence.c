#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countInt(char chr, char *str){
    int counter = 0;

    for(int j = 0; str[j] != '\0'; j++){
        if(str[j] == chr){
            counter++;
        }
    }

    return counter;
}

int main(){
    int testCases;
    char chr[4], str[25];
    
    scanf("%d", &testCases);

    for(int i = 0; i < testCases; i++){
        scanf("%s %[^\n]", chr, str);
        printf("%d\n", countInt(chr[1], str));
    }

    return 0;
}