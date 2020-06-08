%{
	#include <stdio.h>
	#include "y.tab.h"  
%}

alpha	[a-zA-Z]
digit	[0-9]

%%
[ \t]						;
[ \n]						{yylineno = yylineno + 1; return NEWLINE;}
"true"|"false"					return BOOLVAL;
"()"						return BRACES;
"{"						return OPENING_FLOWER;
"}"						return CLOSING_FLOWER;
function					return FUNCTION;
read						return READ;
into						return INTO;
swap						return SWAP;
loop						return LOOP;
begin						return BEGIN_STR;
end 						return END;
for						return FOR;
while						return WHILE;
if						return IF;
else						return ELSE;
print						return PRINT;
{alpha}({alpha}|{digit}|"-"|"_")*\(\)		return FUNCTION_NAME;
{digit}+					return INTEGER;
{digit}*(\.{digit}+)?				return DECIMAL;
{alpha}({alpha}|{digit})*			return ID;
\".[^\"]*\"					return STRING;
\'.*\'						return CHARACTER;
"="						return ASSIGN;
"<="						return LE;
">="						return GE;
"=="						return EQ;
"!="						return NE;
">"						return GT;
"<"						return LT;
"+"						return ADD;
"-"						return SUB;
"*"						return MULT;
"/"						return DIV;
"%"						return MODULO;
"."						return DOT;
\/\/.*						;
\/\*(.*\n)*.*\*\/				;
%%
