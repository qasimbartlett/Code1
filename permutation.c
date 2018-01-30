#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char String[20] = "ABCD";
char Result[20] = "";
int   len, size ;
int count ;


void Swap (int pos1, int pos2)
{
	char c_pos1, c_pos2 ;
	
	c_pos1   = String[pos1];
	c_pos2   = String[pos2];
			
	String[pos1] = c_pos2;
	String[pos2] = c_pos1 ;
			
}





void Permutations (int Index)
{
	
	int i;
	
	
	count++;
	if (count > 54) { exit (1);}
	
	if (Index == len ) { printf ("Permutatioon = %s=\n", String); }

	else {
		for (i=Index;i<len;i++) {
			
			// Swap 
			Swap (Index,i) ;
			
			// Permutations of substring
			Permutations(Index+1);
			
			// undo  swap 
			Swap (Index,i) ;
			
		}
	}
}

void Perm_n_things_taken_k_at_a_time (int Index)
{
	
	int i;
	char temp ;
	
	
	count++;
	if (count > 54) { exit (1);}
	
	if (Index == size ) { 
		if (strstr(Result,"X") != NULL) {}
		else { printf ("Permutatioon = %s=\n", Result); }
	}

	else {
		for (i=0;i<len;i++) {
			
			// Swap 
			
			temp = String[i] ;
			Result[Index] = temp ;
			// String[i] = 'X';
			
			// Permutations of substring
			Perm_n_things_taken_k_at_a_time(Index+1);
			
			// undo  swap 
			String[i] = temp ;
			
		}
	}
}



void main()
{

	len = strlen(String);
    size = 2; 
	
	// Permutations(0);
	Perm_n_things_taken_k_at_a_time(0);
	

}


