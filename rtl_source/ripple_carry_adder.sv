`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 03:27:10 AM
// Design Name: 
// Module Name: ripple_carry_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 16-bit ripple carry adder as the final adder for wallace tree multiplier
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ripple_carry_adder
(
    input  logic [15:0] A,
    input  logic [15:0] B,
    output logic [15:0] Out
);

// internal signals 
logic [16:0] Carry; // 17 bit to hold overflow bit (should always be 0 in an 8-bit multiplier since worst case can be represented in 16 bits

// simple rca
generate 
    for(genvar i = 0; i < 16; i = i + 1)
    begin
        full_adder fa_x (.A(A[i]), .B(B[i]), .Ci(Carry[i]), .S(Out[i]), .Co(Carry[i + 1]));
    end
endgenerate

assign Carry[0] = 1'b0; // cin0 is always 0

endmodule
