%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void check_divisible_by_3(char *str) {
    int state = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] == '0') state = state;
        else if (str[i] == '1') state = (state + 1) % 3;
    }
    if (state == 0) printf("Binary string %s is divisible by 3\n", str);
}
%}

%%
[ \t.,;:()+\-_!=?\\"]+    ; 

[01]+    {
            if (strstr(yytext, "100")) printf("String %s contains 100\n", yytext);
            if (yytext[0] == '0' && yytext[strlen(yytext) - 1] == '1') 
                printf("String %s starts with 0 and ends with 1\n", yytext);
            check_divisible_by_3(yytext);
        }

a|a*b+   { printf("String %s contains 'a' or follows 'a*b+' pattern\n", yytext); }

.        ; /* Ignore other characters */
%%

int main() {
    yylex();
    return 0;
}

int yywrap() { return 1; }
