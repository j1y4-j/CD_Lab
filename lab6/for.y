%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token FOR
%token ASSIGN ID NUM
%token GT LT GE LE EQ NE
%token PLUS MINUS MUL DIV
%token LPAREN RPAREN
%token SEMICOLON

%%

input:  statement
        {
            printf("Valid Statement\n");
            exit(0);
        }
        ;

        statement:  FOR LPAREN initialisation SEMICOLON condition SEMICOLON increment RPAREN statement
                 | FOR LPAREN initialisation SEMICOLON condition SEMICOLON increment RPAREN simple_statement
                 ;
        
        initialisation: ID ASSIGN expression
                      ;

        increment:    ID ASSIGN expression
                      ;
        
        condition:  expression relational_operator expression
                    | expression
                    ;

        relational_operator: GT
                            | LT
                            | GE
                            | LE
                            | EQ
                            | NE
                            ;

        expression: expression PLUS term
                    | expression MINUS term
                    | term
                    ;

        simple_statement: ID ASSIGN expression SEMICOLON
                        ;

        term:           term MUL factor
                        | term DIV factor
                        | factor
                        ;

        factor:         ID 
                        | NUM
                        ;

%%

void yyerror(const char *s){
    printf("Syntax Error. Invalid statement\n");
    exit(0);
}

int main(){
    printf("Enter an for statement: ");
    yyparse();
    return 0;
}





