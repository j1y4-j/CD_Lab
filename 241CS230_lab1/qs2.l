%option noyywrap

%{
#include <iostream>
using namespace std;
%}

LETTER  [A-Za-z_]
DIGIT   [0-9]

%%

{DIGIT}+{LETTER}({LETTER}|{DIGIT})*     { cout << "Invalid Identifier: " << yytext << endl; }

{DIGIT}+\.[0-9]*\.[0-9]+                { cout << "Invalid Numeric Constant: " << yytext << endl; }

[@#$~']                                 { cout << "Illegal Character: " << yytext << endl; }

{LETTER}({LETTER}|{DIGIT})*             { }

{DIGIT}+(\.{DIGIT}+)?                   { }

[ \t\n]+                                { }

.                                       { }

%%

int main()
{
    cout << "Lexical Errors:" << endl;
    yylex();

    return 0;
}