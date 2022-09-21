`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:30 01/15/2021 
// Design Name: 
// Module Name:    Saturation 
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
module saturation (input [20:0]in, output reg [7:0]out);
	always @(in) begin
		if (in > 21'b000000000000001111111) out <= 8'b01111111;
		else out <= in[7:0];
		// **********************************
	end
endmodule
