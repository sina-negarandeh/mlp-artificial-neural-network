`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:47:45 12/23/2020
// Design Name:   Neuron
// Module Name:   F:/amin/CAD99_810197464_810197640_PRJ1/CAD99_810197464_810197640_PRJ1/test_bench.v
// Project Name:  CAD99_810197464_810197640_PRJ1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Neuron
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench;
	reg clk, rst, start;
	wire [7:0]label;
	reg [31:0]num_of_corrects;

	integer i;
	integer q;
	
	reg [7:0]test_label[0:46500];

	NN NN_0(i, clk, rst, start, label);
	
	initial begin
		$readmemh("test_lable_sm.dat", test_label);
		
		num_of_corrects = 32'b0;
		for (i = 0; i < 750; i = i + 1)begin		
			rst = 0;
			start = 1'b1;
			#20 rst = 1;
			#20 rst = 0;
			
			for (q = 0; q < 302; q = q + 1)begin
				#80 #20 clk = 1'b0;
				#80 #20 clk = 1'b1;
			end
			if (label == test_label[i]) num_of_corrects = num_of_corrects + 1;
		end 
				
		$stop;
	end
endmodule

