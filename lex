%{
#include <stdio.h>
%}

%%
"is"|"am"|"are"|"was"|"were"      { printf("%s : Verb\n", yytext); }
"run"|"runs"|"eat"|"eats"|"play"|"plays"|"write"|"writes"
                                   { printf("%s : Verb\n", yytext); }

"big"|"small"|"happy"|"sad"       { printf("%s : Adjective\n", yytext); }

"dog"|"dogs"|"cat"|"cats"|"boy"|"girl"
                                   { printf("%s : Noun\n", yytext); }

"quickly"|"slowly"                { printf("%s : Adverb\n", yytext); }

[a-zA-Z]+                         { printf("%s : Identifier\n", yytext); }

[ \t\n]+                          ;   // ignore spaces

.                                 { printf("%s : Unknown\n", yytext); }
%%

int main() {
    printf("Enter text:\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
RUN--
nano lex.l
flex lex.l
gcc lex.yy.c -o lexprog
./lexprog
