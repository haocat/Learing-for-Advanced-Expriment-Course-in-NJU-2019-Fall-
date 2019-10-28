`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/27 16:40:05
// Design Name: 
// Module Name: bch_encoder
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


module bch_encoder(rst,clk,msg,bch_dataout);
    parameter n = 255;
    parameter k=191;
    input rst;
    input clk;
    input [k-1:0]msg;
  // wire [0:n-k-1]g=64'b1011011001110011100000111111000100110101101101111100110010111011;
    wire [n-k-1:0]g=191'b0110110011100111000001111110001001101011011011111001100101110111;
    output reg [n-1:0] bch_dataout;
    reg [n-k-1:0] D_register;
    reg ui;
    integer i,m,t;
    
    
    
    initial
    begin
        D_register=0;
        bch_dataout=0;
        i=k-1;
    end
    
    
    
    always@(posedge clk)
    begin
        if(rst)
        begin 
            D_register<=0;
            bch_dataout<=0;
            i<=k-1;
        end
        //
        else if (i>-1)
        begin
            ui=msg[i];
            for (t=n-k-1;t>0;t=t-1)
            begin
                D_register[t] <= ( (D_register[n-k-1]^ui)&g[t])^D_register[t-1];
            end
            D_register[0] <= D_register[n-k-1]^ui;
            bch_dataout[i+64] <= ui;
            i=i-1;
        end
        else if(i==-1)
             bch_dataout[n-k-1:0]<= D_register[n-k-1:0];
    end    
endmodule
