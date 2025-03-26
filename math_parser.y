%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%union { int num; }  /* Declare type for values */

%token <num> NUMBER
%token ADD SUB MUL DIV POW LPAREN RPAREN

%type <num> exp line  /* Declare exp and line to use the same type */

%left ADD SUB
%left MUL DIV
%right POW  /* Exponentiation is right-associative */
%left UMINUS  /* Unary minus */

%%

input: 
    | input line
;

line: 
    exp '\n' { printf("Result: %d\n", $1); }
;

exp: 
    NUMBER                { $$ = $1; }
  | exp ADD exp           { $$ = $1 + $3; }
  | exp SUB exp           { $$ = $1 - $3; }
  | exp MUL exp           { $$ = $1 * $3; }
  | exp DIV exp           { 
                             if ($3 == 0) yyerror("Division by zero!");
                             else $$ = $1 / $3; 
                           }
  | exp POW exp           { $$ = (int)pow($1, $3); }
  | SUB exp %prec UMINUS  { $$ = -$2; }  /* Unary minus */
  | LPAREN exp RPAREN     { $$ = $2; }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    return yyparse();
}
