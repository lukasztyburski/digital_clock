`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:57:54 05/26/2019 
// Design Name: 
// Module Name:    spliter 
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
module spliter(
		input [5:0] number_i,
		output reg [3:0] left_digit_o,
		output reg [3:0] right_digit_o
    );


	initial
		begin
			left_digit_o = 0;
			right_digit_o = 0;
		end

	always@(*)
	begin
		if(number_i < 10)
			begin
				left_digit_o = 0;
				right_digit_o = number_i;
			end
		else if(number_i < 20)
			begin
				left_digit_o = 1;
				right_digit_o = number_i - 10;
			end
		else if(number_i < 30)
			begin
				left_digit_o = 2;
				right_digit_o = number_i - 20;
			end
		else if(number_i < 40)
			begin
				left_digit_o = 3;
				right_digit_o = number_i - 30;
			end
		else if(number_i < 50)
			begin
				left_digit_o = 4;
				right_digit_o = number_i - 40;
			end
		else if(number_i < 60)
			begin
				left_digit_o = 5;
				right_digit_o = number_i - 50;
			end
		else
			begin
				left_digit_o = 6;
				right_digit_o = 0;
			end
		
	end

endmodule
