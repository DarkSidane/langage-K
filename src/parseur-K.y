%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(const char *s);
%}

%token INTEGER

%left '+' '-'
%left '*'

%%
line: expr '\n'  { printf("%d\n", $1); }
    ;

expr: expr '+' expr  { $$ = $1 + $3; }
    | expr '-' expr  { $$ = $1 - $3; }
    | expr '*' expr  { $$ = $1 * $3; }
    | INTEGER        { $$ = $1; }
    ;

%%
void yyerror(const char *s) {
  fprintf(stderr, "error: %s\n", s);
}

int main(void) {
  yyparse();
  return 0;
}
