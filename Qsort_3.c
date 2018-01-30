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



int Partition(int P_StIndx, int P_EndIndx)
{
	
	int i, pivotVal, PivotIndex, temp;
	
	pivotVal = Array[P_EndIndx];
	
	i=P_StIndx;
	PivotIndex = i ;
	
	printf ("1. Partition: StIndx=%d= EndInd=%d= pivotVal=%d=\n", i,P_EndIndx,pivotVal);
	PrintArray();
	
	for (i=P_StIndx;i<P_EndIndx;i++) {
		
		if (Array[i] < pivotVal) {
			temp = Array[i];
			Array[i] = Array[PivotIndex];
			Array[PivotIndex] = temp ;
			PivotIndex++;
		}
		
	}
	
	temp = Array[PivotIndex] ;
	Array[PivotIndex] = pivotVal ;
	Array[P_EndIndx]= temp;
	
	PrintArray();
	printf ("2. Partition: PvoitIndex=%d=\n\n", PivotIndex);
	
	return PivotIndex ;
}



void Qsort(int St, int Ed)
{
	
	int Pind, StIndex, EndIndex ;
	
	StIndex = St ;
	EndIndex = Ed ;
	
	count++;
	if (count > 103) { exit(1);}
	
	
	if (EndIndex <= StIndex) { return;}
	
	Pind = Partition (StIndex, EndIndex);
	Qsort            (StIndex, Pind-1);
	Qsort            (Pind+1,  EndIndex);
	
	
}







void main()
{

	int SIndex, EInxdex;
	
	EInxdex = sizeof (Array) / sizeof (int) -1 ;
	printf ("Idrees in main; EiIndex=%d=\n\n", EInxdex);
	
	PrintArray();
	Qsort(0, EInxdex) ;
	// PrintArray;

}
