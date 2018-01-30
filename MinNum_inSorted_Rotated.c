#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>



void main ()
{

	// Given a sorted array that does NOT have duplicated. The array is rotated N times
	int Array[] = { 12, 14, 16, 2,4,6,8,10} ;

	//  The lowest # will be sandwitched between 2 numbers somewhere in the list 


	int size, StartIndx, EndIndx, midIndx, Pattern, mid_val, next_val, prev_val, LeastIndex ;


	size = sizeof (Array) / sizeof (int) ; 
	StartIndx = 0 ;
	EndIndx   = size - 1 ; 
	LeastIndex = -1 ;

	while (StartIndx < EndIndx) {
		midIndx = (int) (StartIndx + EndIndx) / 2 ;
		mid_val = Array[midIndx];
		next_val = Array[(midIndx+1)% size];
		prev_val = Array[(size+midIndx-1)%size];
		
		
		// Case 1; Array already sorted; So StartIndx is least
		if (Array[StartIndx] < Array[EndIndx]) { LeastIndex = StartIndx ; break;}
		else if ((mid_val <= next_val) && (mid_val <= prev_val)) { LeastIndex =  midIndx; break;}
		else if (mid_val < Array[EndIndx]) {
			// Right side is already sorted in increasing order. So lowest must be in left side
			EndIndx = midIndx - 1 ;
		}
		else if (mid_val > Array[StartIndx]) {
			// Left side is increasing order; So lowest must be in right soide
			StartIndx = midIndx + 1 ;	
		}
	}
	
	printf ("Idrees LEasr Index=%d=\n", LeastIndex) ;

}


// 35 + 45 + 25 = 135 ;