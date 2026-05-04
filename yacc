calc.l
%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%
"sin"      { return SIN; }
"cos"      { return COS; }
"sqrt"     { return SQRT; }

[0-9]+     { yylval = atoi(yytext); return NUMBER; }

/* only single letter variables */
[a-z]      { yylval = yytext[0]; return ID; }

[ \t]      ;   /* ignore spaces */

\n         return '\n';

.          return yytext[0];
%%

int yywrap() {
    return 1;
}
calc.y
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yylex();
void yyerror(const char *s);

int vars[26];   /* for variables a-z */
%}

%token NUMBER ID SIN COS SQRT

%%

input:
        | input line
        ;

line:
        '\n'
      | expr '\n'   { printf("Result = %d\n", $1); }
      ;

expr:
        NUMBER              { $$ = $1; }
      | ID                  { $$ = vars[$1 - 'a']; }
      | ID '=' expr         { vars[$1 - 'a'] = $3; $$ = $3; }

      | expr '+' expr       { $$ = $1 + $3; }
      | expr '-' expr       { $$ = $1 - $3; }
      | expr '*' expr       { $$ = $1 * $3; }
      | expr '/' expr       { $$ = $1 / $3; }

      | '(' expr ')'        { $$ = $2; }

      | SIN '(' expr ')'    { $$ = sin($3); }
      | COS '(' expr ')'    { $$ = cos($3); }
      | SQRT '(' expr ')'   { $$ = sqrt($3); }
      ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Enter expressions:\n");
    yyparse();
    return 0;
}
