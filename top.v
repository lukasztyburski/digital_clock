`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:13:11 06/03/2019 
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
module top(
		input clk_i,
		input [3:0] btn_i,
		output [3:0] led7_an_o,
		output [7:0] led7_seg_o
    );

// SYGNALY WEWNETRZNE
	wire [2:0] btn_stable;
	wire [5:0] hour_counter_out;
	wire [5:0] minute_counter_out;
	wire [5:0] second_counter_out;
	wire [5:0] hour_adjuster_out;
	wire [5:0] minute_adjuster_out;
	wire adjuster_to_counter_f;
	
// MODULY

	debouncer deb_0(
		.clk(clk_i),
		.rst(btn_i[3]),
		.key_in(btn_i[0]),
		.key_stable_out(btn_stable[0])
	);
	
	debouncer deb_1(
		.clk(clk_i),
		.rst(btn_i[3]),
		.key_in(btn_i[1]),
		.key_stable_out(btn_stable[1])
	);
	
	debouncer deb_2(
		.clk(clk_i),
		.rst(btn_i[3]),
		.key_in(btn_i[2]),
		.key_stable_out(btn_stable[2])
	);
	
	adjuster adj_0(
		.clk_i(clk_i),
		.rst_i(btn_i[3]),
		.add_minute_i(btn_stable[0]),
		.add_hour_i(btn_stable[1]),
		.minute_i(minute_counter_out),
		.hour_i(hour_counter_out),
		.flag_o(adjuster_to_counter_f),
		.minute_o(minute_adjuster_out),
		.hour_o(hour_adjuster_out)
	);
	
	
	counter count_0(
		.clk_i(clk_i),
		.rst_i(btn_i[3]),
		.accelerate_i(btn_stable[2]),
		.minute_i(minute_adjuster_out),
		.hour_i(hour_adjuster_out),
		.flag_i(adjuster_to_counter_f),
		.minute_o(minute_counter_out),
		.hour_o(hour_counter_out),
		.second_o(second_counter_out)
	);
	
	
	display dsp_0(
		.clk_i(clk_i),
		.rst_i(btn_i[3]),
		.minute_i(minute_counter_out),
		.hour_i(hour_counter_out),
		.led7_an_o(led7_an_o),
		.led7_seg_o(led7_seg_o),
		.second_i(second_counter_out)
	);

endmodule
