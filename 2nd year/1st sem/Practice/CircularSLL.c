#include <stdio.h>
#include <stdlib.h>

typedef struct node Node;
struct node{
    int data;
    Node* next;
};

Node* initList(){
    Node* l = NULL;
    return l;
}

void insert(Node** l_ptr, int x, char y){
    Node* node = malloc(sizeof(Node));
    node->data = x;
    if(*l_ptr == NULL){
        node->next = node;
        *l_ptr = node;
    }
    else{
        node->next = (*l_ptr)->next;
        (*l_ptr)->next = node;
        if(y == 'r'){
            *l_ptr = node;
        }
    }
}

void deleteLeft(Node** l_ptr){
    if(*l_ptr == NULL){
        printf("Attempt to delete on an empty list\n");
    }else{
        Node* left = (*l_ptr)->next;
        (*l_ptr)->next = (*l_ptr)->next->next;
        if(left->next == left){
            *l_ptr = NULL;
        }
        free(left);
    }
}

void deleteRight(Node** l_ptr){
    if(*l_ptr == NULL){
        printf("Attempt to delete on an empty list\n");
    }else{
        Node* prev = (*l_ptr)->next;
        while(prev->next != (*l_ptr)){
            prev = prev->next;
        }
        prev->next = (*l_ptr)->next;
        Node* right = *l_ptr;
        *l_ptr = prev;
        if(right->next == right){
            *l_ptr = NULL;
        }
        free(right);
    }
}

void printList(Node* l){
    if(l == NULL){
        printf("empty list\n");
    }else{
        Node* firstNode = l->next;
        Node* currNode = firstNode;
        printf("%d ", currNode->data);
        currNode = currNode->next;
        while(currNode != firstNode){
            printf("%d ", currNode->data);
            currNode = currNode->next;
        }
    }
    printf("\n");
}

int main(){
    Node* l = initList();
    // for(int i = 1; i < 6; i++){
    //     insert(&l, i, 'r');
    // }

    // printList(l);
    // deleteLeft(l);
    // printList(l);
    // deleteRight(&l);
    // printList(l);

    for(int i = 6; i < 11; i++){
        insert(&l, i, 'l');
    }
    printList(l);
    deleteRight(&l);
    deleteRight(&l);
    printList(l);
    deleteLeft(&l);
    deleteLeft(&l);
    deleteRight(&l);
    printList(l);
    return 0;
}