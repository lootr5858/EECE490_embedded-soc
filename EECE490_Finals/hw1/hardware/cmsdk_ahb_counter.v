`timescale 1ns/1ps
/*
Register map

0x0	CNT 		R/W
0x4	ARR 		R/W
0x8	ONOFF 	R/W active-high
0x0C	OVERFLOW R
*/
module cmsdk_ahb_counter(

  // Inputs
 input  wire          HCLK,      // Clock
 input  wire          HRESETn,   // Reset
 input  wire          HSEL,      // Slave select
 input  wire [1:0]    HTRANS,    // Transfer type
 input  wire          HREADY,    // System ready
 input  wire [3:2] 	 HADDR,   // Address
 input  wire [2:0]    HSIZE,   // Transfer size
 input  wire          HWRITE,  // Write control
 input  wire [31:0]   HWDATA,  // Write data

  // Outputs
 output wire       	 HREADYOUT, // Slave ready
 output wire       	 HRESP,      // Slave response
 output wire [31:0]   HRDATA  // Read data output
 

);

localparam CNT_select 		=	2'b00;
localparam ARR_select 		=	2'b01;
localparam ONOFF_select 	=	2'b10;
localparam OVERFLOW_select =	2'b11;

localparam state_idle		=	3'b000;
localparam state_w_cnt		=	3'b001;
localparam state_r_cnt		=	3'b010;
localparam state_w_arr		=	3'b011;
localparam state_r_arr		=	3'b100;
localparam state_w_onoff	=	3'b101;
localparam state_r_onoff	=	3'b110;
localparam state_r_overflow=	3'b111;

reg [31:0]	CNT;
reg [31:0]	ARR;//auto reload register
reg 			ONOFF;
reg			OVERFLOW;
reg [2:0]	state;
reg [31:0]  HRDATA_buff;

//HTRANS is always 10
assign HREADYOUT = 1'b1;
assign HRESP 	  = 1'b0;
assign HRDATA	  = HRDATA_buff;

initial
begin
	CNT		<=	{32{1'b0}};
	ARR		<=	{32{1'b1}};
	ONOFF		<=	1'b0;
	OVERFLOW	<=	1'b0;
	state		<=	state_idle;
end
/*
//其实如果真的是衔接地很紧密的传输，这两个模块合并并且在一个always块内合理排序，也蛮好的！
always @(posedge HCLK)
begin
// AHB control	
	if(HSEL)
	begin
	//master write
		if(HWRITE)
		begin
		
			case(HADDR[3:2])
				CNT_select:
				begin
					state	<=	state_w_cnt;
				end
				ARR_select:
				begin
					state	<=	state_w_arr;
				end
				ONOFF_select:
				begin
					state	<=	state_w_onoff;
				end
			endcase
		end
		
		//master read
		else
		begin
		
			case(HADDR[3:2])
				CNT_select:
				begin
					state	<=	state_r_cnt;
				end
				ARR_select:
				begin
					state	<=	state_r_arr;
				end
				ONOFF_select:
				begin
					state	<=	state_r_onoff;				
				end	
				OVERFLOW_select:
				begin
					state	<=	state_r_overflow;				
				end
			endcase
		
		end
	//CNT写的同时把OVERFLOW给清掉
	end
	else
		#5	state	<=	state_idle;
end

always @(posedge HCLK)
begin

	//reset
	if(~HRESETn)
	begin
		CNT		=	{32{1'b0}};
		ARR		=	{32{1'b1}};
		ONOFF		=	1'b0;
		OVERFLOW	=	1'b0;
	end
	//counting
	if(ONOFF)
	begin
		if(CNT==ARR)
		begin
			OVERFLOW	=	1'b1;
			CNT		=	{32{1'b0}};
		end
		else
			CNT=CNT+1'b1;
	end
	//setting registers
	if(state!=state_idle)
	begin
		case(state)
			state_w_cnt:
			begin
				CNT	=	HWDATA;
				OVERFLOW	=	1'b0;
			end
			state_r_cnt:
				HRDATA_buff	=	CNT;
			state_w_arr:
				ARR	=	HWDATA;
			state_r_arr:
				HRDATA_buff	=	ARR;
			state_w_onoff:
				ONOFF	=	HWDATA[0];
			state_r_onoff:
				HRDATA_buff	=	{{31{1'b0}},ONOFF};
			state_r_overflow:
				HRDATA_buff	=	{{31{1'b0}},OVERFLOW};
		endcase
	end

end
*/

always @(posedge HCLK)
begin

	//reset
	if(~HRESETn)
	begin
		CNT		=	{32{1'b0}};
		ARR		=	{32{1'b1}};
		ONOFF		=	1'b0;
		OVERFLOW	=	1'b0;
	end
	//counting
	if(ONOFF)
	begin
		if(CNT==ARR)
		begin
			OVERFLOW	=	1'b1;
			CNT		=	{32{1'b0}};
		end
		else
			CNT=CNT+1'b1;
	end
	//setting registers
	if(state!=state_idle)
	begin
		case(state)
			state_w_cnt:
			begin
				CNT	=	HWDATA;
				OVERFLOW	=	1'b0;
			end
			state_r_cnt:
				HRDATA_buff	=	CNT;
			state_w_arr:
				ARR	=	HWDATA;
			state_r_arr:
				HRDATA_buff	=	ARR;
			state_w_onoff:
				ONOFF	=	HWDATA[0];
			state_r_onoff:
				HRDATA_buff	=	{{31{1'b0}},ONOFF};
			state_r_overflow:
				HRDATA_buff	=	{{31{1'b0}},OVERFLOW};
		endcase
	end
// AHB control	
	if(HSEL)
	begin
	//master write
		if(HWRITE)
		begin
			case(HADDR[3:2])
				CNT_select:
				begin
					state	<=	state_w_cnt;
				end
				ARR_select:
				begin
					state	<=	state_w_arr;
				end
				ONOFF_select:
				begin
					state	<=	state_w_onoff;
				end
			endcase
		end
		
		//master read
		else
		begin
			case(HADDR[3:2])
				CNT_select:
				begin
					state	<=	state_r_cnt;
				end
				ARR_select:
				begin
					state	<=	state_r_arr;
				end
				ONOFF_select:
				begin
					state	<=	state_r_onoff;				
				end	
				OVERFLOW_select:
				begin
					state	<=	state_r_overflow;				
				end
			endcase
		
		end
	//CNT写的同时把OVERFLOW给清掉
	end
	else
		state	<=	state_idle;
end


endmodule
