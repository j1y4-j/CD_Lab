%option noyywrap

%{
#include <iostream>
using namespace std;

int arthemetic = 0;
int relational = 0;
int logical = 0;
int assignment = 0;
int bitwise = 0;
int incdec = 0;
int ternary = 0;
%}

%%
"++"|"--"              { incdec++; }
"+"|"-"|"*"|"/"|"%"    { arthemetic++; }
"=="|"!="|"<="|">="|"<"|">" { relational++; }
"&&"|"||"|"!"          { logical++; }
"*="|"-="|"+="|"/="|"%="|"=" { assignment++; }
"&"|"|"|"^"|"~"|"<<"|">>" { bitwise++; }
"?"|":"                { ternary++; }

(.|\n)                 { }
%%

int main()
{
    yylex();

    cout << "Operators:\n";
    cout << "Increment/Decrement: " << incdec << endl;
    cout << "Arithmetic: " << arthemetic << endl;
    cout << "Relational: " << relational << endl;
    cout << "Logical: " << logical << endl;
    cout << "Bitwise: " << bitwise << endl;
    cout << "Assignment: " << assignment << endl;
    cout << "Ternary: " << ternary << endl;

    return 0;
}