`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:57:36 12/21/2020 
// Design Name: 
// Module Name:    Adder16 
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
module Adder16 ( input [20:0]a, input [20:0] b, output reg [20:0]out);
	always @(a, b, out) begin
		if (a[20] == b[20]) begin
			out[19:0] = a[19:0] + b[19:0];
			out[20] = a[20];
		end
		else begin
			if (a[19:0] > b[19:0]) begin
				out[19:0] = a[19:0] - b[19:0];
				out[20] = a[20];
			end
			else begin
				out[19:0] = b[19:0] - a[19:0];
				out[20] = b[20];
			end
		end
	end
endmodule
