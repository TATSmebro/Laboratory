%{
#include <stdio.h>
%}

%%
^([0-9]+|[a-zA-Z])[+,*,\/,-]([0-9]+|[a-zA-Z])$          { printf("Valid Expression: %s\n", yytext); }
.*                                                      { printf("Invalid Input: %s\n", yytext); }
[\n]                                                    { return 0; }
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
