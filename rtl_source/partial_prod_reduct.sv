`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2025 11:49:20 PM
// Design Name: 
// Module Name: partial_prod_reduct
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Reduce the partial products into just two terms. Performed in 4 passes, 
//              using a total of 34 full-adders and 14 half-adders
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module partial_prod_reduct
(
    input  logic [7:0] pp_prods [7:0],
    output logic [15:0] pp_red1,
    output logic [15:0] pp_red2
);

// internal signals 
logic [18:0] S_stg1, Co_stg1; // 19 adders in stage 1
logic [13:0] S_stg2, Co_stg2; // 14 adders in stage 2
logic [6:0]  S_stg3, Co_stg3; // 7 adders in stage 3
logic [7:0]  S_stg4, Co_stg4; // 8 adders in stage 4


// pp_red1, pp_red2 always maintain these values from pp_prods
assign pp_red1[1:0]   = pp_prods[0][1:0];
assign pp_red2[1:0]   = {pp_prods[1][0], 1'b0};

// reduction stage 1
half_adder ha1  (.A(pp_prods[0][2]), .B(pp_prods[1][1]),                      .S(S_stg1[0]),  .Co(Co_stg1[0]));
full_adder fa1  (.A(pp_prods[0][3]), .B(pp_prods[1][2]), .Ci(pp_prods[2][1]), .S(S_stg1[1]),  .Co(Co_stg1[1]));
full_adder fa2  (.A(pp_prods[0][4]), .B(pp_prods[1][3]), .Ci(pp_prods[2][2]), .S(S_stg1[2]),  .Co(Co_stg1[2]));
full_adder fa3  (.A(pp_prods[0][5]), .B(pp_prods[1][4]), .Ci(pp_prods[2][3]), .S(S_stg1[3]),  .Co(Co_stg1[3]));
full_adder fa4  (.A(pp_prods[0][6]), .B(pp_prods[1][5]), .Ci(pp_prods[2][4]), .S(S_stg1[4]),  .Co(Co_stg1[4]));
full_adder fa5  (.A(pp_prods[0][7]), .B(pp_prods[1][6]), .Ci(pp_prods[2][5]), .S(S_stg1[5]),  .Co(Co_stg1[5]));
full_adder fa6  (.A(pp_prods[7][1]), .B(pp_prods[6][2]), .Ci(pp_prods[5][3]), .S(S_stg1[6]),  .Co(Co_stg1[6]));
full_adder fa7  (.A(pp_prods[7][2]), .B(pp_prods[6][3]), .Ci(pp_prods[5][4]), .S(S_stg1[7]),  .Co(Co_stg1[7]));
full_adder fa8  (.A(pp_prods[7][3]), .B(pp_prods[6][4]), .Ci(pp_prods[5][5]), .S(S_stg1[8]),  .Co(Co_stg1[8]));
full_adder fa9  (.A(pp_prods[7][4]), .B(pp_prods[6][5]), .Ci(pp_prods[5][6]), .S(S_stg1[9]),  .Co(Co_stg1[9]));
full_adder fa10 (.A(pp_prods[7][5]), .B(pp_prods[6][6]), .Ci(pp_prods[5][7]), .S(S_stg1[10]), .Co(Co_stg1[10]));

// rotating back through previously visited columns to pick up other additions...
half_adder ha2  (.A(pp_prods[3][1]), .B(pp_prods[4][0]),                      .S(S_stg1[11]), .Co(Co_stg1[11]));
full_adder fa11 (.A(pp_prods[3][2]), .B(pp_prods[4][1]), .Ci(pp_prods[5][0]), .S(S_stg1[12]), .Co(Co_stg1[12]));
full_adder fa12 (.A(pp_prods[3][3]), .B(pp_prods[4][2]), .Ci(pp_prods[5][1]), .S(S_stg1[13]), .Co(Co_stg1[13]));
full_adder fa13 (.A(pp_prods[3][4]), .B(pp_prods[4][3]), .Ci(pp_prods[5][2]), .S(S_stg1[14]), .Co(Co_stg1[14]));
full_adder fa14 (.A(pp_prods[4][4]), .B(pp_prods[3][5]), .Ci(pp_prods[2][6]), .S(S_stg1[15]), .Co(Co_stg1[15]));
full_adder fa15 (.A(pp_prods[4][5]), .B(pp_prods[3][6]), .Ci(pp_prods[2][7]), .S(S_stg1[16]), .Co(Co_stg1[16]));
half_adder ha3  (.A(pp_prods[4][6]), .B(pp_prods[3][7]),                      .S(S_stg1[17]), .Co(Co_stg1[17]));
half_adder ha4  (.A(pp_prods[6][1]), .B(pp_prods[7][0]),                      .S(S_stg1[18]), .Co(Co_stg1[18]));

// update pp_red1, pp_red2 with relevant stage 1 outputs
assign pp_red1[2] = S_stg1[0];
assign pp_red2[2] = pp_prods[2][0];



// reduction stage 2
half_adder ha5  (.A(S_stg1[1]),      .B(Co_stg1[0]),                          .S(S_stg2[0]),  .Co(Co_stg2[0]));
full_adder fa16 (.A(S_stg1[2]),      .B(S_stg1[11]),     .Ci(Co_stg1[1]),     .S(S_stg2[1]),  .Co(Co_stg2[1]));
full_adder fa17 (.A(S_stg1[3]),      .B(S_stg1[12]),     .Ci(Co_stg1[2]),     .S(S_stg2[2]),  .Co(Co_stg2[2]));
full_adder fa18 (.A(S_stg1[4]),      .B(S_stg1[13]),     .Ci(Co_stg1[3]),     .S(S_stg2[3]),  .Co(Co_stg2[3]));
full_adder fa19 (.A(S_stg1[5]),      .B(S_stg1[14]),     .Ci(S_stg1[18]),     .S(S_stg2[4]),  .Co(Co_stg2[4]));
full_adder fa20 (.A(S_stg1[6]),      .B(S_stg1[15]),     .Ci(Co_stg1[5]),     .S(S_stg2[5]),  .Co(Co_stg2[5]));
full_adder fa21 (.A(S_stg1[7]),      .B(S_stg1[16]),     .Ci(Co_stg1[6]),     .S(S_stg2[6]),  .Co(Co_stg2[6]));
full_adder fa22 (.A(S_stg1[8]),      .B(S_stg1[17]),     .Ci(Co_stg1[7]),     .S(S_stg2[7]),  .Co(Co_stg2[7]));
full_adder fa23 (.A(S_stg1[9]),      .B(Co_stg1[8]),     .Ci(Co_stg1[17]),    .S(S_stg2[8]),  .Co(Co_stg2[8]));
half_adder ha6  (.A(S_stg1[10]),     .B(Co_stg1[9]),                          .S(S_stg2[9]),  .Co(Co_stg2[9]));
full_adder fa24 (.A(pp_prods[7][6]), .B(pp_prods[6][7]), .Ci(Co_stg1[10]),    .S(S_stg2[10]), .Co(Co_stg2[10]));
half_adder ha7  (.A(Co_stg1[12]),    .B(pp_prods[6][0]),                      .S(S_stg2[11]), .Co(Co_stg2[11]));
half_adder ha8  (.A(Co_stg1[4]),     .B(Co_stg1[13]),                         .S(S_stg2[12]), .Co(Co_stg2[12]));
full_adder fa25 (.A(Co_stg1[14]),    .B(Co_stg1[18]),    .Ci(pp_prods[1][7]), .S(S_stg2[13]), .Co(Co_stg2[13]));

// update pp_red1, pp_red2 with relevant stage 2 outputs
assign pp_red1[4:3] = {S_stg2[1], S_stg2[0]};
assign pp_red2[4:3] = {Co_stg2[0], pp_prods[3][0]};



// reduction stage 3
half_adder ha9  (.A(S_stg2[2]), .B(Co_stg2[1]),                      .S(S_stg3[0]), .Co(Co_stg3[0]));
full_adder fa26 (.A(S_stg2[3]), .B(S_stg2[11]), .Ci(Co_stg2[2]),     .S(S_stg3[1]), .Co(Co_stg3[1]));
full_adder fa27 (.A(S_stg2[4]), .B(S_stg2[12]), .Ci(Co_stg2[3]),     .S(S_stg3[2]), .Co(Co_stg3[2]));
full_adder fa28 (.A(S_stg2[5]), .B(S_stg2[13]), .Ci(Co_stg2[4]),     .S(S_stg3[3]), .Co(Co_stg3[3]));
full_adder fa29 (.A(S_stg2[6]), .B(Co_stg2[5]), .Ci(Co_stg2[13]),    .S(S_stg3[4]), .Co(Co_stg3[4]));
full_adder fa30 (.A(S_stg2[7]), .B(Co_stg2[6]), .Ci(Co_stg1[16]),    .S(S_stg3[5]), .Co(Co_stg3[5]));
full_adder fa31 (.A(S_stg2[8]), .B(Co_stg2[7]), .Ci(pp_prods[4][7]), .S(S_stg3[6]), .Co(Co_stg3[6]));

// update pp_red1, pp_red2 with relevant stage 3 outputs
assign pp_red1[6:5] = {S_stg3[1], S_stg3[0]};
assign pp_red2[6:5] = {Co_stg3[0], Co_stg1[11]};



// reduction stage 4
half_adder ha10 (.A(S_stg3[2]),      .B(Co_stg3[1]),                   .S(S_stg4[0]), .Co(Co_stg4[0]));
full_adder fa32 (.A(S_stg3[3]),      .B(Co_stg3[2]), .Ci(Co_stg2[12]), .S(S_stg4[1]), .Co(Co_stg4[1]));
full_adder fa33 (.A(S_stg3[4]),      .B(Co_stg3[3]), .Ci(Co_stg1[15]), .S(S_stg4[2]), .Co(Co_stg4[2]));
half_adder ha11 (.A(S_stg3[5]),      .B(Co_stg3[4]),                   .S(S_stg4[3]), .Co(Co_stg4[3]));
half_adder ha12 (.A(S_stg3[6]),      .B(Co_stg3[5]),                   .S(S_stg4[4]), .Co(Co_stg4[4]));
full_adder fa34 (.A(S_stg2[9]),      .B(Co_stg3[6]), .Ci(Co_stg2[8]),  .S(S_stg4[5]), .Co(Co_stg4[5]));
half_adder ha13 (.A(S_stg2[10]),     .B(Co_stg2[9]),                   .S(S_stg4[6]), .Co(Co_stg4[6]));
half_adder ha14 (.A(pp_prods[7][7]), .B(Co_stg2[10]),                  .S(S_stg4[7]), .Co(Co_stg4[7]));

// update pp_red1, pp_red2 with relevant stage 4 outputs
assign pp_red1[15:7] = {Co_stg4[7], S_stg4[7],  S_stg4[6],  S_stg4[5],  S_stg4[4],  S_stg4[3],  S_stg4[2],  S_stg4[1],   S_stg4[0]};
assign pp_red2[15:7] = {1'b0,      Co_stg4[6], Co_stg4[5], Co_stg4[4], Co_stg4[3], Co_stg4[2], Co_stg4[1], Co_stg4[0], Co_stg2[11]};




endmodule
