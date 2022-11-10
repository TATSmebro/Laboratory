#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
//#include "header.h"

typedef struct BigInt {
    int data;
    struct BigInt* llink;
    struct BigInt* rlink;
} BigInt;

BigInt* zeroBigInt(){
    BigInt* l = malloc(sizeof(BigInt));
    l->data = 0;
    l->llink = l;
    l->rlink = l;
    return l;
}

void insertAtTail(BigInt* l, int term){
    BigInt* newNum = malloc(sizeof(BigInt));
    newNum->data = term;
    l->llink->rlink = newNum;
    newNum->rlink = l;
    newNum->llink = l->llink;
    l->llink = newNum;
}

BigInt* char_to_bigint(char *digits, int len) {
    BigInt* l = zeroBigInt();
    int nterms = 0;
    for(int i = 0; digits[i] != '\0'; i++){
        int term = digits[i] - 48;
        insertAtTail(l, term);  
        nterms++;
    }
    l->data = nterms; 
    return l;
}

void insertAtHeads(BigInt* l, int term){
    BigInt* newNum = malloc(sizeof(BigInt));
    newNum->data = term;
    newNum->rlink = l->rlink;
    newNum->llink = l;
    l->rlink->llink = newNum;
    l->rlink = newNum;
}

void sumForward(BigInt* l){  
    BigInt* node = l->rlink;
    while(node != l){
        printf("%d", node->data);
        node = node->rlink;
    }
}

BigInt* add(BigInt **a_ptr, BigInt **b_ptr) {
    BigInt* l = zeroBigInt();
    BigInt* a = *a_ptr;
    BigInt* b = *b_ptr;
    BigInt* alpha = a->llink;
    BigInt* beta = b->llink;
    int t, k = 0, c = 0, r = 10; 
    while(1){
        if(alpha != a && beta != b){
            t = alpha->data + beta->data + c;
            alpha = alpha->llink;
            beta = beta->llink;
        }else if(alpha != a && beta == b){
            t = alpha->data + c;
            alpha = alpha->llink;
        }else if(alpha == a && beta != b){
            t = beta->data + c;
            beta = beta->llink;
        }else if(alpha == a && beta == b){
            if(c != 0){
                insertAtHeads(l, c);
                k++;
            }
            l->data = k;
            sumForward(l);
            return l;
        }

    int term = t % r;
    insertAtHeads(l, term);
    c = floor(t/r);
    k++;
    }
}

int main(){
    BigInt* a = char_to_bigint("1235", 4);
    BigInt* b = char_to_bigint("9235", 4);
    add(&a, &b);
    return 0;
}

