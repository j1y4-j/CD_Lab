%option noyywrap
%{
    #include<iostream>
    #include<map>
    #include<string>
    using namespace std;
    map<string,int> keywordCount;
%}

/*keyword definitions*/
KEYWORD auto|break|case|catch|class|const|continue|default|delete|do|double|else|enum|long|int|namespace|return|struct|void|while|bool|unsigned|typedef
%%
{KEYWORD} {keywordCount[yytext]++;}
\"([^\\\"]|\\.)+\";
\'([^\\\']|\\.)\';
\/\/.*;
\/\+([^*]|\*+[^*/])*\*+\/;
.|\n;
%%
int main(){
    yylex();
    cout << "Keyword Count" << "\n";
    for(auto &x:keywordCount){
        cout << x.first << ": " << x.second << endl;
    }
    return 0;
}