%{
    #include"y.tab.h"
    #include<stdio.h>
    #include<string.h>
    extern int yylineno;

%}

%option yylineno

%%

"for"                   {return FOR;}
"while"                 {return WHILE;}
"int"                   {return INT;}
"float"                 {return FLOAT;}
"return"                {return RETURN;}

">="                    {return GE;}
"<="                    {return LE;}
"=="                    {return EQ;}
">"                     {return GT;}
"<"                     {return LT;}
"!="                    {return NE;}


"+"                     {return PLUS;}
"-"                     {return MINUS;}
"="                     {return '=';}
"/"                     {return DIV;}
"*"                     {return MUL;}
"("                     {return '(';}
")"                     {return ')';}
"{"                     {return '{';}
"}"                     {return '}';}
";"                     {return ';';}
[0-9]+\.[0-9]+          {return FLOATNUM;}
[0-9]+                  {return INTNUM;}
[a-zA-Z_][a-zA-z0-9]*   {return ID;}
[ \t\r]+                ;
.                       {
                            printf("LEXICAL ERROR, Invalid token %s at %d\n",yytext, yylineno);
                        }

%%

int yywrap(){
    return 1;
}