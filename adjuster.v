`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:58:25 06/02/2019 
// Design Name: 
// Module Name:    memory 
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
module adjuster(
		input clk_i,
		input rst_i,
		input add_minute_i,
		input add_hour_i,
		input [5:0] minute_i,
		input [5:0] hour_i,
		output reg flag_o,
		output reg [5:0] minute_o,
		output reg [5:0] hour_o
    );
	 
// flagi sygnalizujace dodanie minut lub godzin	 
	 reg minute_flag;			
	 reg hour_flag;

// sygnaly opozniajace o 1 cykl zegara
	 reg add_minute_r;
	 reg add_hour_r;
	 
	 
	initial
	begin
		hour_o = 0;
		minute_o = 0;
		flag_o = 0;
		minute_flag = 0;
		hour_flag = 0;	
	end
	 
// dodawanie minut
	always@(posedge clk_i or posedge rst_i)
	if(rst_i)
		begin
			minute_o = 0;
		end
	else 
		begin
			add_minute_r <= add_minute_i;				// leading edge
			minute_flag = 0;
			
			minute_o = minute_i;							// ustaw na wyjscie wartosci z wejsc
																
			if(add_minute_i == 1 & add_minute_r == 0)	// chyba ze nastapilo wcisniecie klawisza
				begin
					minute_o = minute_o + 1;				// dodaj 1 do wyjscia 
					minute_flag = 1;					
				end
				
			if(minute_o == 60)							
				minute_o = 0;
			
		end
	
// dodawanie godzin	
	always@(posedge clk_i or posedge rst_i)
	if(rst_i)
		begin
			hour_o = 0;
		end
	else
		begin
			add_hour_r <= add_hour_i;			// leading edge
			hour_flag = 0;
			
			hour_o = hour_i;
			
			if(add_hour_i == 1 & add_hour_r == 0)
				begin 
					hour_o = hour_o + 1;
					hour_flag = 1;
				end
			
			if(hour_o == 24)
				hour_o = 0;
		end
	
	
// maska dla flagi wyjsciowej
	always@(*)
	begin
		flag_o = minute_flag | hour_flag;
	end
	
endmodule
