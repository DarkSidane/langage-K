%{
#include "alp-parseur-K.tab.h"
%}

%%
[0-9]+                { printf("ENT %s\n", yytext); yylval.intval = atoi(yytext); return INTEGER; }
"+"                   { printf("plus\n");  return PLUS; }
"-"                   { printf("MOINS\n"); return MOINS; }
"*"                   { printf("FOIS\n"); return FOIS; }
"<"                   { printf("INF\n"); return INF; }
"<="                  { printf("INFEG\n"); return INFEG; }
"=="                  { printf("EGALE\n"); return EGALE; }
"!"                   { printf("NOT\n"); return NOT; }
"||"                  { printf("OR\n"); return OR; }
"&&"                  { printf("AND\n"); return AND; }
"("                   { printf("GPAR\n"); return GPAR; }
")"                   { printf("DPAR\n"); return DPAR; }
";"		   { printf("COMMA\n"); return COMMA; }
","			{ printf("VIRGULE\n"); return VIRGULE; }
"int"                 { printf("INT\n"); return INT; }
"=" 		 { printf("EGAL\n"); return EGAL; }
"if"                  { printf("IF\n"); return IF; }
"else"                { printf("ELSE\n"); return ELSE; }
"while"               { printf("WHILE\n"); return WHILE; }
"{"                   { printf("GACC\n"); return GACC; }
"}"                   { printf("DACC\n"); return DACC; }

[a-zA-Z][a-zA-Z0-9_]* { printf("VAR %s\n", yytext); yylval.strval = strdup(yytext);return VARIABLE; }
[ \t]                 { /* Ignorons les espaces */ }
[\n]		  { printf("EOL\n"); return EOL; }
.|\n                  { return *yytext; }

%%
