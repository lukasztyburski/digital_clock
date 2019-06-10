`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:23:37 05/26/2019 
// Design Name: 
// Module Name:    display 
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
module display(
		input clk_i,
		input rst_i,
		input [5:0] minute_i,
		input [5:0] hour_i,
		input [5:0] second_i,
		output [3:0] led7_an_o,
		output [7:0] led7_seg_o
    );

// TODO
// czestotliwosc multipleksowania, przelaczanie kropki sekund

	parameter ZERO = 8'h03;
	parameter ONE = 8'h9F;
	parameter TWO = 8'h25;
	parameter THREE = 8'h0D;
	parameter FOUR = 8'h99;
	parameter FIVE = 8'h49;
	parameter SIX = 8'h41;
	parameter SEVEN = 8'h1F;
	parameter EIGHT = 8'h01;
	parameter NINE = 8'h09;
		
		
		
	wire [3:0] minute_left;
	wire [3:0] minute_right;
	wire [3:0] hour_left;
	wire [3:0] hour_right;
	
	
	reg [3:0] led7_an_r;
	reg [7:0] led7_seg_r;
	reg [1:0] number_of_display;		// numer wyœwietlacza
	reg [15:0] refresh_counter;		// licznik odswiezania
	parameter REFRESH = 50000;			// stala dla licznika odsiwiezajacego wyswietlacz z czest. 1kHZ
	reg second_on;					// rejestr przelaczajacy kropke sekund
	
	
	
// moduly rozdzielajace liczbe minut i godzin na pojedyncze cyfry
	spliter split_minute(
		.number_i(minute_i),
		.left_digit_o(minute_left),
		.right_digit_o(minute_right)
		);
	
	spliter split_hour(
		.number_i(hour_i),
		.left_digit_o(hour_left),
		.right_digit_o(hour_right)
		);
	
	
	// do symulacji
	initial
	begin
		led7_an_r = 4'hF;
		led7_seg_r = 8'hFF;
		number_of_display = 3;
		refresh_counter = 0;
		second_on = 0;
	end
	
	
	always @(posedge clk_i or posedge rst_i)
	if(rst_i)
		begin
			led7_an_r = 4'hF;
			led7_seg_r = 8'hFF;
			number_of_display = 3;
			refresh_counter = 0;
			second_on = 0;
		end
	else
		begin
			refresh_counter = refresh_counter + 1;				// inkrementacja licznika opoznienia
		
			if(second_i % 2 == 1)
				second_on = 1;
			else
				second_on = 0;
				
				
			if(refresh_counter == REFRESH)
				begin
			// iteracja po kolejnych wyswietlaczach: skrajny lewy - 3, skrajny prawy - 0	
				case(number_of_display)	
					3:	// aktywna AN3
						begin
							led7_an_r = 4'b0111;
							case(hour_left)				
									0: led7_seg_r = ZERO;		//	wybor segmentow odpowiadajacych wyswietlanej cyfrze
									1: led7_seg_r = ONE;
									2: led7_seg_r = TWO;
									3: led7_seg_r = THREE;
									4: led7_seg_r = FOUR;
									5: led7_seg_r = FIVE;
									6: led7_seg_r = SIX;
									7: led7_seg_r = SEVEN;
									8: led7_seg_r = EIGHT;
									9: led7_seg_r = NINE;
							endcase
							number_of_display = 2;	// przejscie do kolejnego wyswietlacza
						end
						
					2:	// aktywna AN2
						begin
							led7_an_r = 4'b1011;
							case(hour_right)
									
									0: led7_seg_r = ZERO;
									1: led7_seg_r = ONE;
									2: led7_seg_r = TWO;
									3: led7_seg_r = THREE;
									4: led7_seg_r = FOUR;
									5: led7_seg_r = FIVE;
									6: led7_seg_r = SIX;
									7: led7_seg_r = SEVEN;
									8: led7_seg_r = EIGHT;
									9: led7_seg_r = NINE;
								endcase
								
							// przelaczanie kropki sygnalizujacej sekundy
								if(second_on)			
									led7_seg_r[0] = 0;			// nadpisanie ostatniego bitu wektora segmentow, czyli wlaczanie kropki
								else
									led7_seg_r[0] = 1;
								
								number_of_display = 1;
							end
							
					1:	// aktywna AN1
						begin
							led7_an_r = 4'b1101;
							case(minute_left)
									
									0: led7_seg_r = ZERO;
									1: led7_seg_r = ONE;
									2: led7_seg_r = TWO;
									3: led7_seg_r = THREE;
									4: led7_seg_r = FOUR;
									5: led7_seg_r = FIVE;
									6: led7_seg_r = SIX;
									7: led7_seg_r = SEVEN;
									8: led7_seg_r = EIGHT;
									9: led7_seg_r = NINE;
								endcase
								number_of_display = 0;
						end
						
					0:	// aktywna AN0
						begin
							led7_an_r = 4'b1110;
							case(minute_right)
									
									0: led7_seg_r = ZERO;
									1: led7_seg_r = ONE;
									2: led7_seg_r = TWO;
									3: led7_seg_r = THREE;
									4: led7_seg_r = FOUR;
									5: led7_seg_r = FIVE;
									6: led7_seg_r = SIX;
									7: led7_seg_r = SEVEN;
									8: led7_seg_r = EIGHT;
									9: led7_seg_r = NINE;
								endcase
								number_of_display = 3;
						end
					
				endcase
				
				refresh_counter = 0; 	// ZEROwanie licznika opoznienia
			end // if(refresh_coutner)	
		end	// always
		
	// przypisanie rejestrow na wyjscia
		assign led7_seg_o = led7_seg_r;
		assign led7_an_o = led7_an_r;
		
endmodule
