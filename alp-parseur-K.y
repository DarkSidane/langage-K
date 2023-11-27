%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
void yyerror(const char *s);
%}
%union {
  int intval;
  char* strval;
}
%token <intval> INTEGER PLUS MOINS FOIS INF INFEG EGALE NOT OR AND GPAR DPAR
%token <strval> VARIABLE
%left PLUS MOINS OR AND FOIS INF INFEG EGALE NOT GPAR DPAR 

%type <intval> expr
%type <strval> variable

%%

lines:
     | lines line
     ;

line: expr '\n' { printf("%d\n", $1); }
    ;
variable: VARIABLE { /* Affectez ou récupérez la valeur de la variable */ 
			$$ = "variable"; }
    ;

expr: expr PLUS expr  { $$ = $1 + $3; }
    | expr MOINS expr { $$ = $1 - $3; }
    | expr FOIS expr  { $$ = $1 * $3; }
    | expr INF expr   { $$ = $1 < $3; }
    | expr INFEG expr { $$ = $1 <= $3; }
    | expr EGALE expr { $$ = $1 == $3; }
    | expr OR expr    { $$ = $1 || $3; }
    | expr AND expr   { $$ = $1 && $3; }
    | GPAR expr DPAR  { $$ = $2; }
    | NOT expr        { $$ = !$2; }
    | INTEGER         { $$ = $1; }
    | variable        { $$ = 0; }
    ;


%%

void yyerror(const char *s) {
  fprintf(stderr, "error: %s\n", s);
}

int main(void) {
  yyparse();
  return 0;
}
