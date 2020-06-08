%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	extern int yylineno;
	extern FILE *yyin;
    extern char *yytext;
    int yylex();
    int yyerror(char *);
	
%}

%token PRINT READ INTO ASSIGN INTEGER DECIMAL BOOLVAL CHARACTER NEWLINE SWAP FUNCTION BRACES OPENING_FLOWER CLOSING_FLOWER
%token FUNCTION_NAME LOOP BEGIN_STR END
%token LE GE EQ NE GT LT DOT FOR WHILE IF ELSE ADD SUB MULT DIV MODULO

%nonassoc STRING
%nonassoc ID

%%
entry:	entry action
	| action
	;

action : print
	| input
	| assign
	| swap
	| function
	| loops
	| newline
	;

print : PRINT INTEGER NEWLINE {printf("rule: PRINT INTEGER\n");}
	| PRINT DECIMAL NEWLINE {printf("rule: PRINT DECIMAL\n");}
	| PRINT BOOLVAL NEWLINE {printf("rule: PRINT BOOLVAL\n");}
	| PRINT ID NEWLINE {printf("rule: PRINT ID\n");}
	| PRINT STRING NEWLINE	{printf("rule: PRINT STRING\n");}
	| PRINT STRING ID NEWLINE 	{printf("rule: PRINT STRING ID\n");}
	;

input:	READ INTO ID NEWLINE 	{printf("rule: READ INTO ID NEWLINE\n");}
	;

assign: ID ASSIGN INTEGER NEWLINE {printf("rule: ID ASSIGN INTEGER NEWLINE\n");}
	| ID ASSIGN DECIMAL NEWLINE {printf("rule: ID ASSIGN DECIMAL NEWLINE\n");}
	| ID ASSIGN BOOLVAL NEWLINE {printf("rule: ID ASSIGN BOOLVAL NEWLINE\n");}
	| ID ASSIGN STRING NEWLINE {printf("rule: ID ASSIGN STRING NEWLINE\n");}
	| ID ASSIGN CHARACTER NEWLINE {printf("rule: ID ASSIGN CHARACTER NEWLINE\n");}
	| ID ASSIGN operand operator operand NEWLINE {printf("rule: ID ASSIGN operand operator operand NEWLINE\n");}
	;

swap: SWAP ID ID NEWLINE {printf("rule: SWAP ID ID NEWLINE\n");}
	;

function: FUNCTION functionname OPENING_FLOWER stmts CLOSING_FLOWER NEWLINE {printf("rule: FUNCTION functionname OPENING_FLOWER stmts CLOSING_FLOWER NEWLINE\n");}
	| functionname NEWLINE  {printf("rule: functionname  NEWLINE\n");}
	;

functionname : FUNCTION_NAME
	;

loops: LOOP IF operand comparator operand BEGIN_STR stmts END NEWLINE {printf("rule: LOOP IF operand comparator operand BEGIN_STR stmts END NEWLINE \n");}
	;

stmts:stmts action
	 | action
	 ;

comparator: LE
	 | GE
	 | EQ
	 | NE
	 | GT
	 | LT
	 ;

operator: ADD
	 | SUB
	 | MULT
	 | DIV
	 | MODULO
	 ;

operand: ID
	 | INTEGER
	 | DECIMAL
	 ;

newline: NEWLINE 	{printf("rule: NEWLINE\n");}
	;
%%


int main(int argc, char *argv[])
{
    /*if(argc < 2){
        printf("Usage: ./a.out <input file name>\n");
        exit(1);
    }
    yyin = fopen(argv[1], "r");
    if(yyin == NULL){
        printf("could not open input/function file!");
        exit(0);
    }*/
    yyparse();
    //fclose(yyin);
    return 0;
}
         
int yyerror(char *s) {
    printf("\n \nLine: %d, Message: %s, Cause: %s\n", yylineno, s, yytext );
    return 0;
}

int yywrap(){return 1;}
