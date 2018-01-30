#include <stdio.h>
#include <stdlib.h>



// C recursive function to solve tower of hanoi puzzle
int Mult (int m, int n)
{
	
   printf("Mutl m=%d= n=%d=\n",m,n);

  if (n==1) { return m ;}
   
   return (m + Mult(m,n-1));
	  
 
	  
	  
  
  
}
 
int main()
{
    
    int m, n, res ;
	
	m=5;
	n=6;
	
	res =Mult(m,n) ;
	printf("Idrees res=%d=\n",res);
	
}

 
