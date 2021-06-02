%{


#include <stdio.h>
int yylex(void);
extern FILE *yyin;
%}



%token T_WHILE TYPE T_FOR T_DO T_IF T_CASE T_BUILTIN T_STRING T_SCAN LEF RIG T_STRUCT

%token T_IDENTIFIER T_STRINGLITERAL T_NUM HEADER T_RETURN T_PRINT

%token T_EQ T_INCDEC T_SHIFT_OP T_EQUALITY_OP T_OP T_REM T_NOT

%token T_CMA T_SC T_DOT T_AND T_OR T_XOR T_LRB T_LSB T_RSB T_LCB T_RCB T_REL_OP LOOP_TERMI ANDOR T_VOID T_COMMENT T_GLOBAL

%token T_RRB
%nonassoc T_ELSE
      
                        

                        
%start program

                        
%%

program: 
  def {printf("Parse Successful\n") ; }
  | def error
  ;

def:
  Extdeclaration
  | def Extdeclaration
  | HEADER
  | def HEADER
  ;

Extdeclaration:
  declaration
  | funcbody
  | funchead
  | arraydec
  | iteration
  | selection
  | T_COMMENT
  | diffun
  | T_GLOBAL
  | structure
  | T_IDENTIFIER T_EQ T_IDENTIFIER T_OP any T_SC
  | T_RETURN any T_SC
  | io
  ;

funcbody:
  TYPE T_IDENTIFIER T_LRB fundecl T_RRB T_LCB repeat T_RCB
  | T_VOID T_IDENTIFIER T_LRB fundecl T_RRB T_LCB repeat T_RCB
  ;

funchead:
  T_GLOBAL TYPE T_IDENTIFIER T_LRB fundecl T_RRB
  | T_GLOBAL T_VOID T_IDENTIFIER T_LRB fundecl T_RRB
  ;

diffun:
  T_IDENTIFIER LEF  numb  RIG T_LRB  variables  T_RRB T_SC

fundecl:
  TYPE T_IDENTIFIER
  | TYPE T_IDENTIFIER T_CMA fundecl
  | T_VOID
  | 
  ;

numb:
  T_NUM
  | T_NUM T_CMA numb
  ;

structure:
  T_STRUCT T_IDENTIFIER T_LCB struhelp T_RCB T_SC
  ;

struhelp:
  declaration
  | declaration struhelp
  ;

repeat:
  Extdeclaration
  | repeat Extdeclaration
  ;

declaration:
  TYPE variables T_SC
  | variables T_SC
  ;

variables:
  T_IDENTIFIER
  | T_IDENTIFIER T_CMA variables
  | T_IDENTIFIER T_EQ any
  | T_IDENTIFIER T_EQ any T_CMA variables
  | T_IDENTIFIER T_LSB any T_RSB T_EQ any
  | 
  ;

arraydec:
  TYPE T_IDENTIFIER T_LSB any T_RSB T_SC
  ;

iteration:
  T_WHILE T_LRB T_IDENTIFIER T_REL_OP any T_RRB postloop
  | T_FOR T_LRB variables T_SC T_IDENTIFIER T_REL_OP any T_SC T_IDENTIFIER T_EQ T_IDENTIFIER T_OP any T_RRB postloop
  ;
any:
  T_IDENTIFIER
  | T_NUM
  ;

postloop:
  T_LCB loop T_RCB
  | 
  ;

loop:
  Extdeclaration
  | loop Extdeclaration
  | loop LOOP_TERMI T_SC
  | LOOP_TERMI T_SC
  | 
  ;

selection:
  T_IF T_LRB ifelse T_RRB postloop
  | T_ELSE T_IF T_LRB ifelse T_RRB postloop
  | T_ELSE postloop

ifelse:
  T_IDENTIFIER T_REL_OP any
  | T_IDENTIFIER T_REL_OP any ANDOR ifelse

io:
  T_PRINT T_LRB T_STRING pcanbe T_RRB T_SC
  | T_SCAN T_LRB T_STRING scanbe T_RRB T_SC
  ;

pcanbe:
  T_CMA T_IDENTIFIER
  | T_CMA T_IDENTIFIER pcanbe
  | T_CMA T_IDENTIFIER T_LSB any T_RSB
  | T_CMA T_IDENTIFIER T_LSB any T_RSB pcanbe
  | 
  ;

scanbe:
  T_CMA T_AND T_IDENTIFIER
  | T_CMA T_AND T_IDENTIFIER scanbe
  | T_CMA T_IDENTIFIER T_LSB any T_RSB
  | T_CMA T_IDENTIFIER T_LSB any T_RSB scanbe
  ;

%%
int main(int argc,char* argv[])
{
  extern FILE *yyin, *yyout; 
  yyin = fopen("input.c", "r");
  yyparse();
  return 0;
}


void yyerror(char *s) {
  extern int yylineno;
  fprintf(stderr,"%s at line: %d \n",s,yylineno-1);
  return 0;
}