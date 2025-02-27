%{
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    void yyerror(char *);

    char *nums[10] = {"wala", "isa", "dalawa", "tatlo", "apat", "lima", "anim", "pito", "walo", "siyam"};
%}

DIGIT           isa|dalawa|tatlo|apat|lima|anim|pito|walo|siyam|wala
SPACES          [ \t\r\n]+
%%

{DIGIT}             { 
                        for(int i = 0; i < 10; i++){
                            if(strcmp(nums[i], yytext) == 0){
                                yylval = i;
                                break;
                            }
                        }
                        return DIGIT;
                    }       

at                  { 
                        return AT;
                    } 

bawas               {
                        return BAWAS;        
                    }

;                   {
                        return ';';
                    }

{SPACES}            { /* Ignore white spaces*/ }

.                   { yyerror("Unknown character"); }

%%

int yywrap() {
    return 1;
}