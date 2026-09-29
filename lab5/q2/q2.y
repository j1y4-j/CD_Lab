%{
#include<stdlib.h>
#include<stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token TA TB TC END INVALID

%%

input: S END
        {
            printf("Valid string\n");
            exit(0);
        }
        ;

        S: TA S
          |TA B
        ;

        B: TB B
           |TB C
        ;

        C: TC
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

