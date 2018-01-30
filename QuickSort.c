#include <stdio.h>
#include <stdlib.h>



int Array[] = {1,3,5,2,7,33,52,12} ;
int Endd = sizeof(Array)/sizeof(int)-1 ;

void QuickSort (int , int ) ;
int  Partition (int , int )  ;
void SwapContentsAt(int,int ) ;
void PrintArray() ;

void main ()
{
	
	QuickSort(0,Endd);

	PrintArray();

}


void QuickSort (int StartIndx, int EndIndx)
{
	if (StartIndx < EndIndx) {
		//PArition the array
		int Pindex = Partition (StartIndx, EndIndx) ;
		QuickSort (StartIndx, Pindex-1) ;
		QuickSort (Pindex+1,  EndIndx) ;
	}
}


int Partition (int StartIndX, int EndIndX) 
{

	// Let the Pivot be the end
	int Pivot = Array[EndIndX] ;

	int PPindex=StartIndX; 
	int i ;


	for (i=StartIndX;i<=EndIndX-1;i++) {
		if (Array[i] <= Pivot) { SwapContentsAt(i,PPindex); PPindex++ ; }
	}
	SwapContentsAt(PPindex,EndIndX);  

	return PPindex ;
}


void SwapContentsAt(int Pos1, int Pos2)
{
	int temp = Array[Pos1];
	Array[Pos1] = Array[Pos2];
	Array[Pos2] = temp ;	
}


void PrintArray()
{

	int i ;
	printf ("Array = ");
	for (i=0; i<=Endd;i++) { printf("%d ",Array[i]) ; }
	printf ("\n");
}


