

#include <stdio.h>
#include <stdlib.h>


// Assume an array on N integers
// Search 0 .. N; find minimum;  let it be at inde=i
// swap Array[i] <-> Attay[0]
// Now repeat starting at 1..N



int Array[] = {6,5,3,8,33,85,12,8,2,5,12,4};

void PrintArray()
{
	
	int k ;
	printf("Array = ");
	for (k=0;k<sizeof(Array)/sizeof(int);k++) {
		printf ("%d ",Array[k]);
	}
	printf("\n");
}


void main()
{
printf ("Idrees ow ar you\n\n");	

int i, j, index_Lowest, temp ;

	for (i=0;i<sizeof(Array)/sizeof(int);i++) {
	
		index_Lowest = i ;
		for (j=i;j<sizeof(Array)/sizeof(int);j++) {
			if (Array[j] < Array[index_Lowest]) { index_Lowest = j ;}
		}
	
		// swap
		temp = Array[i];
		Array[i] = Array[index_Lowest];
		Array[index_Lowest] = temp ;
	
		PrintArray() ;
	}	



}