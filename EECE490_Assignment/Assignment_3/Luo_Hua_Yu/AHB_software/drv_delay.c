/*
 ***************************************************************************************
 * @brief        : Precise timing delay with a Cortex M0/M3 kernel's system tick timer.
 * @author       : lyw
 * @copyright    : 
 * @version      : V1.0
 * @note         : During the time delay, CPU can't do anything else.
 * @history      : 2018.06.12
 ****************************************************************************************
 */

#include "drv_delay.h"
#include "CMSDK_CM0.h"
#include "core_cm0.h"


#define FAC_US	(50)        // FAC_US = System tick clock frequency / 1000000
#define FAC_MS	(50000)     // FAC_MS = System tick clock frequency / 1000
#define SYSTICK_DELAY_US_MAX    (335544)    // 0 < SYSTICK_DELAY_US_MAX < (16777215/FAC_US)
#define SYSTICK_DELAY_MS_MAX    (335)       // 0 < SYSTICK_DELAY_MS_MAX < (16777215/FAC_MS)


// System Tick Configuration
void SysTickInit(void)
{
    SysTick->CTRL &= (~SysTick_CTRL_TICKINT_Msk);   // Disable interruption.
    SysTick->CTRL |= SysTick_CTRL_CLKSOURCE_Msk;    // Clock source = CPU Clock.
}

// nus < SYSTICK_DELAY_US_MAX
// nus 最好大于10，nus越小误差越大。
static void SysTick_DelayUs(unsigned int nus)
{
    unsigned int temp;

    SysTick->LOAD = nus*FAC_US;
    SysTick->VAL  = 0;
    SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk;

    do
    {
        temp = SysTick->CTRL;
    }
    while((temp & SysTick_CTRL_ENABLE_Msk) && !(temp & SysTick_CTRL_COUNTFLAG_Msk));

    SysTick->CTRL &= ~SysTick_CTRL_ENABLE_Msk;
    SysTick->VAL   = 0;
}

// nms < SYSTICK_DELAY_MS_MAX
static void SysTick_DelayMs(unsigned int nms)
{
    unsigned int temp;

    SysTick->LOAD = nms*FAC_MS;
    SysTick->VAL  = 0;
    SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk;

    do
    {
        temp = SysTick->CTRL;
    }
    while((temp & SysTick_CTRL_ENABLE_Msk) && !(temp & SysTick_CTRL_COUNTFLAG_Msk));

    SysTick->CTRL &= ~SysTick_CTRL_ENABLE_Msk;
    SysTick->VAL   = 0;
}

// Microsecond(us) level delay program
void DelayUs(unsigned int nus)
{
    unsigned int i = 0;
    unsigned int integer = 0;
    unsigned int remainder = 0;

    if(nus > SYSTICK_DELAY_US_MAX)
    {
        integer = nus/SYSTICK_DELAY_US_MAX;
        remainder = nus%SYSTICK_DELAY_US_MAX;

        for(i = 0; i < integer; i++)
        {
            SysTick_DelayUs(SYSTICK_DELAY_US_MAX);
        }

        if(remainder > 0)
        {
            SysTick_DelayUs(remainder);
        }
    }
    else
    {
        SysTick_DelayUs(nus);
    }
}

// Millisecond(ms) level delay program
void DelayMs(unsigned int nms)
{
    unsigned int i = 0;
    unsigned int integer = 0;
    unsigned int remainder = 0;

    if(nms > SYSTICK_DELAY_MS_MAX)
    {
        integer = nms/SYSTICK_DELAY_MS_MAX;
        remainder = nms%SYSTICK_DELAY_MS_MAX;

        for(i = 0; i < integer; i++)
        {
            SysTick_DelayMs(SYSTICK_DELAY_MS_MAX);
        }

        if(remainder > 0)
        {
            SysTick_DelayMs(remainder);
        }
    }
    else
    {
        SysTick_DelayMs(nms);
    }
}

