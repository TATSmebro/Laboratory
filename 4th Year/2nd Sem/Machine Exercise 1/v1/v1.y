%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <ctype.h>

    void yyerror(char *);
    int yylex(void);
    extern FILE *yyin;
%}

%token DIGIT
%right AT BAWAS
%right ';'

%%

program:
        program expression
        | /* NULL */
        ;

expression:
        DIGIT AT DIGIT';'                 { printf("%d\n", $1 + $3); }
        | DIGIT BAWAS DIGIT';'            { printf("%d\n", $1 - $3); }
        ;

%%

void yyerror(char *s) {
    fprintf(stderr, "error\n");
}

int main (int argc, char *argv[]){
    freopen (argv[1], "r", stdin);
    return yyparse ();
}