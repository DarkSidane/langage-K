%{
#include "parseur-K.tab.h"
%}

%%
[0-9]+   { yylval = atoi(yytext); return INTEGER; }
.|\n     { return *yytext; }
[ \t]    { /* Ignorons les espaces */ }
%%
