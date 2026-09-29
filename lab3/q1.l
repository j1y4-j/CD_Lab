%{
#include <iostream>
#include <string>
#include <map>
#include <vector>
#include <iomanip>
#include <set>

using namespace std;

struct TokenInfo {
    string lexeme;
    string category;
    int frequency = 0;
    set<int> line_numbers;
};

// Key: pair<lexeme, category>
map<pair<string, string>, TokenInfo> token_table;
int line_num = 1;

void add_token(const string& lexeme, const string& category) {
    auto key = make_pair(lexeme, category);
    if (token_table.find(key) == token_table.end()) {
        token_table[key] = {lexeme, category, 0, {}};
    }
    token_table[key].frequency++;
    token_table[key].line_numbers.insert(line_num);
}
%}

%option noyywrap

/* Regular Expressions */
KEYWORD      alignas|alignof|and|and_eq|asm|auto|bitand|bitor|bool|break|case|catch|char|char8_t|char16_t|char32_t|class|compl|concept|const|consteval|constexpr|constinit|const_cast|continue|co_await|co_yield|co_return|decltype|default|delete|do|double|dynamic_cast|else|enum|explicit|export|extern|false|float|for|friend|goto|if|inline|int|long|mutable|namespace|new|noexcept|not|not_eq|nullptr|operator|or|or_eq|private|protected|public|register|reinterpret_cast|requires|return|short|signed|sizeof|static|static_assert|static_cast|struct|switch|template|this|thread_local|throw|true|try|typedef|typeid|typename|union|unsigned|using|virtual|void|volatile|wchar_t|while|xor|xor_eq

HEX_CONST    0[xX][0-9a-fA-F]+
OCT_CONST    0[0-7]+
DEC_CONST    0|[1-9][0-9]*
FLOAT_CONST  [0-9]*\.[0-9]+([eE][+-]?[0-9]+)?|[0-9]+\.[0-9]*([eE][+-]?[0-9]+)?|[0-9]+[eE][+-]?[0-9]+

IDENTIFIER   [a-zA-Z_][a-zA-Z0-9_]*

OP_ARITHMETIC \+\+|--|\+|\-|\*|\/|%
OP_RELATIONAL ==|!=|<=|>=|<|>
OP_LOGICAL    &&|\|\||!
OP_ASSIGNMENT =|\+=|-=|\*=|\/=|%=

DELIMITER     [;,\{\}\(\)\[\]]

%%

"\n"            { line_num++; }
"//".*          { /* Ignore single-line comments */ }
"/*"([^*]|\*+[^*/])*\*+"/" { 
                    /* Count lines in multi-line comments */
                    for(int i = 0; yytext[i] != '\0'; i++) {
                        if(yytext[i] == '\n') line_num++;
                    }
                }
[ \t\r]+        { /* Ignore whitespace */ }

{KEYWORD}       { add_token(yytext, "Keyword"); }
{FLOAT_CONST}   { add_token(yytext, "Numeric Constant (Float)"); }
{HEX_CONST}     { add_token(yytext, "Numeric Constant (Hexadecimal)"); }
{OCT_CONST}     { add_token(yytext, "Numeric Constant (Octal)"); }
{DEC_CONST}     { add_token(yytext, "Numeric Constant (Decimal)"); }
{IDENTIFIER}    { add_token(yytext, "Identifier"); }

{OP_ARITHMETIC} { add_token(yytext, "Arithmetic Operator"); }
{OP_RELATIONAL} { add_token(yytext, "Relational Operator"); }
{OP_LOGICAL}    { add_token(yytext, "Logical Operator"); }
{OP_ASSIGNMENT} { add_token(yytext, "Assignment Operator"); }

{DELIMITER}     { add_token(yytext, "Delimiter"); }

.               { /* Catch-all for unrecognized characters */ }

%%

    int main(){

    yylex();

    cout << "\n========================================================================================\n";
    cout << left << setw(25) << "Lexeme" 
         << setw(32) << "Token Category" 
         << setw(15) << "Frequency" 
         << "Line Number(s)" << endl;
    cout << "========================================================================================\n";

    for (const auto& entry : token_table) {
        const auto& info = entry.second;
        string lines = "";
        for (auto l : info.line_numbers) {
            lines += to_string(l) + " ";
        }
        cout << left << setw(25) << info.lexeme 
             << setw(32) << info.category 
             << setw(15) << info.frequency 
             << lines << endl;
    }
    cout << "========================================================================================\n";

    return 0;
}