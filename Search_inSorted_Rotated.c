#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


// Given a sorted list thats rotated N times, find a number in it.
// Challenge:   Since the list has been rotated the #s are not in an increasing order.
//              some portion of the list in in increasing order and another portion NOT
//              int Array[] = { 12,   14,  16,  0,      1,2,4,6,8,10} ;
//                              <--0 beaks the sort --> <-- Sorted-->
//         
// Solutin:   Let Number to be fiund is CCX
//            find mid;
//            If (mid==X) {return index; }
//            else {
// if 
//				}
// 			   
void main()
{
	
	
	int Array[] = {12,   14,  16,  0,      1,2,4,6,8,10} ;
	
	int Pattern;
	printf ("Idrees enter a numver= ");
	scanf("%d",&Pattern);
	
	int StartIndx, EndIndx, midIndx, mid_val, PatternIndx, iterations ;

	iterations=0;
	PatternIndx = -1 ;
	StartIndx = 0;
	EndIndx   = sizeof(Array) / sizeof(int) -1 ;
	
	while (StartIndx < EndIndx) {
		iterations++;
		midIndx = (int)(StartIndx + EndIndx) / 2 ;
		if (Pattern == Array[midIndx]) { PatternIndx = midIndx; break;} 
		else {
			
			// is left side a sorted array
			if (Array[StartIndx] <= Array[midIndx-1]) {
				// If Pattern in left side then find it in left
				if ((Array[StartIndx] <= Pattern) && (Pattern <= Array[EndIndx])) {
					EndIndx=midIndx-1 ;
				}
				// else find pattern in right side
				else {
					StartIndx = midIndx + 1 ;
				}
			}
			// Right side is sorted 
			else if (Array[midIndx+1] <= Array[EndIndx]) {
				
				// if pattern on Right side
				if ((Array[midIndx+1] <= Pattern) && (Pattern <= Array[EndIndx])) {
					StartIndx = midIndx + 1 ;
				}
				// else find pattern in left
				else {
					EndIndx = midIndx-1 ;
				}
				
			}			
		}
	}
	
	printf("Idrees Pattern=%d=  Found at index=%d=   iterations=%d\n", Pattern, PatternIndx, iterations);
}

