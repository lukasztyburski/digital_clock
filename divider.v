`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:15:29 03/07/2019 
// Design Name: 
// Module Name:    dzielnik 
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
module divider(
		input clk_i,
		input rst_i,
		output reg clk_o
    );
	 
		
	parameter N =  868; // 50M / 6*9600 - 1 bit danych trwa 6 cykli zegara
	reg [26:0] licznik = 0;
	 
	
	
	always @(posedge clk_i or posedge rst_i)	
		if (rst_i)
		begin
		 licznik = 0;
		 clk_o = 0;
		end
		
		else	
		begin			
			if((N % 2) == 0)
			begin
				licznik = licznik + 1;
				if(licznik == N/2)
				begin
					clk_o = ~clk_o;
					licznik = 0;
				end	
			end
			
			else
			begin 
				licznik = licznik + 1;
				if(licznik == N/2)
					clk_o = ~clk_o;
				if(licznik == N)
				begin
					clk_o = ~clk_o;
					licznik = 0;
				end
			end
	
		end
endmodule
