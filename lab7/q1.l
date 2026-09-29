%{
    #include"y.tab.h"
    #include<stdio.h>
    #include<string.h>
    extern int yylineno;

%}

%option yylineno

%%

"for"                   {
                        printf("TOKEN: FOR LEXEME: %s LINE: %d\n", yytext, yylineno);
                         return FOR;
                         }
"while"                 {
                        printf("TOKEN: WHILE LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return WHILE;}
"int"                   {
                        printf("TOKEN: INT LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return INT;}
"float"                 {
                        printf("TOKEN: FLOAT LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return FLOAT;}
">="                    {
                        printf("TOKEN: GE LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return GE;}
"<="                    {
                        printf("TOKEN: LE LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return LE;}
"=="                    {
                        printf("TOKEN: EQ LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return EQ;}
">"                     {
                        printf("TOKEN: GT LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return GT;}
"<"                     {
                        printf("TOKEN: LT LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return LT;}
"!="                    {
                        printf("TOKEN: NQ LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return NE;}


"+"                     {
                        printf("TOKEN: PLUS LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return PLUS;}
"-"                     {
                        printf("TOKEN: MINUS LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return MINUS;}
"="                     {
                        printf("TOKEN: ASSIGN LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return '=';}
"/"                     {
                        printf("TOKEN: DIV LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return DIV;}
"*"                     {
                        printf("TOKEN: MUL LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return MUL;}
"("                     {
                        printf("TOKEN: LPAREN LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return '(';}
")"                     {
                        printf("TOKEN: RPAREN LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return ')';}
"{"                     {
                        printf("TOKEN: LBRACE LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return '{';}
"}"                     {
                        printf("TOKEN: RBRACE LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return '}';}
";"                     {
                        printf("TOKEN: SEMICOLON LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return ';';}
[0-9]+\.[0-9]+          {
                        printf("TOKEN: FLOATNUM LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return FLOATNUM;}
[0-9]+                  {
                        printf("TOKEN: INTNUM LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return INTNUM;}
[a-zA-Z_][a-zA-z0-9]*   {
                        printf("TOKEN: ID LEXEME: %s LINE: %d\n", yytext, yylineno);
                            return ID;}
\n                      ;
[ \t\r]+                ;
.                       ;

%%

int yywrap(){
    return 1;
}