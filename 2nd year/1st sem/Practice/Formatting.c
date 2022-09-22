#include <stdio.h>
#include <math.h>
#include <string.h>

int hexToDeci(char* hex){

    int decimal;
    int i = 0, val, len;
    decimal = 0;
    len = strlen(hex);
    len--;

    for(i=0; hex[i]!='\0'; i++){
        if(hex[i]>='0' && hex[i]<='9'){
            val = hex[i] - 48;
        }else if(hex[i]>='a' && hex[i]<='f'){
            val = hex[i] - 97 + 10;
        }else if(hex[i]>='A' && hex[i]<='F'){
            val = hex[i] - 65 + 10;
        }

        decimal += val * pow(16, len);
        len--;
    }

    return decimal;
}

int main(){

    int pid, deci;
    char name[30], stat, hex[17];
    double cpu;

    printf("|   pid|    cpu|stat|                     name| hexdump|\n");
    printf("+------+-------+----+-------------------------+--------+\n");

    for(int i = 0; i < 1000; i++){
        scanf("%d %s %c %lf %s", &pid, name, &stat, &cpu, hex);
        printf("|%6d|%.5lf|%4c|%25s|%8d|\n", pid, cpu, stat, name, hexToDeci(hex));
    }

    return 0;
}