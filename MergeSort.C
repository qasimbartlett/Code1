#include <stdio.h>
#include <stdlib.h>


void  MergeSort(int X[], int) ;





void  MergeSort(int Array[], int size)
{


	int mid = (int) (size / 2) ;

	printf("MergeSort size=%d= mid=%d=\n", size, mid) ;


	if (size < 2) { return ; } 

        //Create Left and Right arrays 
	int *Left  = (int *) malloc (size * sizeof(int)) ;
	int *Right = (int *) malloc (size * sizeof(int)) ;


	printf("Left = ") ;
	for (int i =0; i<mid; i++)      { Left[i]  = Array[i]; printf ("%d ",Left[i]); }
	
	printf("\nRight = ");
	for (int i =0; i<size-mid; i++) { Right[i] = Array[i+mid];printf ("%d ",Right[i]);  }
	printf("\n");


	MergeSort(Left,  mid);
	MergeSort(Right, size-mid);



	int L, R, i;
    	L=R=i=0;

	printf ("About to merge; tot_size=%d= L_size=%d= L=",size, mid);
	for (int i =0; i<mid; i++)      { printf ("%d ",Left[i]); }   printf("       R_size=%d=  R=",size-mid); 
	for (int i =0; i<size-mid; i++) { printf ("%d ",Right[i]);  } printf("\n");


	//Merge the 2 piles
	for (i=0;i<size;i++) {
		printf ("i=%d= L=%d= R=%d= mid=%d=  size=%d=\n",i,L,R,mid,size);
		
		if (L >= mid)  {  Array[i] = Right[R++]; } 
	
		else if (R >=  size-mid) { Array[i] =  Left[L++]; }

		else {
			//Left > Right
			if (Left[L] > Right[R]) { Array[i] = Right[R++];} 
			else                    { Array[i] = Left [L++];} 
		}
	}

	printf("After Merge; Merge array = ") ;
	for (int i =0; i<size; i++)      { printf ("%d ",Array[i]); }
	printf("\n\n");


	free(Left);
	free(Right);

	return ;


}





main ()
{

	int xArray[] =  {7,4,2,1,9,0,2} ;

	int xsize = (int) (sizeof(xArray)/sizeof(int))  ;
	MergeSort(xArray, xsize);


	printf ("Idrees sorted array is ");
	for (int i=0;i<xsize;i++) { printf ("%d ",xArray[i]) ; }
	printf ("\n\n");


}




