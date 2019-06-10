`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:14:52 05/16/2019 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module debouncer(
		input clk,
		input rst,
		input key_in,
		output reg key_stable_out
    );

// DELAY!!!!
	reg q;
	reg key_synch;
	reg [21:0]delay_cntr;
	parameter DELAY = 2;				// sygnaly krotsze niz DELAY traktowane jako drgania
	
	always @(posedge clk or posedge rst)
	if(rst)
		begin
			delay_cntr <= DELAY;
			q <= 0;
			key_synch <= 0;
			key_stable_out <= 0;
		end
	
	else
		begin
				q <= key_in;
				key_synch <= q;
				if(key_synch == key_stable_out)
					delay_cntr <= 0;
				else
					delay_cntr <= delay_cntr + 1;
					
				if(delay_cntr == DELAY)	// 2 500 000 cykli zegara x okres zegara 20ns = 50ms 
					begin
						key_stable_out <= key_synch;
						delay_cntr <= 0;
					end
		end

endmodule
