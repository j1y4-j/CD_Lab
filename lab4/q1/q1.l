%{
#include"q1.tab.h"
#include<cstdlib>
%}
%%

[0-9]+ {
         yylval= atoi(yytext);
         return NUMBER;
       }

[\t]+  ;

.      {
            return yytext[0];
       }

%%

int yywrap(){
    return 1;
}