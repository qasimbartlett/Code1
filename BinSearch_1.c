#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h> 



int BinSearch_FindFirstLast(int Arr[], int Pat, bool First)
{

	int Start, End, mid, mid_val, result_index  ;
    result_index = -1 ;
	
	while (Start <= End) {

		mid = (int) (Start + End ) / 2 ;	
		mid_val = Arr[mid] ;

		if (Pat == mid_val) { 
		
			result_index = mid ; 
			
			if (First) { End = mid - 1; }  // Keep searching in left side 
			else       { Start = mid+1; }  // Keep searching in right side 
		}
		
		else if (Pat < mid_val) { End   = mid-1; } 
		
		else  { Start = mid+1; } 
	}
	return result_index ;
}


int BinSearch(int Arr[], int Pat)
{

	int Start, End, mid, mid_val  ;

	while (Start <= End) {

		mid = (int) (Start + End ) / 2 ;	
		mid_val = Arr[mid] ;

		if      (Pat == mid_val) { return mid ; }
		else if (Pat > mid_val) { Start = mid+1; } 
		else if (Pat < mid_val) { End   = mid-1; } 
	}
	return -1 ;



}




void main () {

	int Array[] = {2,4,4,4,4,4,6,8,10,12,14};
	int pos ;

	printf ("Enter the # to be searched\n");
	int Pattern ;
	scanf("%d",&Pattern);

	int FirstIndex, lastIndex ;
	printf("Idrees find the FIrst occurqance\n");
	FirstIndex = BinSearch_FindFirstLast(Array,Pattern,true);
	
	printf("Idrees Find the last occurance\n");
	lastIndex  = BinSearch_FindFirstLast(Array,Pattern,false);
	// pos = BinSearch(Array,Pattern) ;
	printf ("\n\nIdrees found Pattern=%d=  at posotion=%d %d=\n",Pattern,FirstIndex,lastIndex) ;
}


