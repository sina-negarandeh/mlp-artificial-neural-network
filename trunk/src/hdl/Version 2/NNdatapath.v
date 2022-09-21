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
module NNDatapath( input [495:0]reshaped_test_data, input [9919:0]reshaped_wh, input [1599:0]reshaped_wo, input [159:0]reshaped_bh, input [79:0]reshaped_bo, input clk, input rst, input neuron_start, input [1:0]pass, input hreg1_en, input hreg2_en, input oreg_en, input [15:0]counter, input [15:0]N, output reg [7:0]label);
	// Input Leyer
	reg [7:0]test_data[0:61];
	integer i;
	always @(reshaped_test_data) begin
		for (i = 0; i < 62; i = i + 1) begin
			test_data[i] = reshaped_test_data[i * 8 +: 8];
		end
	end
	
	reg [7:0]wh[0:1239];
	integer j;
	always @(reshaped_wh) begin
		for (j = 0; j < 1240; j = j + 1) begin
			wh[j] = reshaped_wh[j * 8 +: 8];
		end
	end
	
	reg [7:0]wo[0:199];
	integer k;
	always @(reshaped_wo) begin
		for (k = 0; k < 200; k = k + 1) begin
			wo[k] = reshaped_wo[k * 8 +: 8];
		end
	end
	
	reg [7:0]bh[0:19];
	integer l;
	always @(reshaped_bh) begin
		for (l = 0; l < 20; l = l + 1) begin
			bh[l] = reshaped_bh[l * 8 +: 8];
		end
	end
	
	reg [7:0]bo[0:9];
	integer m;
	always @(reshaped_bo) begin
		for (m = 0; m < 10; m = m + 1) begin
			bo[m] = reshaped_bo[m * 8 +: 8];
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
