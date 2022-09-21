`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:07:57 12/21/2020 
// Design Name: 
// Module Name:    Multipler8_1 
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
module mux1_2(A, B, S, F);
  input A, B, S;
  output F;
  
  assign F = S ? B : A;
endmodule

module C1(A0, A1, SA, B0, B1, SB, S0, S1, F);
  input A0, A1, SA, B0, B1, SB, S0, S1;
  output F;
  
  wire F1, F2, F, S2;
  mux1_2 mux1_20(A0, A1, SA, F1);
  mux1_2 mux1_21(B0, B1, SB, F2);
  mux1_2 mux1_22(F1, F2, S2, F);
  
  or or_0(S2, S0, S1);
  
endmodule

module multiplier2(A, B, C);
    input [1:0] A, B;
    output [3:0] C;
    
    // C0
    C1 C1_0(1'b0, A[0], B[0], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, C[0]);
    
    // C1
    wire O0, O1, O2, O3;
    C1 C1_1(1'b0, A[0], B[1], 1'b0, 1'b0, 1'b0, A[1], 1'b0, O0);
    C1 C1_2(1'b0, A[0], B[1], 1'b0, 1'b0, 1'b0, B[0], 1'b0, O1);
    C1 C1_3(1'b0, A[1], B[0], 1'b0, 1'b0, 1'b0, B[1], 1'b0, O2);
    C1 C1_4(1'b0, A[1], B[0], 1'b0, 1'b0, 1'b0, A[0], 1'b0, O3);
    
    C1 C1_5(O0, 1'b1, O1, 1'b1, 1'b1, 1'b1, O2, O3, C[1]);
    
    // C2
    wire O4, O5;
    C1 C1_6(1'b0, A[1], B[1], 1'b0, 1'b0, 1'b0, B[0], 1'b0, O4);
    C1 C1_7(1'b0, A[1], B[1], 1'b0, 1'b0, 1'b0, A[0], 1'b0, O5);
    C1 C1_8(O4, 1'b1, O5, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, C[2]);
  
    // C3
    wire O6;
    C1 C1_9(1'b0, 1'b0, 1'b0, 1'b0, A[0], A[1], B[0], 1'b0, O6);
    C1 C1_10(1'b0, O6, B[1], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, C[3]);
endmodule

module multiplier4(A, B, C);
	input [3:0] A, B;
   output [7:0] C;
	
	wire [3:0]mult2_out0;
	wire [3:0]mult2_out1;
	wire [3:0]mult2_out2;
	wire [3:0]mult2_out3;
	multiplier2 multiplier2_0(A[1:0], B[1:0], mult2_out0);
	multiplier2 multiplier2_1(A[3:2], B[1:0], mult2_out1);
	multiplier2 multiplier2_2(A[1:0], B[3:2], mult2_out2);
	multiplier2 multiplier2_3(A[3:2], B[3:2], mult2_out3);
	
	assign C = {mult2_out3, 4'b0} + {mult2_out2, 2'b0} + {mult2_out1, 2'b0} + mult2_out0;
endmodule

module UMultipler8_1( input [7:0]A, input [7:0]B, output [15:0]out);
	wire [7:0]mult4_out0;
	wire [7:0]mult4_out1;
	wire [7:0]mult4_out2;
	wire [7:0]mult4_out3;
	multiplier4 multiplier4_0(A[3:0], B[3:0], mult4_out0);
	multiplier4 multiplier4_1(A[3:0], B[7:4], mult4_out1);
	multiplier4 multiplier4_2(A[7:4], B[3:0], mult4_out2);
	multiplier4 multiplier4_3(A[7:4], B[7:4], mult4_out3);
	
	wire [8:0]add8_out0;
	wire [8:0]add8_out1;
	wire [8:0]add8_out2;
	
	assign add8_out0 = mult4_out1 + mult4_out2;
	assign add8_out1 = add8_out0[7:0] + {4'b0, mult4_out0[7:4]};
	assign add8_out2 = mult4_out3 + {3'b0, add8_out0[8], add8_out1[7:4]};
	
	assign out[3:0] = mult4_out0[3:0];
	assign out[7:4] = add8_out1[3:0];
	assign out[15:8] = add8_out2[7:0];
endmodule

module Multipler8_1( input [7:0]A, input [7:0]B, output [14:0]out);
	wire [13:0]mult_out;
	assign mult_out = A[6:0] * B[6:0];
	
	assign out = ((A[7] == B[7])) ? {1'b0, mult_out} : {1'b1, mult_out};
endmodule
