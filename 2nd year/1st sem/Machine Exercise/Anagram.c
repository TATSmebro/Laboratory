#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void cleanString(char* string){
    for (int i = 0, j; string[i] != '\0'; ++i) {
      
      while (!(string[i] >= 'a' && string[i] <= 'z') && !(string[i] >= 'A' && string[i] <= 'Z') && !(string[i] == '\0')) {
         
         for (j = i; string[j] != '\0'; ++j) {
            string[j] = string[j + 1];  
         }
         string[j] = '\0';
      }

      string[i] = tolower(string[i]);
   }
}

int countCharFreq(char* str, char chr){
    int freq = 0;

    for(int i = 0; str[i] != '\0'; ++i){
        if(str[i] == chr){
            ++freq;
        }
    }

    return freq;

}

int main(){

    char firstWord[110], secondWord[110];

    fgets(firstWord, 100, stdin);
    fgets(secondWord, 100, stdin);

    cleanString(firstWord);
    cleanString(secondWord);

    if(strlen(firstWord) == strlen(secondWord)){
        for(int i = 0; firstWord[i] != '\0'; ++i){
            if(countCharFreq(firstWord, firstWord[i]) == countCharFreq(secondWord, firstWord[i])){
                continue;
            }else{
                printf("No");
                return 0;
            }
        }

        printf("Yes");

    }else{
        printf("No");
    }

    return 0;
}