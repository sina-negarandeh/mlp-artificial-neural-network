`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:20 01/15/2021 
// Design Name: 
// Module Name:    NNController 
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
module NNController(input clk, input rst, input start, output reg neuron_start, output reg hreg1_en, output reg hreg2_en, output reg oreg_en, output reg [15:0]counter, output reg [15:0]N, output reg [1:0]pass);
	reg [3:0] next_state, present_state;
	reg counter_en;
	
	always @(posedge clk) begin
		if (present_state == 4'b0001 || present_state == 4'b0101 || present_state == 4'b1001) counter <= N;
		else if (counter_en) counter <= counter - 16'b00000001;
	end
	
	always @(start, present_state) begin
		case (present_state)
			4'b0000: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b0;
				N = 16'b0000000000111111;
				counter_en = 1'b0;
				pass = 2'b00;
			end
			
			//
			4'b0001: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b1;
				N = 16'b0000000000111111;
				counter_en = 1'b0;
				pass = 2'b00;
			end
			
			4'b0010: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b0;
				N = 16'b0000000000111111;
				counter_en = 1'b1;
				pass = 2'b00;
			end
			
			4'b0011: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b0;
				N = 16'b0000000000111111;
				counter_en = 1'b0;
				pass = 2'b00;
			end
			
			4'b0100: begin
				hreg1_en = 1'b1;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b0;
				N = 16'b0000000000111111;
				counter_en = 1'b0;
				pass = 2'b00;
			end
			
			//
			4'b0101: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b1;
				N = 16'b0000000000111111;
				counter_en = 1'b0;
				pass = 2'b01;
			end
			
			4'b0110: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b0;
				N = 16'b0000000000111111;
				counter_en = 1'b1;
				pass = 2'b01;
			end
			
			4'b0111: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b0;
				N = 16'b0000000000111111;
				counter_en = 1'b0;
				pass = 2'b01;
			end
			
			4'b1000: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b1;
				oreg_en = 1'b0;
				neuron_start = 1'b0;
				N = 16'b0000000000111111;
				counter_en = 1'b0;
				pass = 2'b01;
			end
			
			//
			4'b1001: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b1;
				N = 16'b0000000000010101;
				counter_en = 1'b0;
				pass = 2'b10;
			end
			
			4'b1010: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b0;
				N = 16'b0000000000010101;
				counter_en = 1'b1;
				pass = 2'b10;
			end
			
			4'b1011: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b0;
				neuron_start = 1'b0;
				N = 16'b0000000000010101;
				counter_en = 1'b0;
				pass = 2'b10;
			end
			
			4'b1100: begin
				hreg1_en = 1'b0;
				hreg2_en = 1'b0;
				oreg_en = 1'b1;
				neuron_start = 1'b0;
				N = 16'b0000000000010101;
				counter_en = 1'b0;
				pass = 2'b10;
			end

		endcase
	end
	
	always @(start, present_state) begin
		case (present_state)
			4'b0000: next_state = {3'b000, start};
			4'b0001: next_state = 4'b0010;
			4'b0010: next_state = 4'b0011;
			4'b0011: next_state = (counter == 16'b0) ? 4'b0100 : 4'b0010;
			4'b0100: next_state = 4'b0101;

			4'b0101: next_state = 4'b0110;
			4'b0110: next_state = 4'b0111;
			4'b0111: next_state = (counter == 16'b0) ? 4'b1000 : 4'b0110;
			4'b1000: next_state = 4'b1001;

			4'b1001: next_state = 4'b1010;
			4'b1010: next_state = 4'b1011;
			4'b1011: next_state = (counter == 16'b0) ? 4'b1100 : 4'b1010;
			4'b1100: next_state = 4'b0000;
		endcase
	end

	always @(posedge rst, posedge clk) begin
		if (rst) present_state <= 4'b0;
		else present_state <= next_state;
	end
endmodule