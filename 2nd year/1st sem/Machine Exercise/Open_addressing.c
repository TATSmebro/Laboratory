#include <stdio.h>
#include <stdlib.h>

typedef struct table Table;
struct table{
    int numberOfSlots;
    int numberOfData;
    int collisions;
    int key[256];
    int data[256];
};


int h1(int key){
    return key % 256;
}

int h2(int key){
    return (((1731 * key + 520123) % 524287) % 256 ) | 1;
}

int hash_function(int key, int i){
    return (h1(key) + (i * h2(key))) % 256;
}

void hash_table_init(Table* T){
    T->numberOfSlots = 256;
    T->numberOfData = 0;
    T->collisions = 0;
    for(int i = 0; i < T->numberOfSlots; i++){
        T->key[i] = 0;
    }
}

void hash_table_insert(Table* T, int key, int data){
    if(T->numberOfData == T->numberOfSlots){
        printf("Table is full\n");
        return;
    }

    int i = 0;

    while(1){
        int key_index = hash_function(key, i);
        
        if(T->key[key_index] == key){
            printf("Duplicate key found\n");
            return;
        }

        if(T->key[key_index] > 0){
            T->collisions++;
            i++;
        }

        if(T->key[key_index] == 0){
            T->key[key_index] = key;
            T->data[key_index] = data;
            T->numberOfData++;
            return;
        }
    }
}

void print_table(Table* T){
    for(int i = 0; i < 256; i++){
        printf("%d: %d\n", i, T->data[i]);
    }
}

int main(){
    Table* table = malloc(sizeof(Table));
    hash_table_init(table);

    int to_insert;

    for(int i = 0; i < 256; i++){
        scanf("%d", &to_insert);
        hash_table_insert(table, to_insert, to_insert);
    }

    print_table(table);
    printf("%d\n", table->collisions);

    return 0;
}