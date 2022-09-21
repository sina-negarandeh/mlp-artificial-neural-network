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
	integer j;
	integer q;
	reg [7:0]test_data[0:46500];
	reg [495:0]reshaped_test_data;
	
	reg [7:0]test_label[0:46500];
	
	reg [7:0]wh[1239:0];
	reg [9919:0]reshaped_wh;
	
	reg [7:0]wo[199:0];
	reg [1599:0]reshaped_wo;
	
	reg [7:0]bh[19:0];
	reg [159:0]reshaped_bh;
	
	reg [7:0]bo[9:0];
	reg [79:0]reshaped_bo;

	NN NN_0(reshaped_test_data, reshaped_wh, reshaped_wo, reshaped_bh, reshaped_bo, clk, rst, start, label);
	
	initial begin
	
		$readmemh("test_data_sm.dat", test_data);
		$readmemh("test_lable_sm.dat", test_label);
		$readmemh("wh_sm.dat", wh);
		$readmemh("wo_sm.dat", wo);
		$readmemh("bh_sm.dat", bh);
		$readmemh("bo_sm.dat", bo);
		
		for (i = 0; i < 1240; i = i + 1) begin
			reshaped_wh[i * 8 +: 8] = wh[i];
		end
		
		for (i = 0; i < 200; i = i + 1) begin
			reshaped_wo[i * 8 +: 8] = wo[i];
		end
		
		for (i = 0; i < 20; i = i + 1) begin
			reshaped_bh[i * 8 +: 8] = bh[i];
		end
		
		for (i = 0; i < 10; i = i + 1) begin
			reshaped_bo[i * 8 +: 8] = bo[i];
		end
		
		num_of_corrects = 32'b0;
		for (i = 0; i < 750; i = i + 1)begin
			for (j = 0; j < 62; j = j + 1)begin
				reshaped_test_data[j * 8 +: 8] = test_data[i * 62 + j];
			end
			
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

