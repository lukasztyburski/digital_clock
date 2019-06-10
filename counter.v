`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:01:59 05/30/2019 
// Design Name: 
// Module Name:    counter 
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
module counter(
		input clk_i,
		input rst_i,
		input accelerate_i,
		input [5:0] minute_i,
		input [5:0] hour_i,
		input flag_i,
		output [5:0] second_o,
		output [5:0] minute_o,
		output [5:0] hour_o
    );
// CLK 1kHZ!!!!
	
	wire clk_1HZ;						// wyjscie z dzielnika 1 HZ
	wire clk_1KHZ;						// wyjscie z dzielnika 1 kHZ
	reg clk_second;					//	podzielony sygnal zegarowy, jeden z powyzszych
	reg [5:0] hour_r;
	reg [5:0] minute_r;
	reg [5:0] second_r;
	
// dzielniki zegara
	divider div_1HZ(
			.clk_i(clk_i),
			.rst_i(rst_i),
			.clk_o(clk_1HZ)
		);
		
	divider div_1KHZ(
			.clk_i(clk_i),
			.rst_i(rst_i),
			.clk_o(clk_1KHZ)
		);
	defparam div_1HZ.N = 50000000;
	defparam div_1KHZ.N = 500;  		//100khz
	
	
// do symulacji
	initial
	begin	
		second_r <= 0;
		minute_r <= 0;
		hour_r <= 0;
		clk_second = 0;
	end
	
	
	always@(posedge clk_second or posedge rst_i or posedge flag_i)
	if(rst_i)
		begin
			second_r <= 0;
			minute_r <= 0;
			hour_r <= 0;
		end
	else 
		if(flag_i)
			begin
				minute_r <= minute_i;
				hour_r <= hour_i;
			end
	else	
		if(clk_second)
			begin
	
				if(second_r == 59)
					begin 
						second_r <= 0;
						minute_r <= minute_r + 1;
					end
				else
					second_r <= second_r + 1;
				
				if(minute_r == 59 & second_r == 59)
					begin
						minute_r <= 0;
						hour_r <= hour_r + 1;
					end
					
				if(hour_r == 24)
					begin
						hour_r <= 0;
					end	
			end
		
		
		
		assign hour_o = hour_r;
		assign minute_o = minute_r;
		assign second_o = second_r;
			

	//	przelaczanie miedzy dzielnikami - zmiana predkosci zegara
		always@(posedge clk_i)
		begin
			if(accelerate_i)	
				begin
					assign clk_second = clk_1KHZ;
				end
			else
				begin	
					assign clk_second = clk_1HZ;
				end
		end
endmodule
