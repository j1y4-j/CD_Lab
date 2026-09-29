%{
#include<stdio.h>
#include<stdlib.h>
extern int yylex();
extern int yylineno;
void yyerror(const char *s);
char function_type[20];
int return_found=0;
int return_error=0;
int function_depth=0;
%}

%union{
    char* str;
}

%token <str> ID
%token FOR WHILE RETURN
%token INT INTNUM FLOAT FLOATNUM
%token GT LT GE LE EQ NE
%token PLUS MINUS MUL DIV

%type <str> type expression term 
factor

%%

input:  functions;

        functions: functions function
                 | function
                 ;

        function: type ID '('
                  {
                    strcpy(function_type,$1);
                    return_found=0;
                    return_error=0;
                    function_depth++;
                  }
                parameters ')' '{' body '}'
                {
                    if(strcmp(function_type, "void")!= 0 && return_found == 0){
                        printf("SYNTAX ERROR, MISSING RETURN STATEMENT IN %s AT %d\n",$2, yylineno);
                        return_error=1;
                    }
                    function_depth--;
                    if(return_error==0){
                        printf("Valid function definitiion: %s\n",$2);
                    }
                }
                   ;

        parameters: parameter_list
                   | /*empty*/
                   ;
        parameter_list: parameter
                      | parameter_list ',' parameter
                      ;
        
        parameter: type ID
                  ;
        
        body:     body statement
                | /*empty*/
                ;
        
        statement: declaration
                 | assignment ';'
                 | return_statement
                 ;
        
       declaration: type ID ';'
                    | type ID '=' expression ';'
                    ;
        
        assignment: ID '=' expression
                  ;
        
        return_statement: RETURN expression ';'
                          {
                            char current_type[20];
                            if(strstr($2, ".")!=NULL) strcpy(current_type, "float");
                            else strcpy(current_type, "int");
                            return_found=1;
                            if(strcmp(current_type, function_type)!=0){
                                printf("SYNTAX ERROR, conflicting return type at %d\n",yylineno);
                                return_error=1;
                            }
                          }
                        ;
        
        type:          INT
                        {
                            $$ = "int";
                        }
                        | FLOAT
                            {
                              $$ = "float";
                            }
                        ;

        expression: expression PLUS term
                        {
                            $$ = "expr";
                        }
                  | expression MINUS term
                    {
                        $$ = "expr";
                    }
                  | term
                    {
                        $$ =$1;
                    }
        term:       term MUL factor 
                    {
                        $$="expr";
                    }
                  | term DIV factor
                    {
                        $$="expr";
                    }
                  | factor
                    {
                        $$ =$1;
                    }
                  ;

        factor:    ID
                    {
                        $$="id";
                    }
                   | INTNUM
                    {
                        $$="int";
                    }
                   | FLOATNUM
                     {
                        $$=:"float";
                     }
                   | '(' expression ')'
                    {
                        $$ =$2;
                    }
                   ;
        
%%

void yyerror(const char *s){
    printf("Syntax Error at line number: %d. Invalid statement\n", yylineno);
    exit(0);
}

int main(){
    printf("Enter c-like function definitions: ");
    if(yyparse()==0){
        printf("\n Parsing completed successfully\n");
    }
    else{
        printf("\nParsing Failed\n");
    }
    return 0;
}
