
#include "CMSDK_CM0.h"
#include "core_cm0.h"

#include <stdio.h>
#include "Uart_API.h"

void Uart0_Init(int Baud_div, int Ctrl)
{
  UART0->BAUDDIV =Baud_div ;
  UART0->CTRL    = Ctrl; // High speed test mode, TX only
}

void Uart1_Init(int Baud_div, int Ctrl)
{
  UART1->BAUDDIV =Baud_div ;
  UART1->CTRL    = Ctrl; // High speed test mode, TX only
}

void Uart2_Init(int Baud_div, int Ctrl)
{
  UART2->BAUDDIV =Baud_div ;
  UART2->CTRL    = Ctrl; // High speed test mode, TX only
}

void Uart0_DataTX(int Data)
{
	while(UART0->STATE&1) ;
	UART0->DATA = Data;
}

void Uart1_DataTX(int Data)
{
	while(UART1->STATE&1) ;
	UART1->DATA = Data;
}

void Uart2_DataTX(int Data)
{
	while(UART2->STATE&1) ;
	UART2->DATA = Data;
}
