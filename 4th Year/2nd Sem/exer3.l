%{
#include <stdio.h>
%}

%%
[+-]?[0-9]+\.[0-9]+$      { printf("FLOAT: %s\n", yytext); }
[+-]?[0-9]+$              { printf("INTEGER: %s\n", yytext); }
\n                       { /* ignore newline characters */ }
.                        { printf("Invalid input detected: %s\n", yytext); return 0; }
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
