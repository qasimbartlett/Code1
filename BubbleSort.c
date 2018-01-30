#include <stdio.h>
#include <stdlib.h>


int Array [] = {70, 64 ,2 ,10, 25, 75, 69, 79, 22, 34};

void PrintNumbers()
{
	int i ;
	
	printf ("Numbers = ");
	for (i=0;i<sizeof(Array)/sizeof(int);i++) {
		printf("%d ", Array[i]);
	}
	printf("\n");

}



void main()
{

	PrintNumbers();
	
	int i, j , ArraySize, IndexOfMax, temp;
	
	ArraySize = sizeof(Array) / sizeof(int);
	
	
	for (i=ArraySize-1;i>=0;i--){
		
		IndexOfMax = i ;
		// Find the max
		for (j=i;j>=0;j--) {
			if (Array[j] > Array[IndexOfMax]) {
				IndexOfMax = j ;
			}			
		}
		
		// swap
		
		temp = Array[i];
		Array[i] = Array[IndexOfMax];
		Array[IndexOfMax] = temp ;
		PrintNumbers() ;
		
		
		
	}


}