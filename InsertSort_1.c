#include <stdio.h>
#include <stdlib.h>


int InArray[] = {3,5,23,8,45,2,67,23,74,27};


void PrintArray()
{
	int i ;
	for (i=0;i < sizeof(InArray)/sizeof(int) ; i++) {
		printf("%d ",InArray[i]);
	}
	printf("\n\n");
	
}


void main()
{
	int i,j,k, PulledOutIndex, PulledCardVal, temp ;
	
	PrintArray();
	
	for (PulledOutIndex=0;PulledOutIndex<sizeof(InArray)/sizeof(int); PulledOutIndex++) { 
		PulledCardVal  = InArray[PulledOutIndex];
		for (i=PulledOutIndex-1;i>=0;i--) {
			// shift right
			if (InArray[i] > PulledCardVal ) { InArray[i+1] = InArray[i];}
			else {	break;	}
		}
		// InArray[PulledOutIndex] = InArray[i];
		InArray[i+1]=PulledCardVal ;
	}
	PrintArray();
}