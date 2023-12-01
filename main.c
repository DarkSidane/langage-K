#include <stdio.h>
#include "table_symbole.h"
extern int yyparse();
dico d;
int main(void)
{
	yyparse();
	return 0;
}
