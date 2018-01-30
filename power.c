#include <stdio.h>
#include <stdlib.h>

int count ;

int Pow_log(int a, int b)
{
	
	count++;
	
	int temp ;

	if (count > 90) { exit(1);}
	
    printf("Pow_log:: count=%d= a=%d= b=%d=\n",count,a,b);
	if (b <=  0) {return 1 ;} 
	
	if (b%2 == 0) { temp =    Pow_log(a, (b/2));      return     temp * temp ; }
	else          { temp =    Pow_log(a, ((b-1)/2));  return a * temp * temp ;  }
	

	



}


int Pow_linear(int a, int b)
{
	
	int b1 ;
	
    b1 = b - 1 ;
	count++;

	if (count > 20) { exit(1);}
	
    printf("Pow_liner:: count=%d= a=%d= b=%d= \n",count,a,b);
	if (b == 0) {return 1 ;} 
	
	
	return a * Pow_linear(a, b-1);
	

	



}




main()
{

  int x, n, result ;
  
  x = 2 ;
  n = 10;
  count = 0;
  result = 0 ;
  // result = Pow_linear(x,n);
  result = Pow_log(x,n);
  printf("Idrees %d to power of %d = %d;  Take %d loops\n",x,n,result,count);



}