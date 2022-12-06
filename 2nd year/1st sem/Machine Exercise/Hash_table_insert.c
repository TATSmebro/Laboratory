#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct node Node;
struct node{
    int key;
    char data[15];
    Node* next;
};

int hash_funtion_1(int key){
    return key % 32;
}

int hash_funtion_2(int key){
    int number = pow(2, 11);
    int index = ((31 * key) % number) >> (11 - 5);
    return index;
}

int hash_funtion_3(int key){
    return ((1731 * key + 520123) % 524287) % 32;
}

int string_to_int(char* str){
    int sum = 0;
    for(int i = 0; str[i] != '\0'; i++){
        sum += str[i];
    }
    return sum;
}

void chained_hash_table_init(Node** Table){
    for(int i = 0; i < 32; i++){
        Table[i] = NULL;
    }
}

void chained_hash_table_insert(Node** Table, int key, char* data, int function){
    int index;
    if(function == 1){
        index = hash_funtion_1(key);
    }
    else if(function == 2){
        index = hash_funtion_2(key);
    }
    else{
        index = hash_funtion_3(key);
    }

    Node* runningPointer = Table[index];
    while(runningPointer != NULL){
        runningPointer = runningPointer->next;
    } 

    runningPointer = malloc(sizeof(Node));
    runningPointer->key = key;

    //Store word to data
    for(int i = 0; data[i] != '\0'; i++){
        runningPointer->data[i] = data[i];
    }
    runningPointer->data[10] = '\0';

    runningPointer->next = Table[index];
    Table[index] = runningPointer;
}

void print_linked_list(Node* l){
    Node* node = l;
    while(node != NULL){
        printf("%s ", node->data);
        node = node->next;
    }
}

int main(){
    //initialize table
    Node* T[32];
    chained_hash_table_init(T);
    
    //get input for hash function and number of elements
    int hashFunction, numberOfElements;
    scanf("%d", &hashFunction);
    scanf("%d", &numberOfElements);

    //insert elements
    for(int i = 0; i < numberOfElements; i++){
        char data[15];
        scanf("%s", data);
        int key = string_to_int(data);
        chained_hash_table_insert(T, key, data, hashFunction);
    }

    //print table
    for(int i = 0; i < 32; i++){
        printf("%d: ", i);
        print_linked_list(T[i]);
        printf("\n");
    }

    return 0;
}