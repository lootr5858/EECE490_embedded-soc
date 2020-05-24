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
`
//-------------------------------------
`timescale 1ns/1ps

module cmsdk_apb_uart (
// --------------------------------------------------------------------------
// Port Definitions
// --------------------------------------------------------------------------
  input  wire        PCLK,     // Clock
  input  wire        PRESETn,  // Reset

  input  wire        PSEL,     // Device select
  input  wire [11:2] PADDR,    // Address
  input  wire        PENABLE,  // Transfer control
  input  wire        PWRITE,   // Write control
  input  wire [31:0] PWDATA,   // Write data
  output wire [31:0] PRDATA,   // Read data
  output wire        PREADY,   // Device ready

  input  wire        RXD,      // Serial input
  output wire        TXD,      // Transmit data output
  output wire        TXEN      // Transmit enabled
);

wire sel_tr;
wire sel_ctrl;
wire sel_baud;


uart_b_cp uart_cp
(
	.rst	  (PRESETn),
	.sel	  (PSEL),
	.enable (PENABLE),
	.addr	  (PADDR),
	
	.sel_tr	 (sel_tr),
	.sel_ctrl (sel_ctrl),
	.sel_baud (sel_baud),
	.ready	 (PREADY)
);

uart_b_dp uart_dp
(
	.clk		 (PCLK),
	.rst		 (PRESETn),
	.sel_tr   (sel_tr),
	.sel_ctrl (sel_ctrl),
	.sel_baud (sel_baud),
	.enable	 (PENABLE),
	.data_out (PWDATA),
	.rx_in	 (RXD),
	
	.data_in (PRDATA),
	.tx_en	(TXEN),
	.tx_out	(TXD)
);


endmodule
