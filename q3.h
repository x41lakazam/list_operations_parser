#define MAX_SIZE 100

struct ItemList{
  int arr[MAX_SIZE];
  int len;
};

struct ItemList init_empty_list();
struct ItemList init_list(int first_val);
void append(struct ItemList list, int val);
struct ItemList tail(struct ItemList otherlist);
struct ItemList greater(struct ItemList otherlist, int thresh);
int max(struct ItemList list);
int sum(struct ItemList list);
