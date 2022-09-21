`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:16 01/15/2021 
// Design Name: 
// Module Name:    NNdatapath 
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
module NNDatapath( input [31:0]i, input clk, input rst, input neuron_start, input [1:0]pass, input hreg1_en, input hreg2_en, input oreg_en, input [15:0]counter, input [15:0]N, output reg [7:0]label);
	// Input Leyer
	reg [7:0]test_data[0:61];
	
	reg [7:0]all_test_data[0:46500];
	reg [495:0]r_test_data;
	
	reg [7:0]wh[0:1239];
	reg [7:0]wo[0:199];
	reg [7:0]bh[0:19];
	reg [7:0]bo[0:9];

	initial begin
		$readmemh("test_data_sm.dat", all_test_data);
		$readmemh("wh_sm.dat", wh);
		$readmemh("wo_sm.dat", wo);
		$readmemh("bh_sm.dat", bh);
		$readmemh("bo_sm.dat", bo);
	end
	
	integer j;
	always @(i, test_data) begin
		for (j = 0; j < 62; j = j + 1)begin
				r_test_data[j * 8 +: 8] = all_test_data[i * 62 + j];
		end
	end
	
	integer k;
	always @(r_test_data) begin
		for (k = 0; k < 62; k = k + 1) begin
			test_data[k] = r_test_data[k * 8 +: 8];
		end
	end
	
	// Hidden and Output Leyer
	wire ready[0:9];
	wire [7:0]out[0:9];
	
	reg [7:0]data_input[0:9];
	reg [7:0]weight_input[0:9];
	
	genvar q;
	generate
		for (q = 0; q < 10; q = q + 1) begin
			// input
			always @(pass, counter, test_data, bh, N, hreg1, hreg2, bo, q) begin
				if (pass == 2'b00) begin
					if (counter != 16'b1) data_input[q] = test_data[N - counter];
					else data_input[q] = bh[q + pass * 10];
				end
				
				else if (pass == 2'b01) begin
					if (counter != 16'b1) data_input[q] = test_data[N - counter];
					else data_input[q] = bh[q + pass * 10];
				
				end if (pass == 2'b10) begin
					if (counter == 16'b1) data_input[q] = bo[q];
					else begin
						if (N - counter < 10) data_input[q] = hreg1[N - counter];
						else data_input[q] = hreg2[N - counter - 10];
					end
				end
			end
			// weight
			always @(pass, counter, test_data, bh, N, hreg1, hreg2, bo, q) begin
				if (pass == 2'b00) begin
					if (counter != 16'b1) weight_input[q] = wh[(N - counter) + q * (N - 1)];
					else weight_input[q] = 8'b01111111;
				end
				else if (pass == 2'b01) begin
					if (counter != 16'b1) weight_input[q] = wh[(N - counter) + q * (N - 1) + 620];
					else weight_input[q] = 8'b01111111;
				end if (pass == 2'b10) begin
					if (counter != 16'b1) weight_input[q] = wo[(N - counter) + (q * (N - 1))];
					else weight_input[q] = 8'b01111111;
				end
			end
		end
	endgenerate

	
	genvar n;
	generate
		for (n = 0; n < 10; n = n + 1) begin
			Neuron Neuron_0(clk, rst, neuron_start, pass, N, data_input[n], weight_input[n], out[n] ,ready[n]);
		end
	endgenerate
	
	wire [7:0]hreg1[0:9];
	genvar p;
	generate
		for (p = 0; p < 10; p = p + 1) begin
			Register8 Register8_0(out[p], clk, rst, hreg1_en, hreg1[p]);
		end
	endgenerate
	
	wire [7:0]hreg2[0:9];
	genvar r;
	generate
		for (r = 0; r < 10; r = r + 1) begin
			Register8 Register8_1(out[r], clk, rst, hreg2_en, hreg2[r]);
		end
	endgenerate

	wire [7:0]oreg[0:9];
	genvar t;
	generate
		for (t = 0; t < 10; t = t + 1) begin
			Register8 Register8_2(out[t], clk, rst, oreg_en, oreg[t]);
		end
	endgenerate

	reg [7:0]z;
	reg [7:0]max;
	reg [7:0]index;
	always @(oreg) begin
		max = 8'b0;
		label = 8'b0;
		for (z = 0; z < 10; z = z + 1) begin
			if (oreg[z] >= max) begin
				max = oreg[z];
				index = z;
			end
		end
		label = index;
	end

endmodule
