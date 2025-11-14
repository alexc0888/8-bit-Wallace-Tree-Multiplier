`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 10:47:05 PM
// Design Name: 
// Module Name: half_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: half-adder used for wallace tree reduction
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module half_adder
(
    input logic A,
    input logic B,
    output logic S,
    output logic Co
);

// internal signals
logic Co_inv; 

xor (S, A, B); // sum bit 
nand (Co_inv, A, B); // ~Co
not (Co, Co_inv); // true Co

endmodule
