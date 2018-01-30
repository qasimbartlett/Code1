#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *InStr = "AbbaBaddaJabba";
char tmp[3]   = "bba";
char *token;


main ()
{

   token = strtok(InStr, tmp);
   
   while (token != NULL) {
	   
	  printf( "%s\n", token );
      token = strtok(NULL, tmp);
	   
   }

	printf ("Idrees Instr=%s=\n", InStr);
	
	printf("Idrees SubStr=%s=\n", strstr(InStr,tmp)) ;


}