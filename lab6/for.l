%{
    #include"y.tab.h"
%}

%%

"for"                   {return FOR;}
">="                    {return GE;}
"<="                    {return LE;}
"=="                    {return EQ;}
">"                     {return GT;}
"<"                     {return LT;}
"!="                    {return NE;}


"+"                     {return PLUS;}
"-"                     {return MINUS;}
"="                     {return ASSIGN;}
"/"                     {return DIV;}
"*"                     {return MUL;}
"("                     {return LPAREN;}
")"                     {return RPAREN;}
";"                     {return SEMICOLON;}
[0-9]+                  {return NUM;}
[a-zA-Z_][a-zA-z0-9]*   {return ID;}
[ \t\n]+                {}
.                       {}

%%

int yywrap(){
    return 1;
}