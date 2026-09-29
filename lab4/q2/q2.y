%{
    #include<iostream>
    #include<cstdlib>
    using namespace std;
    int yylex();
    void yyerror(const char *s);
%}

%%

input:
    S '\n'
    {
        cout << "Accepted "<< endl;
        exit(0);
    }
    ;
    S: 
        '0'S 
       | '0''1'
    ;
    %%

      void yyerror(const char *s)
    {
        cout << "Rejected" << endl;
        exit(0);
    }
    int main(){
        cout << "Enter a string: " << endl;
        yyparse();
        return 0;
    }