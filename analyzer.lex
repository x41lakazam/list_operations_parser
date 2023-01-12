%{
#include "q3.h"
#include "parser.tab.h"
#include <stdlib.h>
%}

digit [0-9]
integer {digit}+
delim [ \t]

%%

delim 		{}
integer 	{yylval=atoi(yytext); return NUMBER;}
"max" 		{return MAX;}
"sum" 		{return SUM;}
"greater" 	{return GREATER;}
"cons"	 	{return CONS;}
"tail" 		{return TAIL;}
"[" 		{return RIGHTSBKT;}
"]" 		{return LEFTSBKT;}
"(" 		{return LEFTBKT;}
")" 		{return RIGHTBKT;}
"," 		{return COMMA;}
"\n" 		{return END;}










