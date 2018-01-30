#include <stdio.h>
#include <stdlib.h>


// linked list and a value k, give the kth element from the last


struct Node {
	int data;
	struct Node *next ;
};




void main()
{
	
		struct Node *Start, *temp_node ;
		
		Start = (struct Node *) malloc (sizeof(struct Node));
		Start->data = 10;
		Start->next = NULL;
		
		Start->next = (struct Node *) malloc (sizeof(struct Node)) ;		
		Start->next->next = (struct Node *) malloc (sizeof(struct Node)) ;
		Start->next->next->next = (struct Node *) malloc (sizeof(struct Node)) ;
		Start->next->next->next->next = (struct Node *) malloc (sizeof(struct Node)) ;
		Start->next->next->next->next->next = (struct Node *) malloc (sizeof(struct Node)) ;
		Start->next->next->next->next->next->next = (struct Node *) malloc (sizeof(struct Node)) ;
		
		Start->next->next->next->next->next->next->next = NULL ;

		Start->next->data = 230 ;
		Start->next->next->data = 2440 ;
		Start->next->next->next->data = 330 ;
		Start->next->next->next->next->data = 40 ;
		Start->next->next->next->next->next->data = 30 ;
		Start->next->next->next->next->next->next->data = 20 ;
		
		// Find the length
		int i =0;
		
		temp_node = Start;
		
		while (temp_node != NULL){
			i++;
			temp_node = temp_node->next;
		}
		

		
		
		printf("Idrees in main: Size of linked list = %d=\n",i);
		
		// 5th from last 
		
	
}