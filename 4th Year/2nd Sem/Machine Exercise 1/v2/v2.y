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
        program statement
        | /* NULL */
        ;

statement:
        expression';'                  { printf("%d\n", $1); }
        ;

expression:
        DIGIT                          { $$ = $1; }
        | expression AT expression     { $$ = $1 + $3; }
        | expression BAWAS expression  { $$ = $1 - $3; }
        ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main (int argc, char *argv[]){
    freopen (argv[1], "r", stdin);
    return yyparse ();
}