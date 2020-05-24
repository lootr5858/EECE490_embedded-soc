#include "CMSDK_CM0.h"
#include "core_cm0.h"
#include <stdio.h>
#include "uart.h"

void UART_Init(UART_TypeDef* UARTx,int Baud_div)
{
	int temp;
	temp	=	(UARTx==UART0)*0x3	+	(UARTx==UART1)*0xc	+	(UARTx==UART2)*0x30;
	CMSDK_GPIO1->ALTFUNCSET	|=	temp;//set alternative function for GPIO
	UARTx->BAUDDIV	=	Baud_div;
}

void UART_SendData(UART_TypeDef* UARTx,int Data)
{
	UARTx->CTRL=0x1;//Because ctrl can not be read in my design, so CTRL can not be on the right side of '='
	UARTx->DATA=Data;
}

void UART_Endecoder(UART_TypeDef* UARTx,int State)
{
		//*(UART0_Endecoder)=0x1;
	unsigned int* UARTx_Endecoder	=	(unsigned int*)UARTx + 0x14UL; //UARTx Endecoder switch
	if(State==SET)
		*UARTx_Endecoder	=	SET;
	else if(State==RESET)
		*UARTx_Endecoder	=	RESET;
}

int UART_RecData(UART_TypeDef* UARTx,int* Data)
{
	int cnt=0;//time out count
	int time_out=1;
	while(cnt!=1000)
	{
		if(((UARTx->STATE)&(1<<5))==0)//not empty
		{
			UARTx->CTRL=0x2;//reading rx data enable
			*Data	= UARTx->DATA;
			time_out=0;
			break;
		}
		cnt++;
		//delay_us();
	}
	return time_out;
}
