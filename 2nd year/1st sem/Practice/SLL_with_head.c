#include <stdio.h>
#include <stdlib.h>

typedef struct node Node;
struct node{
    int data;
    Node* next;
};

Node* initList(){
    Node* l = malloc(sizeof(Node));
    l->data = 0;
    l->next = NULL;
    return l;
}

void insert(Node* l, int x){
    Node* node = malloc(sizeof(Node));
    node->data = x;
    node->next = NULL;

    Node* last = l;
    while(last->next != NULL){
        last = last->next;
    }
    last->next = node;
}

int delete(Node* l, int x, char y){
    if(l->next == NULL){printf("Attempt to delete on empty list");}
    else{
        if(y == 'r'){
            Node* prev = l;
            Node* last = l->next;
            while(last->next != NULL){
                prev = last;
                last = last->next;
            }
            prev->next = NULL;
            x = last->data;
            free(last);
            return x;
        }
        else{
            Node* temp = l->next;
            l->next = l->next->next;
            x = temp->data;
            free(temp);
            return x;
        }
    }
}

void printList(Node* l){
    Node* node = l->next;
    if(node == NULL){
        printf("empty list");
    }
    else{    
        while(node != NULL){
            printf("%d ", node->data);
            node = node->next;
        }
    }
    printf("\n");
}

int main(){
    return 0;
}