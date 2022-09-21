`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:03 12/21/2020 
// Design Name: 
// Module Name:    ActivationFunction 
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
module ActivationFunction ( input [20:0]in, output reg [20:0]out);
	always @(in) begin
		if (in[20] == 1'b1) out <= 0;
		else if (in[20] == 1'b0) out <= in;
		// **********************************
	end
endmodule
