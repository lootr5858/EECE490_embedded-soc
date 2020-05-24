module example #(

// --------------------------------------------------------------------------
// Parameter Declarations
// --------------------------------------------------------------------------
 parameter AW       = 5  // Address width
)
 
(

  // Inputs
 input  wire          HCLK,      // Clock
 input  wire          HRESETn,   // Reset
 input  wire          HSEL,      // Slave select
 input  wire [1:0]    HTRANS,    // Transfer type
 input  wire          HREADY,    // System ready
 input  wire [AW-1:0] HADDR,   // Address
 input  wire [2:0]    HSIZE,   // Transfer size
 input  wire          HWRITE,  // Write control
 input  wire [31:0]   HWDATA,  // Write data

  // Outputs
 output wire       HREADYOUT, // Slave ready
 output wire       HRESP,      // Slave response
 output wire [31:0]   HRDATA  // Read data output
 
);    



// Start of main code

// Internal signals
reg    [1:0] resp_state; // Current FSM state for two-cycle error response
wire   [1:0] next_state; // Next FSM state

wire			 read_valid;
wire  		 write_valid;

wire   [AW-1:0] nxt_word_addr;
reg    [AW-1:0] word_addr;


reg    [7:0]  ram_data[0:((1<<AW)-1)]; // 64k byte of RAM data

// Internal signals
reg           read_enable;    // Data phase read enable
reg           write_enable;   // Data phase write enable
reg    [3:0]  reg_byte_lane;  // Data phase byte lane
reg    [3:0]  next_byte_lane; // Next state of reg_byte_lane

reg    [7:0]  rdata_out_0;    // Read Data Output byte#0
reg    [7:0]  rdata_out_1;    // Read Data Output byte#1
reg    [7:0]  rdata_out_2;    // Read Data Output byte#2
reg    [7:0]  rdata_out_3;    // Read Data Output byte#3

//user define 
assign nxt_word_addr = {HADDR[AW-1:2], 2'b00};


// Generate read control (address phase)
assign read_valid  = HSEL & HREADY & HTRANS[1] & (~HWRITE);
  
// Generate write control (address phase)
assign write_valid = HSEL & HREADY & HTRANS[1] & HWRITE;



  
// Registering control signals to data phase
always @(posedge HCLK or negedge HRESETn)
begin
  if (~HRESETn)
    begin
    read_enable   <= 1'b0;
    write_enable  <= 1'b0;
    word_addr <= {AW{1'b0}};
    end
  else if (HREADY)
    begin
    read_enable   <= read_valid;
    write_enable  <= write_valid;
    word_addr     <= nxt_word_addr;
    end
end

  // Read operation
  always @(*)
  begin
		 if (read_enable)
		 begin
			rdata_out_0 = ram_data[word_addr  ];
			rdata_out_1 = ram_data[word_addr+1];
			rdata_out_2 = ram_data[word_addr+2];
    		rdata_out_3 = ram_data[word_addr+3];
		 end
	 
		 else
		 begin  
			rdata_out_0 = 8'h00;
			rdata_out_1 = 8'h00;
			rdata_out_2 = 8'h00;
			rdata_out_3 = 8'h00;
		 end
   end
	 


  // Registered write
  always @(posedge HCLK)
  begin
    if (write_enable)
      begin
      ram_data[word_addr  ] = HWDATA[ 7: 0];
		ram_data[word_addr+1] = HWDATA[15: 8];
		ram_data[word_addr+2] = HWDATA[23:16];
		ram_data[word_addr+3] = HWDATA[31:24];
      end
  end


assign HREADYOUT = 1'b1;
assign HRESP     = 1'b0;

// Read data output
assign HRDATA    = {rdata_out_3, rdata_out_2, rdata_out_1, rdata_out_0};

endmodule 