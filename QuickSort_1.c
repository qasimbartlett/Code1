#include <stdio.h>
#include <stdlib.h>

int Array[] = {10,2,14,11,6,3,9,1,66,12};
int count ;


void PrintArray()
{
	
	int i, size;
	size = sizeof(Array) / sizeof(int);
	
	for (i=0;i<size;i++) {
		printf("%d ",Array[i]);
	}
	printf("\n\n");
		
}



int Partition(int StInd, int EndInd)
{
	
	int Pindex, Ptr, PivotVal, temp ;
	
	Pindex = 0 ;
	PivotVal = Array[EndInd] ;
	
	printf("\n\n1. Partitn: "); 
	PrintArray();
	
	for (Ptr=0;Ptr < EndInd;Ptr++) {
		if (Array[Ptr] < PivotVal) {
			temp = Array[Ptr];
			Array[Ptr] = Array[Pindex];
			Array[Pindex] = temp ;
			Pindex++;
		}
	printf("2. Partition: StInd=%d= EndInd=%d=Pindex=%d= Ptr=%d= \n",StInd, EndInd,Pindex,Ptr);
    PrintArray();

	}
	
	temp = Array[Pindex];
	Array[Pindex] = PivotVal ;
	Array[EndInd] = temp ;
	printf("3. Partition: StInd=%d= EndInd=%d=Pindex=%d= Ptr=%d= \n",StInd, EndInd,Pindex,Ptr);
	PrintArray();
	
	return Pindex;
	
}






int QuickSort(int StIndx, int EndIndx)
{
	int PivotIndex,StartIndex, EndIndex;

	StartIndex = StIndx ;
	EndIndex   = EndIndx ;
	count++ ;
	
	if (count > 5) { exit (1);}
	printf("QuickSOrt; StInd=%d= EndInd=%d=\n",StartIndex, EndIndx);
	if (StartIndex < EndIndex) { 
	
		PivotIndex = Partition(StartIndex, EndIndex) ;
		// QuickSort Left
		QuickSort(StartIndex,PivotIndex-1);	
		QuickSort(PivotIndex+1,EndIndex);
	}
	

}


void main()
{

	int LastIndex ;
	LastIndex = sizeof(Array) / sizeof(int) -1 ;
	
	count = 0; 
	PrintArray();
	QuickSort(0,LastIndex) ;
	PrintArray();



}