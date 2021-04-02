%{
#include<stdio.h>
int Keyword = 0;
int Header = 0;
int S_comment = 0;
int M_comment = 0;
int Identifier = 0;
int Separator = 0;
int Operator = 0;
int String_literal = 0;
int Char_literal = 0;
int Float_constant = 0;
int Int_constant = 0;
%}

%%
"#include"|"#define"|"int"|"float"|"char"|"double"|"long"|"for"|"while"|"do"|"continue"|"break"|"if"|"else"|"return"|"switch"|"case"|"default"|"struct"|"short"|"signed"|"unsigned"|"void"|"goto"|"static"|"sizeof"|"enum"|"typedef"|"const"|"union"|"printf"|"scanf"|"__global__" {printf("%s\tKeyword\n",yytext),Keyword++;}


"//".* {printf("%s\t single line comment \n",yytext),S_comment++;}

"/*"[^"*/"]*"*/"  {printf("%s\t multi line comment \n",yytext),M_comment++;}

[a-zA-Z_][a-zA-Z0-9_]* {printf("%s\tIdentifier\n",yytext),Identifier++;}

"{"|"}"|","|"("|")"|"["|"]"|"."|";"  {printf("%s\tSeparator\n",yytext),Separator++;}

[+*-/&|^][=]?|"++"|"--"|"=="|"!="|">"|"<"|">="|"<="|"&&"|"||"|"!"|"~"|"<<"|">>"|"="|"<<="|">>="|"<<<"|">>>"   {printf("%s\tOPERATOR\n",yytext),Operator++;}

"<"[^"<"|">"]*">"  {printf("%s\t Header \n",yytext),Header++;}

["].*["] {printf("%s\t string literal \n",yytext),String_literal++;}

['].['] {printf("%s\t character literal \n",yytext),Char_literal++;}

[-]?[0-9]+[.][0-9]+ {printf("%s\t Floating point constant \n",yytext),Float_constant++;}

[-]?[0-9]+ {printf("%s\t Integer constant \n",yytext),Int_constant++;}

[\t\n]+

.

%%
int yywrap()						
{
return 1;
}
int main(void)
{
extern FILE *yyin;
yyin = fopen("input.txt","r");
yylex();
printf("\n# of Keywords              : %d\n",Keyword);
printf("# of Headers               : %d\n",Header);
printf("# of Single line comments  : %d\n",S_comment);
printf("# of Multi line comments   : %d\n",M_comment);
printf("# of Identifiers           : %d\n",Identifier);
printf("# of Separators            : %d\n",Separator);
printf("# of Operators             : %d\n",Operator);
printf("# of string literals       : %d\n",String_literal);
printf("# of Character literals    : %d\n",Char_literal);
printf("# of Floating constants    : %d\n",Float_constant);
printf("# of Integer constants     : %d\n",Int_constant);
}
