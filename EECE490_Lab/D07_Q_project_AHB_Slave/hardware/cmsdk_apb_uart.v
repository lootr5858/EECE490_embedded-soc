//------------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2010-2015  ARM Limited or its affiliates.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//  Version and Release Control Information:
//
//  File Revision       : $Revision: 275084 $
//  File Date           : $Date: 2014-03-27 15:09:11 +0000 (Thu, 27 Mar 2014) $
//
//  Release Information : Cortex-M0 DesignStart-r1p0-00rel0
//------------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
// Abstract : Simple APB UART
//------------------------------------------------------------------------------
// Programmer's model
// 0x00 R     RXD[7:0]    Received Data
//      W     TXD[7:0]    Transmit data
// 0x04 RW    STAT[3:0]
//              [3] RX buffer overrun (write 1 to clear)
//              [2] TX buffer overrun (write 1 to clear)
//              [1] RX buffer full (Read only)
//              [0] TX buffer full (Read only)
// 0x08 RW    CTRL[3:0]   TxIntEn, RxIntEn, TxEn, RxEn
//              [6] High speed test mode Enable
//              [5] RX overrun interrupt enable
//              [4] TX overrun interrupt enable
//              [3] RX Interrupt Enable
//              [2] TX Interrupt Enable
//              [1] RX Enable
//              [0] TX Enable
// 0x0C R/Wc  intr_status/INTCLEAR
//              [3] RX overrun interrupt
//              [2] TX overrun interrupt
//              [1] RX interrupt
//              [0] TX interrupt
// 0x10 RW    BAUDDIV[19:0] Baud divider
//            (minimum value is 16)
// 0x3E0 - 0x3FC  ID registers
//-------------------------------------

module cmsdk_apb_uart (
// --------------------------------------------------------------------------
// Port Definitions
// --------------------------------------------------------------------------
  input  wire        PCLK,     // Clock
  input  wire        PCLKG,    // Gated Clock
  input  wire        PRESETn,  // Reset

  input  wire        PSEL,     // Device select
  input  wire [11:2] PADDR,    // Address
  input  wire        PENABLE,  // Transfer control
  input  wire        PWRITE,   // Write control
  input  wire [31:0] PWDATA,   // Write data

  input  wire [3:0]  ECOREVNUM,// Engineering-change-order revision bits

  output wire [31:0] PRDATA,   // Read data
  output wire        PREADY,   // Device ready
  output wire        PSLVERR,  // Device error response

  input  wire        RXD,      // Serial input
  output wire        TXD,      // Transmit data output
  output wire        TXEN,     // Transmit enabled
  output wire        BAUDTICK, // Baud rate (x16) Tick

  output wire        TXINT,    // Transmit Interrupt
  output wire        RXINT,    // Receive Interrupt
  output wire        TXOVRINT, // Transmit overrun Interrupt
  output wire        RXOVRINT, // Receive overrun Interrupt
  output wire        UARTINT); // Combined interrupt

  //Remove This Code
  assign PREADY = 1'b1;
  assign PSLVERR = 1'b0;
  assign TXEN = 1'b0;
  assign BAUDTICK = 1'b0;
  assign TXINT = 1'b0;
  assign RXINT = 1'b0;
  assign TXOVRINT = 1'b0;
  assign RXOVRINT = 1'b0;
  assign UARTINT = 1'b0;
  
endmodule
