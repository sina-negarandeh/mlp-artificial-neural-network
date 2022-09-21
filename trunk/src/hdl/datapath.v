`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:53:46 12/22/2020 
// Design Name: 
// Module Name:    datapath 
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
module datapath (input clk, input rst, input [7:0]in, input [7:0]weight, input [1:0]pass, input acc_reset, input acumulator_register_en, input input_register, output [7:0]out);
	
	wire [7:0] in_reg;
	wire [7:0] weight_reg;
	Register8 Register8_0(in, clk, rst, input_register, in_reg);
	Register8 Register8_1(weight, clk, rst, input_register, weight_reg);
	
	wire [14:0]mult_out;
	Multipler8_1 Multipler8_1_0( in_reg, weight_reg, mult_out);
	
	wire [20:0]add_out;
	wire [20:0]accumulator_out;
	Adder16 Adder16_0({mult_out[14], 6'b000000, mult_out[13:0]}, accumulator_out, add_out);
	
	Register21 Register21_0(add_out, clk, rst, acc_reset, acumulator_register_en, accumulator_out);
	
	wire [20:0]activation_input;
	assign activation_input = {accumulator_out[20], (accumulator_out[19:0] >> 9)};
	
	wire [20:0]activation_out;
	ActivationFunction ActivationFunction_0(activation_input, activation_out);
	saturation saturation_0(activation_out, out);
endmodule
