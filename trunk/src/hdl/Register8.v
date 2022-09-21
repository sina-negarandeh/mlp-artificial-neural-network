`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:52:54 12/21/2020 
// Design Name: 
// Module Name:    Register8 
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
module Register8( input [7:0]in, input clk, input rst, input en, output reg [7:0]out);
	always @(posedge clk) begin
		if (rst) out <= 8'b0;
		else if (en) out <= in;
	end
endmodule
