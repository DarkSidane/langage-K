%{
#include "parseur-K.tab.h"
%}

%%
[0-9]+   { yylval= atoi(yytext); return INTEGER; }
"+"      { return PLUS; }
"-"      { return MOINS; }
"*"      { return FOIS; }
[ \t]    { /* Ignorons les espaces */ }
.|\n     { return *yytext; }

%%
