`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 06:51:17 PM
// Design Name: 
// Module Name: wallace_tree_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: gate-level implementation of 8-bit wallace tree multiplier.
//               This RTL is intended for prototyping 8-bit wallace tree multiplier IC layout
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module wallace_tree_multiplier
(
    input logic [7:0] A,
    input logic [7:0] B,
    output logic [15:0] Out
);

// internal signals
logic [7:0] pp_prods [7:0]; // going to produce eight 8-bit partial products from NAND array
logic [15:0] pp_red1, pp_red2; // our final two terms to sum after partial product reduction


// top-level instantiations
partial_prod_gen #(.DIM(8)) pp_gen(.A(A), .B(B), .pp_prods(pp_prods));
partial_prod_reduct pp_reduct(.pp_prods(pp_prods), .pp_red1(pp_red1), .pp_red2(pp_red2));
ripple_carry_adder  rca(.A(pp_red1), .B(pp_red2), .Out(Out));

endmodule
