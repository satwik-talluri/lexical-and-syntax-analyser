Instructions to run my program: (Ignore the warnings if any)

bison -d code.y

bison -v code.y

flex code.l

gcc code.tab.c lex.yy.c -o code.exe -w

code.exe


The program will output "Parse Successful" if there are no errors.

The program will outputs the error line no. if any found.