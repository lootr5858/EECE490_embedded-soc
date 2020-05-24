/*	----------------------------------------------------
		         !!!!! ISA Dependencies here !!!!!
		---------------------------------------------------- */
#ifdef		CORTEX_M0
	#include	"CMSDK_CM0.h"
	#include	"core_cm0.h"
#endif

#ifdef		CORTEX_M0PLUS
	#include	"CMSDK_CM0PLUS.h"
	#include	"core_cm0plus.h"
#endif
/*	----------------------------------------------------
		       !!!!! End of ISA Dependencies !!!!!
		---------------------------------------------------- */


/*	----------------------------------------------------
		          !!!!! C Dependencies here !!!!!
		---------------------------------------------------- */
#include <stdio.h>
#include <stdlib.h>
#include "uart_stdout.h"
/*	----------------------------------------------------
		        !!!!! End of C Dependencies !!!!!
		---------------------------------------------------- */

/*	----------------------------------------------------
		          !!!!! Main Compute here !!!!!
		---------------------------------------------------- */
void Sort (unsigned char *data, int length);

int main(void)
{
	int i;
	unsigned char *arr = (unsigned char *) 0x20000000;	// Sort Address in RAM
	
	// Generate an array of random values for sorting
	for (i = 0; i < 10; i++)
	{
		arr[i] = rand() % 50;
	}
	
	// Initiate sorting operation
	Sort (arr, 10);
	
	return 0;
}
/*	----------------------------------------------------
		      !!!!! End of Main Computations !!!!!
		---------------------------------------------------- */


/*	----------------------------------------------------
		     !!!!! Bubble Sorting Operations here !!!!!
		---------------------------------------------------- */
void Sort (unsigned char *data, int length)
{
	int i;
	int j;
	
	int temp;
	
	for (i = 0; i < length - 1; i++)
	{
		for (j = 0; j < length - i -  1; j++)
		{
			// swapping operations
			temp		= data[j];
			data[j]		= data[j+1];
			data[j + 1] = temp;
		}
	}
}
/*	----------------------------------------------------
		        !!!!! End of Bubble Sorting !!!!!
		---------------------------------------------------- */
