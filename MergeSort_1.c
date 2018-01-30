#include <stdio.h>
#include <stdlib.h>


int Array[] = {51,15,88,34,44,19,12,85,91,19,83};
int count = 0 ;

void PrintArray()
{
	
	int i, size ;
	
	size = sizeof (Array) / sizeof (int) ;
	
	printf("Array = ");
	for (i=0;i<size;i++) {
		printf("%d ",Array[i]);
		
	}
	printf("\n");
	
}



void MergeSort(int *InArray, int size)
{
	int *Left, *Right, mid, L, R, i;
	
	mid = (int) size  / 2 ;
	
	count++ ;
	
	if (count > 36) { exit(1);}
	
	printf("\n\nMergeSort:: size=%d=  mid=%d=; Array = ",size, mid);
	for (i=0;i<size;i++) {printf ("%d ",InArray[i]);} printf("\n");
	
	
	if (size < 2 ) { return;}

	
	
	Left  = (int *) malloc (size * sizeof(int)) ;
	Right = (int *) malloc (size * sizeof (int));
	for (i=0;i<mid;i++)      { Left[i]   = InArray[i];}
	for (i=0;i<size-mid;i++) { Right[i]  = InArray[mid+i];}
	
	
	
	MergeSort(Left,mid);
	MergeSort(Right,size-mid);
	
	// Merge Left and right
	L=0; R=0;i=0;
	
	for (i=0;i<size;i++) {
		// If left and right are NOT empty
		if ((L<mid) && ( R < size-mid)) {
			if (Left[L] < Right[R]) { InArray[i] = Left[L++];}
			else                    { InArray[i] = Right[R++];}
		}
		// either Left or Righgt is empty 
		else {
			// if left is empty; Take all remaining from right
			if (L >= mid)           { InArray[i] = Right[R++]; } 			
			// else take all elements  from Left
			else if (R >= size-mid)  { InArray[i] = Left[L++];	}
		}
	}

	
	
	
	// De alloc space
	
	free(Left);
	free(Right);
	
	
	
}



void main()
{

	int sizeX;
	
	sizeX = sizeof(Array) / sizeof (int);
	
	PrintArray();
	
	MergeSort(Array,sizeX);
	 PrintArray();


}