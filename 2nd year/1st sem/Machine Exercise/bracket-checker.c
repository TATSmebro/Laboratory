#include <stdio.h>
#include <stdlib.h>

typedef int StackElemType;

typedef struct stacknode StackNode;
struct stacknode{ 
	StackElemType INFO;
 	StackNode *LINK;
};

struct stack{ 
	StackNode *top;
};

typedef struct stack Stack;

void InitStack(Stack *S) { 
	S->top = NULL;
}

int IsEmptyStack(Stack *S){ 
	return(S->top==NULL);
}

void StackOverflow(void){ 
	printf("Stack overflow detected.\n"); 
	exit(1);
}

void StackUnderflow(void){ 
	printf("Stack underflow detected.\n"); 
	exit(1);
}

void PUSH(Stack *S, StackElemType x){ 
	StackNode *alpha;
	alpha = (StackNode *) malloc(sizeof(StackNode));
 	if(alpha == NULL)
		StackOverflow();
	else {
		alpha ->INFO = x;
		alpha ->LINK = S ->top;
 		S ->top = alpha;
 	}
}

void POP(Stack *S, StackElemType *x){ 
	StackNode *alpha;
 	if(S->top == NULL)
		StackUnderflow();
	else {
		alpha = S ->top;
		*x = S ->top ->INFO;
		S ->top = S ->top ->LINK;
 		free(alpha);
 	}
}

int main(){
    Stack S; StackElemType x; char inp[100001];
    
    //init stack
    InitStack(&S);

    //get input
    scanf("%s", inp);

    //iterate over input
    char C; int unmatchedIdx = 0;
    for(int i = 0; inp[i] != '\0'; i++){
        C = inp[i];

        //if you detect a closing bracket
        if(C == '}' || C == ')' || C == ']'){
            //if queue is empty, then print i, end
            if(IsEmptyStack(&S)){
                printf("%d", i + 1);
                return 0;
            }
            //if queue is not empty, POP and check if it matches. If it does, continue. Otherwise, print i then end.
            else{
                POP(&S, &x);
                if((C == '}' && x != '{') || (C == ']' && x != '[') || (C == ')' && x != '(')){
                    printf("%d", i + 1);
                    return 0;
                }
                if(IsEmptyStack(&S)){
                    unmatchedIdx = 0;
                }
            }
        }

        //if you detect an opening bracket
        if(C == '{' || C == '(' || C == '['){
            //PUSH into queue.
            PUSH(&S, C);
            if(unmatchedIdx == 0){
                unmatchedIdx = i + 1;
            }
        } 
    }

    if(IsEmptyStack(&S)){
        printf("Success");
    }
    else{
        printf("%d",  unmatchedIdx);
    }
    
    return 0;
}