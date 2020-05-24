#include "CMSDK_CM0.h"
#include "core_cm0.h"

#include <stdio.h>
#include <stdlib.h>

#define CMSDK_COUNTER0_BASE 0x20010000

typedef struct
{
  __IO   int  CNT;         /*!< Offset: 0x00 Counter Number Register (R/W) */
  __IO   int  ARR;         /*!< Offset: 0x04 AutoReload 		Register (R/W) */
  __IO   int  ONOFF;       /*!< Offset: 0x08 Switch 				Register (R/W) */
	__IO   int  OVERFLOW;    /*!< Offset: 0x0C Status 				Register (R) 	 */
}COUNTER_TypeDef;

#define COUNTER0 ((COUNTER_TypeDef	*) CMSDK_COUNTER0_BASE	)
#define dim 3

int main()
{
	// Define memory addresses
	unsigned char *c = (unsigned char *) 0x20000000;
	
	// Define input matrices
	char a[dim][dim] = {{0, 1, 2}, {3, 4, 5}, {6, 7, 8}};
  char b[dim][dim] = {{9, 8, 7}, {6, 5, 4}, {3, 2, 1}};
	
	// Counter variable
	int cnt_read;
	
	// Start counting
	COUNTER0->ARR		=	1024;	// Upper counter value
	COUNTER0->CNT		=	0;
	COUNTER0->ONOFF	=	1;
	
	// Matrix multiplication operations
	for (int i = 0; i < dim; i++)
  {
		for (int j = 0; j < dim; j++)
    {
			c[dim * i + j] = 0;

      for (int k = 0; k < dim; k++)
      {c[dim * i + j] += a[i][k] * b[k][j];}
    }
  }
	
	// Stop counter and record counter value
	COUNTER0->ONOFF	=	0;
	cnt_read=COUNTER0->CNT;
	
	return 0;
}

