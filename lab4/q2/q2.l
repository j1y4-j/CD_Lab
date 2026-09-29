%option noyywrap
%{
#include "q2.tab.h"
%}
%%

[01] {return yytext[0];}

\n   {return yytext[0];}   

%%