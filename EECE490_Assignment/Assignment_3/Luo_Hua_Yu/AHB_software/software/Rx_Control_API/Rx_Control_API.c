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

// 0x08 RW    CTRL[3:0]   TxIntEn, RxIntEn, TxEn, RxEn
//              [6] High speed test mode Enable
//              [5] RX overrun interrupt enable
//              [4] TX overrun interrupt enable
//              [3] RX Interrupt Enable
//              [2] TX Interrupt Enable
//              [1] RX Enable
//              [0] TX Enabl

void Uart2_Init(int Baud_div, int Ctrl);
void Uart0_Init(int Baud_div, int Ctrl);
void Uart2_DataTX(int Data);
void Uart0_DataRX(int *Data);
void Uart0_DataTX(int Data);
void Uart1_Init(int Baud_div, int Ctrl);
void Uart1_DataRX(int *Data);
void Uart1_DataTX(int Data);


int main (void)
{
	int data = 0x54;
	int div = 16;
	int TX_Ctrl = 0x01;
	int RX_Ctrl = 0x02;
	int Rx = 0;
	
	CMSDK_GPIO1->ALTFUNCSET = 0x0000003F;
	
	
	Uart0_Init(div, RX_Ctrl);
	Uart1_Init(div, TX_Ctrl);
	Uart2_Init(div, TX_Ctrl);

	Uart1_DataTX(data);
	Uart0_DataRX(&Rx);
	Uart2_DataTX(Rx);

	return 0;
	
	
}
