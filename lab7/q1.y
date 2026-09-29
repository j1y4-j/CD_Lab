%{
#include<stdio.h>
#include<stdlib.h>
extern int yylex();
extern int yylineno;
void yyerror(const char *s);
%}

%token FOR WHILE
%token INT INTNUM FLOAT FLOATNUM
%token ID
%token GT LT GE LE EQ NE
%token PLUS MINUS MUL DIV


%%

input:  statements;

        statements: statements statement
                 | statement
                 ;

        statement: loop
                   | declaration
                   | assignment ';'
                   ;
        
        loop:      for_loop 
                   | while_loop
                   ;
        
        for_loop:   FOR '(' for_init ';' condition ';' update ')' block
                    {
                        printf("Valid FOR Loop at line number %d\n", yylineno);
                    }
                    ;
        
        while_loop: WHILE '(' condition ')' block
                    {
                        printf("Valid WHILE Loop at line number %d\n", yylineno);
                    }
                    ;
        
        block: '{' statements '}'
               | '{' '}'
               ;

        declaration: type ID ';'
                    | type ID '=' expression ';'
                    ;
        
        type: INT 
            | FLOAT
            ;

         
        for_init: type ID '=' expression
                 | ID '=' expression
                 | 
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

        update:     ID '=' ID PLUS INTNUM
                    | ID '=' ID MINUS INTNUM
                    | ID '=' ID PLUS FLOATNUM
                    | ID '=' ID MINUS FLOATNUM
                    ;

        assignment: ID '=' expression
                  ;
        
        expression: expression PLUS term
                  | expression MINUS term
                  | term
                   ;

        term:       term MUL factor 
                  | term DIV factor
                  | factor
                  ;

        factor:    ID 
                   | INTNUM
                   | FLOATNUM
                   | '(' expression ')'
                   ;

%%

void yyerror(const char *s){
    printf("Syntax Error at line number: %d. Invalid statement\n", yylineno);
    exit(0);
}

int main(){
    printf("Enter c-like loop program: ");
    if(yyparse()==0){
        printf("\n Parsing completed successfully\n");
    }
    else{
        printf("\nParsing Failed\n");
    }
    return 0;
    
}
