%option noyywrap

%{
#include <iostream>
#include <string>
using namespace std;

bool isKeyword(string s)
{
    string keywords[] = {
        "auto","break","case","catch","class","const","continue",
        "default","delete","do","double","else","enum","long","int",
        "namespace","return","struct","void","while","bool",
        "unsigned","typedef"
    };

    for (string k : keywords)
    {
        if (s == k)
            return true;
    }

    return false;
}
%}

ID      [A-Za-z_][A-Za-z0-9_]*
NUM     [0-9]+(\.[0-9]+)?

%%

{ID}                    {
                            if(isKeyword(yytext))
                                cout << "<KEYWORD," << yytext << ">" << endl;
                            else
                                cout << "<IDENTIFIER," << yytext << ">" << endl;
                        }

{NUM}                   {
                            cout << "<NUMBER," << yytext << ">" << endl;
                        }

\"([^\\\"]|\\.)*\"      {
                            cout << "<STRING," << yytext << ">" << endl;
                        }

"=="|"!="|"<="|">="|"+"|"-"|"*"|"/"|"="|"<"|">" {
                            cout << "<OPERATOR," << yytext << ">" << endl;
                        }

"("|")"|"["|"]"|"{"|"}"|";"|"," {
                            cout << "<DELIMITER," << yytext << ">" << endl;
                        }

[ \t\n]+                ;

.                       {
                            cout << "<UNKNOWN," << yytext << ">" << endl;
                        }

%%

int main()
{
    cout << "Token Stream:" << endl;
    yylex();

    return 0;
}