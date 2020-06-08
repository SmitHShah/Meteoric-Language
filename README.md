# Meteoric-Language

To run:

lex lang.l

yacc -d lang.y

cc lex.yy.c y.tab.c

./a.out input.txt
