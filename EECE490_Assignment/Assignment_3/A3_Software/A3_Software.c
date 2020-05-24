/*	----------------------------------------------------
		         !!!!! ISA Dependencies here !!!!!
		---------------------------------------------------- */
//#ifdef		CORTEX_M0
	#include	"CMSDK_CM0.h"
	#include	"core_cm0.h"
//#endif

/*#ifdef		CORTEX_M0PLUS
	#include	"CMSDK_CM0PLUS.h"
	#include	"core_cm0plus.h"
#endif*/
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
		    !!!!! 32 bit Counter Register Map here !!!!!
		---------------------------------------------------- */
#define CMSDK_COUNTER0_BASE 0x20010000

typedef struct
{
  __IO   int  CNT;         /*!< Offset: 0x00 Counter Number Register (R/W) */
  __IO   int  ARR;         /*!< Offset: 0x04 AutoReload 		Register (R/W) */
  __IO   int  ONOFF;       /*!< Offset: 0x08 Switch 				Register (R/W) */
	__IO   int  OVERFLOW;    /*!< Offset: 0x0C Status 				Register (R) 	 */
}COUNTER_TypeDef;

#define COUNTER0 ((COUNTER_TypeDef	*) CMSDK_COUNTER0_BASE	)
/*	----------------------------------------------------
		        !!!!! End of Register Map !!!!!
		---------------------------------------------------- */		


/*	----------------------------------------------------
		          !!!!! Main Compute here !!!!!
		---------------------------------------------------- */
void Sort (unsigned char *data, int length);

int main(void)
{
	// --- Bubble Sorting Reg --- //
	int i;
	unsigned char *arr = (unsigned char *) 0x20000000;	// Sort Address in RAM
	int arr_size = 10;															  // Array Size
	
	
	// --- Counter Reg --- //
	int cnt_read;
	
	// --- Counter Parameters --- //
	COUNTER0->ARR		=	1024;	// Counter Upper Limit Value
	COUNTER0->CNT		=	0;				// Define Initial Counter Value
	COUNTER0->ONOFF	=	1;	  		// Enable Counter Operations
	
	// --- Bubble Sorting Operations --- //
	// - Generate array of random values - //
	for (i = 0; i < arr_size; i++)
	{
		arr[i] = rand() % 50;
	}
	
	Sort (arr, arr_size);
	
	
	// --- Display counter value --- //
	COUNTER0->ONOFF	=	0;
	//if(((COUNTER0->OVERFLOW)&1)==0) some unsolved flaw in this sentence
	cnt_read=COUNTER0->CNT;
	
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
			if (data[j] > data[j+1])
			{
				temp		= data[j];
				data[j]		= data[j+1];
				data[j + 1] = temp;
			}
		}
	}
}
/*	----------------------------------------------------
		        !!!!! End of Bubble Sorting !!!!!
		---------------------------------------------------- */
