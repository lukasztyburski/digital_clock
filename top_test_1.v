`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:41:21 06/05/2019
// Design Name:   top
// Module Name:   C:/Users/Lukasz/Documents/Xilinx/zegar_v7/top_test_1.v
// Project Name:  zegar_v7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_test_1;

	// Inputs
	reg clk_i;
	reg [3:0] btn_i;

	// Outputs
	wire [3:0] led7_an_o;
	wire [7:0] led7_seg_o;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk_i(clk_i), 
		.btn_i(btn_i), 
		.led7_an_o(led7_an_o), 
		.led7_seg_o(led7_seg_o)
	);

	initial begin
		// Initialize Inputs
		clk_i = 0;
		btn_i = 0;
		
		#20 btn_i[3] = 1;
		#20 btn_i[3] = 0;
		
		
		#20 btn_i[2] = 1;

		
		repeat (23)
		begin
			#550 btn_i[1] = 1;
			#550 btn_i[1] = 0;
		end

		#23000000 btn_i[3] = 1;
		#550 btn_i[3] = 0;
		
		repeat (23)
		begin
			#550 btn_i[1] = 1;
			#550 btn_i[1] = 0;
		end
		
		#23000000 btn_i[1] = 1;
		#550 btn_i[1] = 0;
		
		
	end
	always
	#10 clk_i = ~clk_i;
      
endmodule

