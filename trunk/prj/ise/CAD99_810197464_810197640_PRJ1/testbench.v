`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:51:48 12/22/2020 
// Design Name: 
// Module Name:    testbench 
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
module testbench( );
	reg clk, rst, start;
	reg [7:0]in;
	reg [7:0]weight;
	
	parameter M = 4;
	parameter N = 18;
	wire ready;
	wire [17:0]out;

	Neuron #(N, M)Neuron_0(clk, rst, start, in, weight, out, ready);
	initial begin
		start = 1'b1;
		rst = 1'b0;
		#20
		rst = 1'b1;
		#20
		rst = 1'b0;
		#20
		#80 #20 clk = 1'b0;
		#80 #20 clk = 1'b1;
		#80 #20 clk = 1'b0;
		#80 in = 8'b00000011; weight = 8'b00000110; #20 clk = 1'b1;
		#80 #20 clk = 1'b0;
		#80 #20 clk = 1'b1;
		#80 #20 clk = 1'b0;
		#80 in = 8'b00000010; weight = 8'b00000010; #20 clk = 1'b1;
		#80 #20 clk = 1'b0;
		#80 #20 clk = 1'b1;
		#80 #20 clk = 1'b0;
		#80 in = 8'b00000011; weight = 8'b00011010; #20 clk = 1'b1;
		#80 #20 clk = 1'b0;
		#80 #20 clk = 1'b1;
		#80 #20 clk = 1'b0;
		#80 in = 8'b00000111; weight = 8'b00001010; #20 clk = 1'b1;
		#80 #20 clk = 1'b0;
		#80 #20 clk = 1'b1;
		#80 #20 clk = 1'b0;
		$monitor("Expected output: %d, Actual output: %d", 170, out);
	end
endmodule
