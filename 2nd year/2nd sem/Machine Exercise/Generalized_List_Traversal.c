/*
 * GeneralizedList.c
 * Sample Pseudocode/Implementation
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "stack_ops.h"

/*
 * Returns true if the input symbol is an atom which is by assumtion a letter in the English Alphabet
 */
int isAtom(char symbol){
	return (symbol >= 97 && symbol <= 122) || (symbol >= 65 && symbol <= 90);
}

/*
 * Reads the input pure list and builds a tag-data-link representation of the pure list
 * Returns a pointer to the first tag-data-link node
 */
GeneralizedListNode * readInput()
{
  char symbol;
  Stack S;
  InitStack(&S);

  while(scanf("%c", &symbol) != EOF)
  {
	  // 	if symbol is left parenthesis
	  //		push to stack S
      if(symbol == '('){

        StackElemType C;
		C.generalizedListNode = NULL;
        C.character = symbol;
        PUSH(&S, C);

	  //	else if symbol is an atom
	  //		push to stack S
      }else if(isAtom(symbol)){

        StackElemType C;
		C.generalizedListNode = NULL;
        C.character = symbol;
        PUSH(&S, C);

	  //	else if symbol is right parenthesis
	  //		pop a stack element,say top, from S (make sure stack is not empty before doing so)
	  //		set prevNode to null
      }else if(symbol == ')'){
		
		StackElemType top;
        POP(&S, &top);
        GeneralizedListNode *prevNode = NULL;

	  //		while stack S is not empty
        while(!IsEmptyStack(&S)){
	 
	  //			if top is an atom
	  //				create a corresponding GeneralizedListNode, say node
	  //					with tag=0;atom=top.character;list=null;link=prevNode
	  //				update prevNode with node
            if(isAtom(top.character)){
                GeneralizedListNode *Node;
				Node = (GeneralizedListNode *) malloc (sizeof(GeneralizedListNode));
                Node->tag = 0;
                Node->dataAtom = top.character;
                Node->dataList = NULL;
                Node->link = prevNode;
				prevNode = Node;

	  //			else if top is a left parenthesis
	  //				create a corresponding GeneralizedListNode
	  //					with tag=1;atom=0;list=prevNode;link=null
	  //				update prevNode with node
	  //				push node to stack S
	  //				break
            }else if(top.character == '('){
				GeneralizedListNode *Node;
				Node = (GeneralizedListNode *) malloc (sizeof(GeneralizedListNode));
                Node->tag = 1;
                Node->dataAtom = 0;
                Node->dataList = prevNode;
                Node->link = NULL;
				prevNode = Node;

				StackElemType x;
				x.generalizedListNode = Node;
				x.character = 0;
				PUSH(&S, x);
				break;

	  //			else if top is a GeneralizedListNode
	  //				update value of the link of top with prevNode
	  //				update prevNode with value of top
			}else if(top.character == 0){
				top.generalizedListNode->link = prevNode;
				prevNode = top.generalizedListNode;
			}
			
	  //			pop a stack element from S and store to top
			POP(&S, &top);
        }
	  //		if stack is empty
	  //	  	  	  return prevNode;
		if(IsEmptyStack(&S)){
			return prevNode;
		}
      }
  }

}

void VISIT(GeneralizedListNode *T)
{
	printf("-%c-", T->dataAtom);
}
	
void traversePureList(GeneralizedListNode *L)
{
	//	if L = null then return
	if(L == NULL){
		return;
	}

	//	call InitStack(S)
	Stack S;
	InitStack(&S);
	
	//	alpha <- L
	GeneralizedListNode *alpha = L;
	
	//	loop
	while(1){

	//1:if TAG(alpha) = 0 then call VISIT(DATA(alpha))
	// 	else [if DATA(alpha) = null then goto 2
	//								 else [call PUSH(S, alpha)
	//									alpha <- DATA(alpha); goto 1]]
	//2:alpha <- LINK (alpha)
	//	if alpha = null then if IsEmptyStack(S) then return
	//											else [ call POP(S, alpha); goto 2 ]
	one:
		if(alpha->tag == 0){
			VISIT(alpha);
		}else{
			if(alpha->dataList == NULL){
				goto two;
			}else{
				StackElemType x;
				x.character = 0;
				x.generalizedListNode = alpha;

				PUSH(&S, x);
				alpha = alpha->dataList;
				goto one;
			}
		}

	two:
		alpha = alpha->link;
		if(alpha == NULL){
			if(IsEmptyStack(&S)){
				return;
			}else{
				StackElemType a;
				POP(&S, &a);
				alpha = a.generalizedListNode;
				goto two;
			}
		}
	}
}

// Driver program to test above functions
int main()
{
	GeneralizedListNode *L;
	L = readInput();
	traversePureList(L);
    return 0;
}