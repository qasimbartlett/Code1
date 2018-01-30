#include <stdio.h>
#include <stdlib.h>

int Array[] = {2,4,6,8,10,12,14,16} ;
int SearchPattern ;

// C recursive function to solve tower of hanoi puzzle
int BinSearch (int StartIndx, int EndIndx)
{
	
	int mid_index ;
	
	mid_index = (int) ((StartIndx + EndIndx)/2 ) ;

	printf ("BinSearch:: Starr=%d=  End=%d= mid_index=%d=\n",StartIndx,EndIndx,mid_index);
	
	if (Array[mid_index] == SearchPattern) { return mid_index;}
	
	if (StartIndx < EndIndx) { 
		if (SearchPattern < Array[mid_index]) { BinSearch(StartIndx,mid_index-1);}
		else                                  { BinSearch(mid_index+1,EndIndx);}
	}
	else {
		return -1 ;
	}
  
 
	  
  
  
}
 
int main()
{
    
   
	
	SearchPattern=21;
	
	
	printf("Idrees looking for SearchPattern=%d=   index=%d=\n\n", SearchPattern, BinSearch(0,sizeof(Array)/sizeof(int)) );
	
}
