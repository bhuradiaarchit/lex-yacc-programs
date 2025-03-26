%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

/* Define regular expressions for tokens */
%option noyywrap
DIGIT [0-9]
LETTER [a-zA-Z]
IDENTIFIER {LETTER}({LETTER}|{DIGIT}|_)*
CONSTANT {DIGIT}+
STRING_LITERAL \"(\\.|[^\\"])*\"
KEYWORDS "if"|"then"|"else"|"while"|"switch"|"main"|"int"|"printf"|"scanf"|"for"|"include"
OPERATORS "="|"+"|"++"|"-"|"*"|"--"|"%"|"+="|"-="
RELATIONAL "<="|"<"|">="|">"|"=="|"!="
PREPROCESSOR "#include"

%%

{KEYWORDS} { fprintf(yyout, "%s: Keyword\n", yytext); }
{IDENTIFIER} { fprintf(yyout, "%s: Identifier\n", yytext); }
{CONSTANT} { fprintf(yyout, "%s: Constant\n", yytext); }
{STRING_LITERAL} { fprintf(yyout, "%s: String Literal\n", yytext); }
{OPERATORS} { fprintf(yyout, "%s: Operator\n", yytext); }
{RELATIONAL} { fprintf(yyout, "%s: Relational Operator\n", yytext); }
{PREPROCESSOR} { fprintf(yyout, "%s: Preprocessor Statement\n", yytext); }
. { /* Ignore other characters */ }

%%

int main() {
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");
    if (!yyin || !yyout) {
        printf("Error opening file!\n");
        return 1;
    }
    yylex();
    fclose(yyin);
    fclose(yyout);
    return 0;
}
