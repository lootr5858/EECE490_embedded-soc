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
//-----------------------------------------------------------------------------
// Abstract : Testbench for the Cortex-M0 example system
//-----------------------------------------------------------------------------
//
`timescale 1ns/100ps
`include "cmsdk_mcu_defs.v"

module tb_cmsdk_mcu;
  //wires
 	wire        NRST;    // active low reset
   wire        nTRST;
 	wire        TDI;
	wire        SWDIOTMS;
	wire        SWCLKTCK;
	wire        XTAL2;   // crystal pin 2
	
  //instantiation
  M0_Simulation uut1 (
  .NRST(NRST),
  .nTRST(nTRST),
  .TDI(TDI),
  .SWDIOTMS(SWDIOTMS),
  .SWCLKTCK(SWCLKTCK),
  .XTAL2(XTAL2));
  
 // --------------------------------------------------------------------------------
 // Debug tester connection -
 // --------------------------------------------------------------------------------

 // No debug connection for Cortex-M0 DesignStart
 assign nTRST    = NRST;
 assign TDI      = 1'b1;
 assign SWDIOTMS = 1'b1;
 assign SWCLKTCK = 1'b1;


 // --------------------------------------------------------------------------------
 // Misc
 // --------------------------------------------------------------------------------

  // Format for time reporting
  initial    $timeformat(-9, 0, " ns", 0);

  initial begin
  #2100000
  $stop;
  end
endmodule
