#include "CMSDK_CM0.h"
#include "core_cm0.h"
static volatile uint32_t TimeTick=0;

void SysTick_Handler(void)
{
	TimeTick++;
}
void delay_ms(uint32_t ms)
{
	SysTick_Config(SystemCoreClock/1000*ms);
	while(!TimeTick);
	TimeTick=0;
	SysTick->CTRL=0;//close the timer
}
