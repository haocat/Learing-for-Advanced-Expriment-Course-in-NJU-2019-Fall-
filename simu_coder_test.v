`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/27 19:14:12
// Design Name: 
// Module Name: simu_coder_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simu_coder_test(


    );
    parameter k=191;
    reg clk;
    reg rst;
    reg [k-1:0]msg;
    wire [254:0]bch_dataout;
    always #5 clk = ~clk;
    
    initial
    begin
        msg[k-1:0]=191'b10000111110110111110000100000010011000010110000010010110100111001100101110001010101111010011011111100100011100100101110111110010000110010110001000000110100110101111100100111000101100000100100;
        clk=1;
        rst=1;
        #100 rst=~rst;
    end    
    bch_encoder out(
        .rst(rst),
        .clk(clk),
        .msg(msg),
        .bch_dataout(bch_dataout)
        );
    
endmodule
