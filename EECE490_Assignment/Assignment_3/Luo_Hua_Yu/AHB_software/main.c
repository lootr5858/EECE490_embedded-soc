#include "CMSDK_CM0.h"
#include "core_cm0.h"

#define CMSDK_COUNTER0_BASE 0x20010000

typedef struct
{
  __IO   int  CNT;         /*!< Offset: 0x00 Counter Number Register (R/W) */
  __IO   int  ARR;         /*!< Offset: 0x04 AutoReload 		Register (R/W) */
  __IO   int  ONOFF;       /*!< Offset: 0x08 Switch 				Register (R/W) */
	__IO   int  OVERFLOW;    /*!< Offset: 0x0C Status 				Register (R) 	 */
}COUNTER_TypeDef;

#define COUNTER0 ((COUNTER_TypeDef	*) CMSDK_COUNTER0_BASE	)

int main()
{
	int i=0;
	int cnt_read;
	
	COUNTER0->ARR		=	1024;	// Upper counter value
	COUNTER0->CNT		=	0;
	COUNTER0->ONOFF	=	1;

	// counting algo
	while(i<20)
		i++;
	
	
	
	COUNTER0->ONOFF	=	0;
	//if(((COUNTER0->OVERFLOW)&1)==0) some unsolved flaw in this sentence
		cnt_read=COUNTER0->CNT;
	return 0;
}
