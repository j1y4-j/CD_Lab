%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token IF
%token ID NUM
%token GT LT GE LE EQ NE
%token ASSIGN
%token PLUS MINUS MUL DIV
%token LPAREN RPAREN
%token SEMICOLON

%%

program:
        statement
        {
            printf("Valid Statement\n");
	    exit(0);
        }
        ;

statement:
        IF LPAREN condition RPAREN statement
        | IF LPAREN condition RPAREN simple_statement
        ;

condition:
        expression relational_operator expression
        | expression
        ;

relational_operator:
        GT
        | LT
        | GE
        | LE
        | EQ
        | NE
        ;

simple_statement:
        ID ASSIGN expression SEMICOLON
        ;

expression:
        expression PLUS term
        | expression MINUS term
        | term
        ;

term:
        term MUL factor
        | term DIV factor
        | factor
        ;

factor:
        ID
        | NUM
        ;

%%

void yyerror(const char *s)
{
    printf("Syntax Error: %s\n", s);
    exit(0);
}

int main()
{
    printf("Enter an if statement:\n");
    yyparse();
    return 0;
}
