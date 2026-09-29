%{
#include "y.tab.h"
%}

%option noyywrap

%%

0       return ZERO;
1       return ONE;
\n      return  END;
[ \t]   ;
.       return INVALID; 

%%