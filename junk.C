#include <stdio.h>

# Merge 2 arrays

int  A[]   = {1,2,3} ;
int  B[10] = {5,6,7,8} ;


main() 
{


	int k = 0 ;
	
	for (int i=0;i< sizeof(B)/sizeof(int); i++) {
		
		if (B[i] == NULL) {   B[i] = A[k++] ; }

		printf ("Idrees i=%d= val=%d=\n",i, B[i]) ;
	}



}

