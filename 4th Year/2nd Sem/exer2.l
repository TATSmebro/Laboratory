%{
#include <stdio.h>

int word_count = 0;
%}

%%
[a-zA-Z]+                                                       { word_count++; }
[!"#$%&'()*+,\-.\/:;<=>?@\[\\\]^_`{|}~]+                        {}
[ \t\n]+                                                        {}
.                                                               { printf("Invalid input detected\n"); return 0;}
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    printf("Word Count: %d\n", word_count);
    return 0;
}
