#include <stdio.h>
#include <stdlib.h>



// C recursive function to solve tower of hanoi puzzle
int Gcd (int n, int m)
{
	
  printf("Gcd m=%d= n=%d=\n",m,n);

  if (n < m) 					{ return Gcd(m,n);}
  else if ((n>=n) && (n%m == 0)){ return m ;}
  else     						{ return Gcd(m, n%m);}
  
 
	  
  
  
}
 
int main()
{
    
    int m, n, res ;
	
	m=35;
	n=56;
	
	res =Gcd(n,m) ;
	printf("Idrees res=%d=\n",res);
	
}
