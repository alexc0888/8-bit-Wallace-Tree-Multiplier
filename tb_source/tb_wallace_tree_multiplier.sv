`timescale 1ps / 1fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2025 12:41:02 PM
// Design Name: 
// Module Name: tb_wallace_tree_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: testbench to exhaustively test 8x8 wallace tree multiplier
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_wallace_tree_multiplier
(

);

parameter PERIOD = 1; // wait 1ps between each input vector

int tb_test_case_num; 

// dut signals
logic [7:0] testA, testB;
logic [15:0] testOut, expectedOut;

wallace_tree_multiplier DUT (.A(testA), .B(testB), .Out(testOut));

initial 
begin
    // initialize tb tool signals 
    tb_test_case_num = -1; 
    // init DUT inputs
    testA   = '0;
    testB   = '0; 

    #(0.1)

    for(int a = 0; a < 256; a++)
    begin
        for(int b = 0; b < 256; b++)
        begin
            tb_test_case_num = tb_test_case_num + 1;
            expectedOut = a * b;
            #(PERIOD)
            assert(testOut == expectedOut) else $display("Failed test %d with a=%d and b=%d",tb_test_case_num, testA, testB);
            testB = testB + 1;
        end 
        testB = '0; // reset testB
        testA = testA + 1;
    end    

end


endmodule
