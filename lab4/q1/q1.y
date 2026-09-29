%{
    #include<iostream>
    #include<cstdlib>
    using namespace std;
    int yylex();
    void yyerror(const char *s);
%}

%token NUMBER

%left '+' '-'
%left '*' '/' '%'
%%

input:
    expr
    {
        cout << "Result: " << $1 << endl;
    }
;

expr:
    expr '+' expr
    {
        $$ = $1 + $3;
    }
    | expr '-' expr
    {
        $$ = $1 - $3;
    }
    | expr '*' expr
    {
        $$ = $1 * $3;
    }
    | expr '/' expr
    {
        if($3==0)
        {
            cout << "Error: Division by zero." << endl;
            exit(1);
        }
        $$ = $1/$3;
    }
    | expr '%' expr 
    {
        if($3==0)
        {
            cout << "Error: Denominator cannot be 0." << endl;
            exit(1);
        }
        $$ = $1%$3;
    }
    | '(' expr ')'
    {
        $$ = $2;
    }
    | NUMBER
    {
        $$ = $1;
    }
    %%

    void yyerror(const char *s)
    {
        cout << "Invalid expression." << endl;
    }
    int main(){
        cout << "Enter an expression: " << endl;
        yyparse();
        return 0;
    }