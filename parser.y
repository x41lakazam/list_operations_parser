%{
int yylex();
#include "q3.h"
%}

%union {
    struct ItemList list;
    int val;
}

%token LEFTSBKT  RIGHTSBKT  LEFTBKT  RIGHTBKT
%token TAIL  CONS  GREATER  SUM  MAX  COMMA END
%token NUMBER

%type <list> Itemlist List
%type <val> Item NUMBER

%start Input

%%

Input:

     | Input Line
;

Line:
    Item END {printf("Result: %d\n", $1); }
;

List:
    LEFTSBKT Itemlist RIGHTSBKT  { $$ = $2; }
    | TAIL LEFTBKT List RIGHTBKT { $$=tail($3); }
    | CONS LEFTBKT Item COMMA List RIGHTBKT { append($5, $3); $$=$5; }
    | GREATER LEFTBKT Item COMMA List RIGHTBKT { $$=greater($5, $3);}
;

Itemlist:
    Itemlist COMMA Item { append($1, $3); $$ = $1; }
    | Item  { $$ = init_list($1); }
;

Item:
	NUMBER { $$=$1; }
	| MAX LEFTBKT List RIGHTBKT { $$=max($3); }
	| SUM LEFTBKT List RIGHTBKT { $$=sum($3); }
;

%%


struct ItemList init_empty_list(){
  struct ItemList list;
  for (int i = 1; i< MAX_SIZE; i++){
    list.arr[i] = 0;
  }
  list.len = 0;
  return list;
}

struct ItemList init_list(int first_val){
  struct ItemList list = init_empty_list();
  list.arr[0] = first_val;
  list.len = 1;
}

void append(struct ItemList list, int val){
  list.arr[list.len++] = val;
}

struct ItemList tail(struct ItemList otherlist){
    struct ItemList list = init_empty_list();
    for (int i=1; i<otherlist.len; i++){
        append(list, otherlist.arr[i]);
    }
    return list;
}

struct ItemList greater(struct ItemList otherlist, int thresh) {
  struct ItemList list = init_empty_list();
  for (int i=0; i < otherlist.len; i++){
    if (otherlist.arr[i] > thresh)
      append(list, otherlist.arr[i]);
  }
  return list;
}

int max(struct ItemList list){
  int max = -999;
  for (int i=0; i<list.len; i++){
    if (list.arr[i] > max)
        max = list.arr[i];
  }
  return max;
}

int sum(struct ItemList list){
  int s = 0;
  for (int i=0; i<list.len; i++){
    s += list.arr[i];
  }
  return s;
}

int yyerror(char *s) {
  printf("Parser error: %s\n", s);
}

int main() {
  yyparse();
}
