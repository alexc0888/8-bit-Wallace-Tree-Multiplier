`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 07:14:40 PM
// Design Name: 
// Module Name: partial_prod_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 8-bit partial product generator via NAND array
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module partial_prod_gen 
#(
    parameter DIM = 8
)
(
    input logic [DIM-1:0] A,
    input logic [DIM-1:0] B,
    output logic [DIM-1:0] pp_prods [DIM-1:0]
);

// internal signals
logic [DIM-1:0] pp_prods_inv [DIM-1:0];

// NAND gates in parallel generating inverted pps 
generate 
    for(genvar pp = 0; pp < DIM; pp = pp + 1)
    begin
        for(genvar j = 0; j < DIM; j = j + 1)
        begin 
            nand (pp_prods_inv[pp][j], A[j], B[pp]);
        end
    end
endgenerate

// Invert outputs at NAND gate (this will be the best driver for whatever load partial_prod_gen is driving)
generate 
    for(genvar pp = 0; pp < DIM; pp = pp + 1)
    begin
        for(genvar j = 0; j < DIM; j = j + 1)
        begin 
            not (pp_prods[pp][j], pp_prods_inv[pp][j]);
        end
    end
endgenerate

endmodule
