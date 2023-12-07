%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "table_symbole.h"  // Inclure le fichier d'en-tête de la table des symboles
extern int yylex();
extern dico d;
void yyerror(const char *s);

int expression_valid = 0;
%}

%union {
  int intval;
  char* strval;
}

%token <intval> INTEGER PLUS MOINS FOIS INF INFEG EGALE NOT OR AND GPAR DPAR EOL EGAL IF WHILE ELSE GACC DACC
%token <strval> VARIABLE COMMA INT VIRGULE
%left PLUS MOINS OR AND FOIS INF INFEG EGALE NOT GPAR DPAR COMMA

%type <intval> entier 
%type <intval> variables


%%

input: /* empty */
	| input line
	;

line: bloc_code2 EOL
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
expression2 : expression 
		| expression expression2
		  | GACC expression2 DACC {printf("bloc de code\n"); }
	;
bloc_code2 : expression2
	| expression2 bloc_code2
	;
expression :  INT VARIABLE EGAL entier COMMA 
		{
			variable *v = chercherVariable(&d, $2);
			if (v != NULL) 
			{
				printf("Variable %s trouvée\n", $2);
				printf("La variable %s ne va pas être initialisée\n", $2);

			} 
			else 
			{
				printf("Variable %s non trouvée\n", $2);
				ajouterVariable(&d, $2, GLOBAL, NULL, 0);
				printf("initialisation de la variable %s à %d\n", $2, $4);
			}	
		}
		| VARIABLE EGAL entier COMMA 
		{
			variable *v = chercherVariable(&d, $1);
			if (v != NULL) 
			{
				printf("Variable %s trouvée\n", $1);
				printf("Affectation de la variable %s à %d\n", $1, $3);

			} 
			else 
			{
				printf("Variable %s non trouvée\n", $1);
				printf("Impossible d'affecter la variable %s à %d\n", $1, $3);
			}	
		}
		| COMMA {printf("Instruction vide\n"); }
		| INT VARIABLE COMMA 
		{
			variable *v = chercherVariable(&d, $2);
			if (v != NULL) 
			{
				printf("Variable %s trouvée\n", $2);
				printf("La variable %s ne va pas être initialisée\n", $2);

			} 
			else 
			{
				printf("Variable %s non trouvée\n", $2);
				ajouterVariable(&d, $2, GLOBAL, NULL, 0);
				printf("initialisation de la variable %s \n", $2); 
			}	
		}
		| INT variables COMMA {printf("initialisation des variables\n"); }
		| IF GPAR entier DPAR  expression2 ELSE expression2 {printf("Instruction IF ELSE\n"); } 
		| IF GPAR entier DPAR expression2 {printf("Instruction IF\n"); }
		| WHILE GPAR entier DPAR expression2 {printf("Instruction WHILE\n"); }
		;	
variables : VARIABLE VIRGULE variables 
		{
			variable *v = chercherVariable(&d, $1);
			if (v != NULL) 
			{
				printf("Variable %s trouvée\n", $1);
				printf("La variable %s ne va pas être initialisée\n", $1);

			} 
			else 
			{
				printf("Variable %s non trouvée\n", $1);
				ajouterVariable(&d, $1, GLOBAL, NULL, 0);
				printf("initialisation de la variable %s \n", $1); 
			}	
		}
	  | VARIABLE 
		{
			variable *v = chercherVariable(&d, $1);
			if (v != NULL) 
			{
				printf("Variable %s trouvée\n", $1);
				printf("La variable %s ne va pas être initialisée\n", $1);

			} 
			else 
			{
				printf("Variable %d non trouvée\n", $1);
				ajouterVariable(&d, $1, GLOBAL, NULL, 0);
				printf("initialisation de la variable %s \n", $1); 
			}	
		}
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
	| VARIABLE        { $$ = atoi($1); }
	| function        { $$ = 0; }
	;



function : VARIABLE GPAR expression DPAR {printf("function %s\n", $1); };

%%

void yyerror(const char *s) 
{
	fprintf(stderr, "error: %s\n", s);
}

