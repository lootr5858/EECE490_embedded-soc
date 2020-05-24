#ifdef CORTEX_M0
#include "CMSDK_CM0.h"
#include "core_cm0.h"
#endif

#ifdef CORTEX_M0PLUS
#include "CMSDK_CM0plus.h"
#include "core_cm0plus.h"
#endif

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
	int * number1 = (int*) 0x20010000;
	int * number2 = (int*) 0x20010004;
	
	*number1 = 0xf0f0f0f0;
	*number2 = 0xf0f0f0f0;
	
	return 0;
}
