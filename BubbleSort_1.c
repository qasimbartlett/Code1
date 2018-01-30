#include <stdio.h>
#include <stdlib.h>
// peng Li (USA Wireless NFV); david dai


int InArray[] = {3,5,23,8,45,2,67,23,74,27};


void PrintArray()
{
	int i ;
	for (i=0;i < sizeof(InArray)/sizeof(int) ; i++) {
		printf("%d ",InArray[i]);
	}
	printf("\n\n");
	
}



void main()
{
	
	int lowest_index , i, j, k, insert_index, temp;
	
	PrintArray() ;
	
	
	insert_index = 0 ;
	
	for (insert_index=0;insert_index< sizeof(InArray)/sizeof(int); insert_index++) {
		lowest_index = insert_index;
	
		for (i=insert_index;i< sizeof(InArray)/sizeof(int); i++) {
			if (InArray[i] < InArray[lowest_index]) { lowest_index = i;}
		}
		temp = InArray[insert_index];
		InArray[insert_index] = InArray[lowest_index];
		InArray[lowest_index] = temp ;
	}
	
	PrintArray() ;
	
}