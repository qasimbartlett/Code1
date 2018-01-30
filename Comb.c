#include <stdio.h>
#include <stdlib.h>



// C recursive function to solve tower of hanoi puzzle
int Comb(int n, int r)
{
	
	printf("Comb n=%d= r=%d=\n",n,r);

  if (n==r) { return 1 ; }
  // if (n==1) { return 1;}
  if (r==1) { return n;}
  if (r==0) { return 1;}
   
   return (Comb(n-1,r) + Comb(n-1,r-1));
	  
 
	  
	  
  
  
}
 
int main()
{
    
    int res ;
	
	res = Comb(5,2) ;
	printf("Idrees res=%d=\n",res);
	
}

 
