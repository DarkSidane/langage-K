%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(const char *s);
%}

%token INTEGER PLUS MOINS FOIS INF INFEG EGALE NOT OR AND GPAR DPAR

%left PLUS MOINS FOIS INF INFEG EGALE OR NOT AND GPAR DPAR

%%
lines: /* empty */
	 | lines line
	 ;

line: expr '\n' { printf("%d\n", $1); }
	;

expr: expr PLUS expr  { $$ = $1 + $3; }
	| expr MOINS expr  { $$ = $1 - $3; }
	| expr FOIS expr  { $$ = $1 * $3; }
	| expr INF expr   { $$ = $1 < $3; }
	| expr INFEG expr { $$ = $1 <= $3; }
	| expr EGALE expr { $$ = $1 == $3; }
	| expr OR expr    { $$ = $1 || $3; }
	| expr AND expr   { $$ = $1 && $3; }
	| GPAR expr DPAR  { $$ = $2; }
	| NOT expr        { $$ = !$2; }
	| INTEGER { $$ = $1; }
	;

%%
void yyerror(const char *s) {
  fprintf(stderr, "error: %s\n", s);
}

int main(void) {
  yyparse();
  return 0;
}
