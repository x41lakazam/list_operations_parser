#!/bin/bash
rm analyzer.lex.c parser.tab.c parser.tab.h
bison -d parser.y
flex -o analyzer.lex.c analyzer.lex
gcc -o q3 analyzer.lex.c parser.tab.c -lfl -lm
