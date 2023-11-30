%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
void yyerror(const char *s);

int expression_valid = 0;
%}

%union {
  int intval;
  char* strval;
}

%token <intval> INTEGER PLUS MOINS FOIS INF INFEG EGALE NOT OR AND GPAR DPAR EOL
%token <strval> VARIABLE COMMA INT
%left PLUS MOINS OR AND FOIS INF INFEG EGALE NOT GPAR DPAR 

%type <intval> entier 
%type <intval> int_variable 

%%

input: /* empty */
	| input line
	;

line: expression EOL
	{
		expression_valid = 1;
		printf("Expression valide\n\n");
	}
	| error EOL
	{
		expression_valid = 0 ;
		printf("Expression invalide\n");
		yyerrok;
	}
	;
expression :  entier ;
int_variable : INT VARIABLE {printf("Création d'une nouvelle variable\n"); $$ = 0;};

entier : entier PLUS entier  { $$ = $1 + $3; }
	| entier MOINS entier { $$ = $1 - $3; }
	| entier FOIS entier  { $$ = $1 * $3; }
	| entier INF entier   { $$ = $1 < $3; }
	| entier INFEG entier { $$ = $1 <= $3; }
	| entier EGALE entier { $$ = $1 == $3; }
	| entier OR entier    { $$ = $1 || $3; }
	| entier AND entier   { $$ = $1 && $3; }
	| GPAR entier DPAR  { $$ = $2; }
	| NOT entier        { $$ = !$2; }
	| INTEGER         { $$ = $1; }
	| int_variable        { $$ = 0; }
	| function        { $$ = 0; }
	;



function : VARIABLE GPAR expression DPAR {printf("function %s\n", $1); };

%%

void yyerror(const char *s) 
{
	fprintf(stderr, "error: %s\n", s);
}

int main(void)
{
	yyparse();
	return 0;
}
