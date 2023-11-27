%{
#include "alp-parseur-K.tab.h"
%}

%%

[0-9]+                { printf("ENT %s\n", yytext); yylval.intval = atoi(yytext); return INTEGER; }
"+"                   { return PLUS; }
"-"                   { return MOINS; }
"*"                   { return FOIS; }
"<"                   { return INF; }
"<="                  { return INFEG; }
"=="                  { return EGALE; }
"!"                   { return NOT; }
"||"                  { return OR; }
"&&"                  { return AND; }
"("                   { return GPAR; }
")"                   { return DPAR; }
[a-zA-Z][a-zA-Z0-9_]* { printf("VAR %s\n", yytext); yylval.strval = strdup(yytext);return VARIABLE; }
[ \t]                 { /* Ignorons les espaces */ }
.|\n                  { return *yytext; }

%%
