%{
#include "y.tab.h"
%}

%%

"if"        { return IF; }

">="        { return GE; }
"<="        { return LE; }
"=="        { return EQ; }
"!="        { return NE; }
">"         { return GT; }
"<"         { return LT; }

"="         { return ASSIGN; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MUL; }
"/"         { return DIV; }

"("         { return LPAREN; }
")"         { return RPAREN; }
";"         { return SEMICOLON; }

[0-9]+      { return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }

[ \t\n]+    { /* ignore whitespace */ }

.           { return yytext[0]; }

%%

int yywrap(){
return 1;
}
