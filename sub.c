#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

char *InStr = "Immediately";
char *subst = "dixat";




void main()
{

    int i, j, sizeA, sizeB;
	bool result, FirstCharMatched ;
	
	
	sizeA = sizeof(InStr);
	sizeB = sizeof(subst);
	
	result = true ;
	FirstCharMatched = false ;
	printf("0. Idrees result=%d= FirstCharMatched=%d= \n", result,FirstCharMatched);
	
	i=0;j=0;
	for (i=0;i<sizeA;i++){
		
		if (j > sizeB) { break ;}
		
		if (InStr[i] == subst[j]) {	
			if (FirstCharMatched) 	{}
			else 					{FirstCharMatched = true ;}
		}
		
		if (FirstCharMatched) {
			if (InStr[i] != subst[j]) { result = false ; break ; }
			else					  { j++ ;}
		}
	}

	if (FirstCharMatched) {
		printf("1. Idrees found=%d=\n", result);
	}
	else { printf ("2. Idrees result should be false; result var=%d=\n",result);}


}
