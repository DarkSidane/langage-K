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

%token <intval> INTEGER PLUS MOINS FOIS INF INFEG EGALE NOT OR AND GPAR DPAR EOL EGAL IF WHILE ELSE GACC DACC
%token <strval> VARIABLE COMMA INT
%left PLUS MOINS OR AND FOIS INF INFEG EGALE NOT GPAR DPAR COMMA

%type <intval> entier 

%%

input: /* empty */
	| input line
	;

line: bloc_code EOL
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
expression :  INT VARIABLE EGAL entier COMMA {printf("initialisation de la variable %s à %d\n", $2, $4); }
	   | VARIABLE EGAL entier COMMA {printf("affectation de la variable %s à %d\n", $1, $3); }
	   | INT VARIABLE COMMA {printf("initialisation de la variable %s \n", $2); }
	| IF GPAR entier DPAR  bloc_code ELSE bloc_code {printf("Instruction IF ELSE\n"); } 
	| IF GPAR entier DPAR bloc_code {printf("Instruction IF\n"); }
	| WHILE GPAR entier DPAR bloc_code {printf("Instruction WHILE\n"); }
;	

bloc_code : expression 
	  | GACC expression2 DACC {printf("bloc de code\n"); }
	;
expression2 : expression 
	    | expression expression2
	;
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
	| VARIABLE        { $$ = $1; }
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
