#include <stdio.h>
#include <stdlib.h>


// Quick sort.

int Array[] = {47,	56,	31,	41,	22,	17,	63,	49,	97,	46,	86,	85,	40,	22,	53,	6,	33,	68,	59,	36};
int Size ;

void PrintArray()
{
	
	int i;
	
	Size = sizeof (Array) / sizeof(int) ;
	
	for (i=0;i<Size;i++) {
		printf ("%d ",Array[i]); 
	}
	printf("\n\n");
	
}

int  Partition(int StartIndex, int EndIndex)
{

	int i, PivotVal, PivotInsertionIndx, temp ;
	
	PivotVal = Array[EndIndex];
	
	PivotInsertionIndx = StartIndex;
	
	for (i=StartIndex;i<=EndIndex-1;i++) {
			if (Array[i] < PivotVal) {
				
				// swap
				temp = Array[PivotInsertionIndx] ;
				Array[PivotInsertionIndx] = Array[i];
				Array[i] = temp ;
				
				// increment
				PivotInsertionIndx++;
			}
			
	}
	
	// swap with end index
	temp = Array[PivotInsertionIndx];
	Array[PivotInsertionIndx] = Array[EndIndex] ;
	Array[EndIndex] = temp;

	
	return PivotInsertionIndx ;
	
	
} 


void QuickSort(int QStartIndex, int QEndIndex)
{
	int pivotIndex ;
	


	if (QEndIndex > QStartIndex) {
		pivotIndex = Partition( QStartIndex, QEndIndex);
		QuickSort(QStartIndex,pivotIndex-1);
		QuickSort(pivotIndex+1, QEndIndex);
	}
	


}



void main()
{
	
	
	PrintArray();
printf("Idrees Size=%d=\n",Size);

	QuickSort(0,Size-1);
	
	PrintArray();
	
}