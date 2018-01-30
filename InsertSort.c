#include <stdio.h>
#include <stdlib.h>

int Array[] = {51,15,88,34,44,19,12,85,91,19,83};
int size ;


void PrintArray()
{
	int i ;
    for (i=0;i<size;i++) { printf ("%d ",Array[i]);}
	printf("\n");

}


void main()
{

	size = sizeof(Array) / sizeof(int) ;
	
	int PulledCardIndex, PulledCardVal, i; 
	

	
	PrintArray();
	
	for (PulledCardIndex=0;PulledCardIndex < size;PulledCardIndex++) {
		
		PulledCardVal = Array[PulledCardIndex];
		printf ("\n\nPulledCardIndex=%d= PulledCardVal=%d=\n",PulledCardIndex, PulledCardVal);
		PrintArray() ;
		
		for (i=PulledCardIndex-1;i >=0;i--) {	
			// printf ("1. i=%d= i_val=%d= PulledCardIndex=%d= PulledCardVal=%d=\n",i,Array[i],PulledCardIndex, PulledCardVal);
			// PrintArray() ;
			if (Array[i] > PulledCardVal) { Array[i+1] = Array[i];}
			else                     { break ;}
		}
		printf ("2. i=%d= i_val=%d= PulledCardIndex=%d= PulledCardVal=%d=\n",i,Array[i],PulledCardIndex, PulledCardVal);
		Array[i+1] = PulledCardVal;
		PrintArray() ;
		
		if (PulledCardIndex > 20) { exit (1);}

	}
	
	PrintArray();
	

}