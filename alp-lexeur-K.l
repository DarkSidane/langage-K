%{
#include "alp-parseur-K.tab.h"
%}

%%
[0-9]+   { yylval= atoi(yytext); return INTEGER; }
"+"      { return PLUS; }
"-"      { return MOINS; }
"*"      { return FOIS; }
"<"      { return INF; }
"<="     { return INFEG; }
"=="     { return EGALE; }
"!"      { return NOT; }
"||"     { return OR; }
"&&"     { return AND; }
"("      { return GPAR; }
")"      { return DPAR; }
[ \t]    { /* Ignorons les espaces */ }
.|\n     { return *yytext; }

%%
