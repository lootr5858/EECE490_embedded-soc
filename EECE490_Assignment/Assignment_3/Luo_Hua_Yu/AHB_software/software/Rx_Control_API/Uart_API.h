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

typedef unsigned int uint;

typedef struct
{
  __IO   uint  DATA;          /*!< Offset: 0x000 Data Register    (R/W) */
  __IO   uint  STATE;         /*!< Offset: 0x004 Status Register  (R/W) */
  __IO   uint  CTRL;          /*!< Offset: 0x008 Control Register (R/W) */
  union intr{
    __I    uint  INTSTATUS;   /*!< Offset: 0x00C Interrupt Status Register (R/ ) */
    __O    uint  INTCLEAR;    /*!< Offset: 0x00C Interrupt Clear Register ( /W) */
    }int_clr_sta;
  __IO   uint  BAUDDIV;       /*!< Offset: 0x010 Baudrate Divider Register (R/W) */
}UART_TypeDef;

void Uart0_Init(int Baud_div, int Ctrl);
void Uart1_Init(int Baud_div, int Ctrl);
void Uart2_Init(int Baud_div, int Ctrl);
void Uart0_DataTX(int Data);
void Uart1_DataTX(int Data);
void Uart2_DataTX(int Data);

#define APB_BASE          (0x40000000UL)
#define UART0_BASE_ADDR  (APB_BASE + 0x4000UL)
#define UART1_BASE_ADDR  (APB_BASE + 0x5000UL)
#define UART2_BASE_ADDR  (APB_BASE + 0x6000UL)
#define UART0 ((UART_TypeDef   *) CMSDK_UART0_BASE   )
#define UART1 ((UART_TypeDef   *) CMSDK_UART1_BASE   )
#define UART2 ((UART_TypeDef   *) CMSDK_UART2_BASE   )
