`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:12 12/21/2020 
// Design Name: 
// Module Name:    RegisterM 
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
module Register21 ( input [20:0]in, input clk, input rst, input en, output reg [20:0]out);
	always @(posedge clk, posedge rst) begin
		if (rst) out <= 0;
		else if (en) out <= in;
	end
endmodule
