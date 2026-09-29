%{
#include<stdlib.h>
#include<stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token ZERO ONE END INVALID

%%

input:  S END
        {
                    printf("Valid string\n");
                    exit(0);
        }
        ;

        S: ZERO S ONE
           |ZERO ONE
        ;
%%

int main(){
    printf("Enter a string: ");
    yyparse();
    return 0;
}

void yyerror(const char *s){
    printf("Invalid string\n");
    exit(0);
}