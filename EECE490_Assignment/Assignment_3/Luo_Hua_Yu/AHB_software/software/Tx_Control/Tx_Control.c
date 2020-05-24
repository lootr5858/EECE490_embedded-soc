/*
 *-----------------------------------------------------------------------------
 * The confidential and proprietary information contained in this file may
 * only be used by a person authorised under and to the extent permitted
 * by a subsisting licensing agreement from ARM Limited.
 *
 *            (C) COPYRIGHT 2010-2015  ARM Limited or its affiliates.
 *                ALL RIGHTS RESERVED
 *
 * This entire notice must be reproduced on all copies of this file
 * and copies of this file may only be made by a person if such person is
 * permitted to do so under the terms of a subsisting license agreement
 * from ARM Limited.
 *
 *      SVN Information
 *
 *      Checked In          : $Date: 2013-03-27 23:58:01 +0000 (Wed, 27 Mar 2013) $
 *
 *      Revision            : $Revision: 242484 $
 *
 *      Release Information : Cortex-M0 DesignStart-r1p0-00rel0
 *-----------------------------------------------------------------------------
 */

#include "CMSDK_CM0.h"
#include "core_cm0.h"

#include <stdio.h>


int main (void)
{
	
	unsigned int * UART_Data = (unsigned int *) 0x40006000; //UART2 Data Address
	unsigned int * UART_State = (unsigned int *) 0x40006004; //UART2 State Address
	unsigned int * UART_Control = (unsigned int *) 0x40006008; //UAR2 Control Address
	unsigned int * UART_Baud = (unsigned int *) 0x40006010; //UART2 Baud Div Address
	
	int a = 0x54;

	*(UART_Baud) = 16;       //Set up Baud rate(baud div--> 16)
	*(UART_Control) = 0x01; //TX Enable On
	*(UART_Data) = a; 
	
}
