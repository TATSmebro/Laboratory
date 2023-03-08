#include <stdio.h>
#include <stdlib.h>
#define newline printf("\n")

void EQUIVALENCE(void);
int NUM_EQUI_CLASSES(void);
void UNION(int, int);
int FIND(int);

// Declare global variables here
int *FATHER; //the global FATHER array
int SIZE; //the global FATHER array size
// Declare global variables here

int main()
{   
    EQUIVALENCE();
    printf("%d", NUM_EQUI_CLASSES());
    
    free (FATHER);
    return 0;
}

void EQUIVALENCE()
{
    int i, j, n;
    
    // get size of S
    scanf("%d\n", &n);
    
    //Initialize FATHER array
    SIZE = n;
    FATHER = malloc(sizeof(int)*SIZE);
    for(int element = 0; element < SIZE; element++){
        FATHER[element] = -1;
    }

    scanf("%d %d\n", &i, &j);
    while(i != 0 && j != 0)
    {
        i = FIND(i);
        j = FIND(j);

        if(i != j){
            UNION(i,j);
        }

        scanf("%d %d\n", &i, &j);
    }
    
    return;
}

int NUM_EQUI_CLASSES()
{
	int numEquiClasses = 0;
	
	for(int i = 0; i < SIZE; i++){
        if(FATHER[i] < 0){
            numEquiClasses++;
        }
    }

	return numEquiClasses;
}

void UNION(int i, int j)
{
    int count = FATHER[i - 1] + FATHER[j - 1];

    if(abs(FATHER[i - 1]) > abs(FATHER[j - 1])){
        FATHER[j - 1] = i;
        FATHER[i - 1] = count;
    }
    else{
        FATHER[i - 1] = j;
        FATHER[j - 1] = count;
    }

    return;
}

int FIND(int i)
{
    //root finding
    int r = i;
    while(FATHER[r - 1] > 0){
        r = FATHER[r - 1];
    }

    //tree compression
    int j = i;
    int k;

    while(j != r){
        k = FATHER[j - 1];
        FATHER[j - 1] = r;
        j = k;
    }
    
    return r;
}