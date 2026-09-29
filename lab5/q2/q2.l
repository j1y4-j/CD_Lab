%{
#include "y.tab.h"
%}

%option noyywrap

%%

a       return TA;
b       return TB;
c       return TC;
\n      return END;
[ \t]   ;
.       return  INVALID;

%%