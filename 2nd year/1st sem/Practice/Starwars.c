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

int main(){
    //input
    char firstName[110], middleName[110], lastName[110], hometown[110];

    fgets(firstName, 100, stdin);
    fgets(middleName, 100, stdin);
    fgets(lastName, 100, stdin);
    fgets(hometown, 100, stdin);

    //clean string
    cleanString(firstName);
    cleanString(middleName);
    cleanString(lastName);
    cleanString(hometown);

    //construct name
    char resultingFirstName[50];
    char resultingLastName[110];

    //construct first name
    for(int i = 0; i < 3; ++i){
        if(i < (strlen(firstName) - 1)){
            resultingFirstName[i] = firstName[i];
        }else{
            resultingFirstName[i] = firstName[strlen(firstName) - 1];
        }

    }

    resultingFirstName[3] = '\0';

    if(strlen(lastName) < 2){
        strcat(resultingFirstName, lastName);
    }else{
        resultingFirstName[3] = lastName[strlen(lastName) - 2];
        resultingFirstName[4] = lastName[strlen(lastName) - 1];
        resultingFirstName[5] = '\0';
    }

    //contruct last name
    for(int x = 0; x < 3; ++x){
        if(x < strlen(hometown) - 1){
            resultingLastName[x] = hometown[x];
        }else{
            resultingLastName[x] = hometown[strlen(hometown) - 1];
        }
    }

    resultingLastName[3] = '\0';
    
    strcat(resultingLastName, middleName);

    resultingFirstName[0] = toupper(resultingFirstName[0]);
    resultingLastName[0] = toupper(resultingLastName[0]);

    //output
    printf("%s %s", resultingFirstName, resultingLastName);
    return 0;
}



