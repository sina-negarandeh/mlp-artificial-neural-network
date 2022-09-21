`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:49:18 12/21/2020 
// Design Name: 
// Module Name:    Neuron 
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
module Neuron ( input clk, input rst, input start, input [1:0]pass, input [15:0]N, input [7:0]in, input [7:0]weight, output [7:0]out, output ready);
	wire acumulator_register_en, input_register, acc_reset;
	datapath datapath_0 (clk, rst, in, weight, pass, acc_reset, acumulator_register_en, input_register, out);
	Controller Controller_0 (clk, rst, start, N, acumulator_register_en, input_register, acc_reset, ready);
endmodule
