#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countInt(int numToFind, int numField){
    char numFieldStr[20], numToFindStr[20];
    int counter = 0;

    sprintf(numToFindStr, "%d", numToFind);
    sprintf(numFieldStr, "%d", numField);

    for(int j = 0; numFieldStr[j] != '\0'; j++){
        if(numFieldStr[j] == numToFindStr[0]){
            counter++;
        }
    }

    return counter;
}

int main(){
    int testCases, numToFind, numField;
    
    scanf("%d", &testCases);

    for(int i = 0; i < testCases; i++){
        scanf("%d %d", &numToFind, &numField);
        printf("%d\n", countInt(numToFind, numField));
    }

    return 0;
}