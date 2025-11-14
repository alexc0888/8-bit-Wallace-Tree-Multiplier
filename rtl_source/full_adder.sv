`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 10:49:40 PM
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Full adder for wallace tree reduction and final adder stages
// 
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder
(
    input logic A,
    input logic B,
    input logic Ci,
    output logic S,
    output logic Co
);

// internal signals 
logic S_h1, Co_h1;
logic Co_h2;
logic Co_inv;

// half-adder chain
half_adder ha1(.A(A), .B(B), .S(S_h1), .Co(Co_h1));
half_adder ha2(.A(S_h1), .B(Ci), .S(S), .Co(Co_h2));

// Co calculation
nor (Co_inv, Co_h1, Co_h2); // inverted Co
not (Co, Co_inv); // true Co

endmodule
