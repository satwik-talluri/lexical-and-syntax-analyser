%{  
#include <string.h>
#include <stdlib.h>
#include "code.tab.h"
%}  
  
%option yylineno

%%  
"while" {return T_WHILE; }
"int"|"float"|"char"|"short"|"signed"|"unsigned" {return TYPE; }
"double"|"long"|"long long"|"long int"|"long long int" {return TYPE; }
"for" {return T_FOR; }
"do" {return T_DO; }
"if" {return T_IF; }
"case" {return T_CASE; }
"struct" {return T_STRUCT;}
"continue"|"break" {return LOOP_TERMI; }



"else" return T_ELSE;
"(" {return T_LRB;}
")" {return T_RRB;}



"printf" {return T_PRINT ;}
"scanf" {return T_SCAN ;}
"void" {return T_VOID;}
"return" {return T_RETURN;}
"__global__" {return T_GLOBAL;}
[a-zA-Z_][a-zA-Z0-9_]* {return T_IDENTIFIER;}
[-]?[0-9]+[.][0-9]+ {return T_NUM;} 
[-]?[0-9]+ {return T_NUM;}

"//".*|"/*"[^"*/"]*"*/" {return T_COMMENT;}

["].*["] {return T_STRING;}

"#include"[ ]*"<"[^"<"|">"]*">"  {return HEADER;}

"="  { return T_EQ;}
"++"  {return T_INCDEC;}
"--"  {return T_INCDEC;}
"<<<" {return LEF;}
">>>" {return RIG;}
"<<"|">>"  {return T_SHIFT_OP;}
"!=" {return T_EQUALITY_OP;}
"+"|"-"|"*"|"/"  {return T_OP;}
"%"  {return T_REM;}
"!"  {return T_NOT;}

"," { return T_CMA;}
";" {return T_SC;}
"." {return T_DOT;}

"&"  {return T_AND;}
"|"  {return T_OR;}
"^"  {return T_XOR;}

"&&"|"||" {return ANDOR;}

"[" {return T_LSB;}
"]" {return T_RSB;}
"{" {return T_LCB;}
"}" {return T_RCB;}


"<"|">"|"<="|">="|"=="|"!="|"==" {return T_REL_OP;}


[\t\n]+

.


%%  
   
int yywrap(){}; 

