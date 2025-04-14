%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%option noyywrap

%%

"/"      { printf("divided by"); return '/'; }
"//".*  { printf("comment"); return '\n'; }
[f]     {printf("floatdcl "); return FLOAT;}
[i]     {printf("intdcl "); return INT;}
[=]     {printf("assign "); return '='; }
[+]     {printf("plus "); return '+';}
[-]     {printf("minus "); return '-';}
[*]     {printf("times "); return '*';}
[p]     {printf("print "); return PRINT;}
[0-9]+  {printf("inum ");yylval.dval = atoi(yytext); return NUMBER;}
[0-9]+[.][0-9]+ {printf("floatnum ");yylval.dval = atof(yytext); return NUMBER;}
[a-zA-Z]+[0-9]*       {printf("id ");yylval.sval = yytext[0]; return ID;}
[ \t]                   { /* ignorar espacios */ }
\n                      { printf("\n"); return '\n'; }
.                       { return yytext[0]; }

%%
