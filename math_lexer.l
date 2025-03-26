%{
#include "math_parser.tab.h"
#include <stdio.h>
%}

%option noyywrap
DIGIT [0-9]+

%%

{DIGIT}     { yylval.num = atoi(yytext); return NUMBER; }
"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MUL; }
"/"         { return DIV; }
"^"         { return POW; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"\n"        { return '\n'; }
[ \t]+      ;  /* Ignore spaces and tabs */
.           { printf("Unexpected character: %s\n", yytext); }

%%
