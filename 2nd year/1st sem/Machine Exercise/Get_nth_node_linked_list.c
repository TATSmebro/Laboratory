#include <stdio.h>
#include <stdlib.h>

#define newline printf("\n")

typedef struct node Node;
struct node{
	int data;
	Node* next;
};

//declare your functions here
void print_linked_list(Node *);
void build_linked_list(Node **);
int count(Node* , int );
int get_nth(Node *, int);
void free_node(Node *);

int main(){

	Node *head = NULL;
	int index, nth;
	
	// build a linked list
	build_linked_list(&head);
	
	// optionally, you may want to print the list to make sure data is stored as desired
	// print_linked_list(head);
	
	// read index, find value at nth index, determine number of copies in the list
	while((scanf("%d",&index)>0) && (index != -1)){
		nth = get_nth(head, index);
		printf("%d %d %d\n", index, nth, count(head,nth));
	}

	// free the nodes
	free_node(head);
	return 0;
}


void print_linked_list(Node *head){
	Node *current;
	for(current=head; current != NULL; current = current->next){
		printf("%d ", current->data);
	}
	newline;
}

void build_linked_list(Node **head_ptr){
	// Write your code here
	int data;
	while((scanf("%d",&data)>0) && (data != -1)){
		Node *node = malloc(sizeof(Node));
		node->data = data;
		node->next = *head_ptr;
		*head_ptr = node;
	}
}

int count(Node *head, int to_search){
	// Write your code here
	int count = 0;
	Node *current;
	for(current = head; current != NULL; current = current->next){
		if(to_search == current->data){
			count++;
		}
	}

	return count;
}

int get_nth(Node *head, int index){
	// Write your code here
	int val, idx = 0;
	Node *current = head;
	while(idx != index){
		val = current->data;
		current = current->next;
		idx++;
	}
	return val;
}

void free_node(Node *a_node){
	if(a_node!=NULL){
		free_node(a_node->next);
		free(a_node);
	}
}