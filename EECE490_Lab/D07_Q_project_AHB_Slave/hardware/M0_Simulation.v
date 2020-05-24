module M0_Simulation (
	input  	wire        NRST,    // active low reset
	input	   wire        nTRST,
   input		wire        TDI,
	input		wire        SWDIOTMS,
	input		wire        SWCLKTCK,
	output	wire        XTAL2,   // crystal pin 2
	output	wire			TDO
);


  wire        XTAL1;   // crystal pin 1 
  wire [15:0] P0;      // Port 0
  wire [15:0] P1;      // Port 1

  //Debug tester signals
  
  wire        PCLK;          // Clock for UART capture device
  wire [5:0]  debug_command; // used to drive debug tester
  wire        debug_running; // indicate debug test is running
  wire        debug_err;     // indicate debug test has error
  wire        debug_test_en; // To enable the debug tester connection to MCU GPIO P0
                             // This signal is controlled by software,
                             // Use "UartPutc((char) 0x1B)" to send ESCAPE code to start
                             // the command, use "UartPutc((char) 0x11)" to send debug test
                             // enable command, use "UartPutc((char) 0x12)" to send debug test
                             // disable command. Refer to tb_uart_capture.v file for detail
 
  parameter BE              = 0;   // Big or little endian
  
  parameter BKPT            = 4;   // Number of breakpoint comparators
  parameter DBG             = 1;   // Debug configuration
  parameter NUMIRQ          = 32;  // NUM of IRQ
  parameter SMUL            = 0;   // Multiplier configuration
  parameter SYST            = 1;   // SysTick
  parameter WIC             = 1;   // Wake-up interrupt controller support
  parameter WICLINES        = 34;  // Supported WIC lines
  parameter WPT             = 2;   // Number of DWT comparators

 // --------------------------------------------------------------------------------
 // Cortex-M0/Cortex-M0+ Microcontroller
 // --------------------------------------------------------------------------------

  cmsdk_mcu
   #(.BE               (BE),
     .BKPT             (BKPT),          // Number of breakpoint comparators
     .DBG              (DBG),           // Debug configuration
     .NUMIRQ           (NUMIRQ),        // NUMIRQ
     .SMUL             (SMUL),          // Multiplier configuration
     .SYST             (SYST),          // SysTick
     .WIC              (WIC),           // Wake-up interrupt controller support
     .WICLINES         (WICLINES),      // Supported WIC lines
     .WPT              (WPT)            // Number of DWT comparators
   )
   u_cmsdk_mcu (
  .XTAL1      (XTAL1),  // input
  .XTAL2      (XTAL2),  // output
  .NRST       (NRST),   // active low reset
  .P0         (P0),
  .P1         (P1),
  .nTRST      (nTRST),  // Not needed if serial-wire debug is used
  .TDI        (TDI),    // Not needed if serial-wire debug is used
  .TDO        (TDO),    // Not needed if serial-wire debug is used
  .SWDIOTMS   (SWDIOTMS),
  .SWCLKTCK   (SWCLKTCK)
  );

 // --------------------------------------------------------------------------------
 // Source for clock and reset
 // --------------------------------------------------------------------------------
  cmsdk_clkreset u_cmsdk_clkreset(
  .CLK  (XTAL1),
  .NRST (NRST)
  );

 // --------------------------------------------------------------------------------
 // UART output capture
 // --------------------------------------------------------------------------------
  assign PCLK = XTAL1;

  cmsdk_uart_capture   u_cmsdk_uart_capture(
    .RESETn               (NRST),
    .CLK                  (PCLK),
    .RXD                  (P1[5]), // UART 2 use for StdOut
    .DEBUG_TESTER_ENABLE  (debug_test_en),
    .SIMULATIONEND        (),      // This signal set to 1 at the end of simulation.
    .AUXCTRL              ()
  );

  // UART connection cross over for UART test
  assign P1[0] = P1[3];  // UART 0 RXD = UART 1 TXD
  assign P1[2] = P1[1];  // UART 1 RXD = UART 0 TXD

endmodule
