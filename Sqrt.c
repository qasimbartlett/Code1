#include <stdio.h>
#include <stdlib.h>

int InNum ;
int Count ;

void main()
{

	
	
	printf ("Idrees enter a Number ");
	scanf("%d",&InNum) ;
	
	printf ("Idrees about to find the sqrt of %d\n", InNum) ;

	int ret = FindSqrt (InNum);
	printf ("Closest num is %d=\n",ret) ;
	
	
}

// 25 ; 12; 6; 3; 


int FindSqrt (int InX)
{
	int midPoint = (int) (InX / 2 ) ;
	int midPointSqr = midPoint * midPoint ;
	Count++;
	int i, ret ;
	
	
	printf("FindSqrt; Inx=%d= midPoint=%d= midPointSqr=%d=\n", InX, midPoint,midPointSqr);
	
	if (Count > 16) { exit (1) ;}
	
	if   (midPointSqr  == InNum) { return midPoint ;}
	if   (midPointSqr > InNum)   { return FindSqrt(midPoint);}
	else {
		ret = -1 ;
		for (i=midPoint;i<=InX;i++) {
			printf("FindSqrt; Inx=%d= i=%d= \n", InX, i);
			if (i*i == InNum) { ret = i;break;}
		}
		printf("FindSqrt; Inx=%d= midPoint=%d= midPointSqr=%d=\n", InX, midPoint,midPointSqr);
		return ret ;
	}
	
}

