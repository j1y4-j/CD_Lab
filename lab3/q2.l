%{
#include <iostream>
#include <string>
#include <vector>
#include <iomanip>

using namespace std;

struct Symbol {
    string name;
    string category;    // "Variable" or "Function"
    string data_type;   // Return type or Data type
    string scope;       // "Global" or "Local"
    int num_params;     // -1 for Variables
    int line_num;
};

vector<Symbol> symbol_table;
int line_num = 1;
int scope_depth = 0; // 0 = Global, >0 = Local

string current_type = "";
string current_name = "";
bool is_function = false;
int param_count = 0;
int decl_line = 1;

void add_symbol(string name, string cat, string type, string scope, int params, int line) {
    symbol_table.push_back({name, cat, type, scope, params, line});
}
%}

%option noyywrap

TYPE      (void|int|float|double|char|bool|long|short|unsigned|signed|auto|std::string)
ID        [a-zA-Z_][a-zA-Z0-9_]*

%x DECL_PARAM STATE_IGNORE

%%

"\n"            { line_num++; }
"//".*          { /* Ignore comments */ }
"/*"([^*]|\*+[^*/])*\*+"/" { 
                    for(int i = 0; yytext[i] != '\0'; i++) {
                        if(yytext[i] == '\n') line_num++;
                    }
                }
[ \t\r]+        { /* Ignore whitespace */ }

"{"             { scope_depth++; }
"}"             { if (scope_depth > 0) scope_depth--; }

{TYPE}[ \t]+{ID}[ \t]*\( {
    // Found function header start e.g., "int foo("
    string text = yytext;
    size_t space_pos = text.find_first_of(" \t");
    size_t paren_pos = text.find("(");
    
    current_type = text.substr(0, space_pos);
    
    size_t name_start = text.find_first_not_of(" \t", space_pos);
    size_t name_end = text.find_last_not_of(" \t(", paren_pos);
    current_name = text.substr(name_start, name_end - name_start + 1);

    param_count = 0;
    decl_line = line_num;
    BEGIN(DECL_PARAM);
}

{TYPE}[ \t]+{ID} {
    // Variable declaration match e.g., "int x"
    string text = yytext;
    size_t space_pos = text.find_first_of(" \t");
    current_type = text.substr(0, space_pos);
    
    size_t name_start = text.find_first_not_of(" \t", space_pos);
    current_name = text.substr(name_start);
    
    string scope = (scope_depth == 0) ? "Global" : "Local";
    add_symbol(current_name, "Variable", current_type, scope, -1, line_num);
}

<DECL_PARAM>{
    "\n"        { line_num++; }
    [ \t\r]+    { /* ignore whitespace */ }
    "void"      { /* void parameter list handles 0 params */ }
    {TYPE}[ \t]+{ID}? { param_count++; }
    ","         { /* parameter delimiter */ }
    "\)"        {
                    string scope = (scope_depth == 0) ? "Global" : "Local";
                    add_symbol(current_name, "Function", current_type, scope, param_count, decl_line);
                    BEGIN(INITIAL);
                }
    .           { /* catch-all inside params */ }
}

.               { /* Default fallback */ }

%%

    int main(){

    yylex();

    cout << "\n===================================================================================================\n";
    cout << left << setw(20) << "Name" 
         << setw(15) << "Category" 
         << setw(18) << "Data/Return Type" 
         << setw(12) << "Scope" 
         << setw(18) << "No. Parameters" 
         << "Line Number" << endl;
    cout << "===================================================================================================\n";

    for (const auto& sym : symbol_table) {
        string params_str = (sym.category == "Function") ? to_string(sym.num_params) : "N/A";
        cout << left << setw(20) << sym.name 
             << setw(15) << sym.category 
             << setw(18) << sym.data_type 
             << setw(12) << sym.scope 
             << setw(18) << params_str 
             << sym.line_num << endl;
    }
    cout << "===================================================================================================\n";

    return 0;
}