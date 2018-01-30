#include <stdio.h>
#include <stdlib.h>

// Use Kadane's algoriths
// FInd the segment that gives max sum


int Array[] = {-2,-3,4,-1,-2,1,5,-3};


void main()
{

	int size_of_prior_array, sum_of_prior_array, i, size ;
	int global_sum, global_end_index, global_size;
	
	
	size = sizeof(Array)/sizeof(int);
	
	sum_of_prior_array = Array[0];
	size_of_prior_array = 1;
	
	global_sum = sum_of_prior_array;
	global_end_index = 1;
	global_size = 1;
	
	for (i=1;i<size;i++) {
		
		if (sum_of_prior_array + Array[i] > Array[i]) {
			sum_of_prior_array += Array[i];
			size_of_prior_array++;
			
			if (sum_of_prior_array > global_sum) {
				global_sum = sum_of_prior_array;
				global_end_index = i ;
				global_size = size_of_prior_array ;
			}

		}
		else {
			sum_of_prior_array = Array[i];
			size_of_prior_array = 1;
		}
		
	}

	
	printf ("Idrees global_sum=%d= global_end_index=%d= global_size=%d=\n",global_sum,global_end_index, global_size);


}