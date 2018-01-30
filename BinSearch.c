#include <stdio.h>
#include <stdlib.h>


int Array[] = {2,4,4,4,4,6,8,10,12,14,16};
int Pattern=11;
int End = sizeof(Array) / sizeof (int)  - 1 ;

void main()
{
	int pos = -1 ;
	pos = Exists (0,End) ;

	printf ("IDrees Pattern = %d= is at position ", Pattern);
	printf ("%d \n", pos );


}




int Exists(int StartIndex, int EndIndex)
{

	if (StartIndex <= EndIndex) {

		int mid_index, mid_val ;

		mid_index = (int) (StartIndex + EndIndex) / 2 ; 
		mid_val   = Array[mid_index];
	
		if (Pattern == mid_val)     { printf ("Returinging mid_index=%d=\n",mid_index); return mid_index; } 
		else if (Pattern < mid_val) { Exists (StartIndex,mid_index-1) ; }
		else if (Pattern > mid_val) { Exists (mid_index+1, EndIndex) ; }
		else                        { return -1  ;                     }

	}
	else  return -1 ;


}




