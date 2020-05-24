
`timescale 1ns/1ps

module tb_uart_tx;

localparam PERIOD = 20;

// --------------------------------------------------------------------------
// Port Definitions
// --------------------------------------------------------------------------
  
  // wire for TX UART
  wire		PCLK;     // Clock
  wire        	PRESETn;  // Reset

  wire        	U0_PSEL;     // Device select
  wire  [11:2] 	U0_PADDR;    // Address
  wire         	U0_PENABLE;  // Transfer control
  wire         	U0_PWRITE;   // Write control
  wire  [31:0] 	U0_PWDATA;   // Write data
  wire	[31:0]	U0_PRDATA;   // Read data
  wire        	U0_PREADY;   // Device ready

  wire        	U0_TXD;      // Transmit data output
  wire        	U0_TXEN;     // Transmit enabled

  wire		CLK;
  wire		NRST;
  
// --------------------------------------------------------------------------
// assignment
// --------------------------------------------------------------------------
  assign PCLK = CLK;
  assign PRESETn = NRST;
 
cmsdk_apb_uart uart0(
  .PCLK		(PCLK),  // Clock
  .PRESETn	(NRST),  // Reset

  .PSEL		(U0_PSEL),     // Device select
  .PADDR	(U0_PADDR),    // Address
  .PENABLE	(U0_PENABLE),  // Transfer control
  .PWRITE	(U0_PWRITE),   // Write control
  .PWDATA	(U0_PWDATA),   // Write data
  .PRDATA	(U0_PRDATA),   // Read data
  .PREADY	(U0_PREADY),   // Device ready

  .RXD		(1'b1),        // Serial input
  .TXD		(U0_TXD),      // Transmit data output
  .TXEN		(U0_TXEN)      // Transmit enabled
); // Combined interrupt


sg_uart_tx sg_uart_tx(
  .CLK		(PCLK),
  .RESETn	(NRST),

  .PSEL		(U0_PSEL),     	// Device select
  .PADDR	(U0_PADDR),    	// Address
  .PENABLE	(U0_PENABLE),  	// Transfer control
  .PWRITE	(U0_PWRITE),   	// Write control
  .PWDATA	(U0_PWDATA),   	// Write data

  .PRDATA	(U0_PRDATA),   	// Read data
  .PREADY	(U0_PREADY)   	// Device ready
);

cmsdk_clkreset u_cmsdk_clkreset(
  .CLK  (CLK),
  .NRST (NRST)
);

// --------------------------------------------------------------------------
// Simulation control
// --------------------------------------------------------------------------
 
  initial 
  begin
    #(PERIOD*10000)
    $finish();
  end
 

endmodule
