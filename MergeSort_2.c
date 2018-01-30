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


MergeSort(int *InArray, int size_in)
{
	int L, R, i, mid, *left, *right ;
	
	if (size_in > 1) {
		
		mid = size_in / 2;
		
		left   = (int *) malloc (size_in * sizeof(int)) ;
		right  = (int *) malloc (size_in * sizeof(int)) ;
		
		for (i=0;i<mid;i++)         {left[i]  = InArray[i];}
		for (i=0;i<size_in-mid;i++) {right[i] = InArray[mid+i];}
		
		MergeSort(left,mid);
		MergeSort(right,size_in-mid);
		
		// Merge left and right
		L=0; R=0;
		for (i=0;i<size_in;i++) {
			
			// Compare left and right only if they are not empty
			if ((L < mid) && (R < size_in - mid)) { 
				// left is lower
				if (left[L] < right[R]) { InArray[i] = left[L++];}
				else                    { InArray[i] = right[R++];}
			}
			// if left is empty; pick all from tight
			else if (L < mid) { InArray[i] = left[L++];	 }
			else              { InArray[i] = right[R++]; }
		}
		
		
		
		free(left);
		free(right);
	
	}

}

void main()
{

	int size;
	
	PrintArray();

	size = sizeof(InArray) / sizeof(int);
	
	MergeSort(InArray,size);
	
	PrintArray();
	
	
}