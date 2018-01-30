#include <stdio.h>
#include <stdlib.h>



// C recursive function to solve tower of hanoi puzzle
void MoveTower(int n, char fromrod, char torod, char auxrod)
{

	printf("\n MoveTower:: n=%d= %c --> %c \n",n,fromrod, torod);
	
    if (n == 1)
    {
        // printf("\n Move disk 1 from rod %c to rod %c", fromrod, torod);
		printf("\n MoveTower:: %c -----> %c", fromrod, torod);
        return;
    }
    MoveTower(n-1, fromrod, auxrod, torod);
	MoveTower(1,   fromrod, torod,	auxrod);
    MoveTower(n-1, auxrod,  torod, 	fromrod);
}
 
int main()
{
    int n = 4; // Number of disks
    MoveTower(n, 'A', 'C', 'B');  // A, B and C are names of rods
    return 0;
}

 
 
