`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:52 01/08/2021 
// Design Name: 
// Module Name:    NeuralNetwork 
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
module NN(input [495:0]reshaped_test_data, input [9919:0]reshaped_wh, input [1599:0]reshaped_wo, input [159:0]reshaped_bh, input [79:0]reshaped_bo, input clk, input rst, input start, output [7:0]label);
	wire [15:0]N;
	wire neuron_start, hreg1_en, hreg2_en, oreg_en;
	wire [1:0] pass;
	wire [15:0]counter;
	NNDatapath NNDatapath_0( reshaped_test_data, reshaped_wh, reshaped_wo, reshaped_bh, reshaped_bo, clk, rst, neuron_start, pass, hreg1_en, hreg2_en, oreg_en, counter, N, label);
	NNController NNController_0(clk, rst, start, neuron_start, hreg1_en, hreg2_en, oreg_en, counter, N, pass);
endmodule
