`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/15 20:43:43
// Design Name: 
// Module Name: pa-1
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


module pa1(
rst,clk,msg,bch_dataout

    );
      parameter n = 511;
      parameter k=484;
      parameter p=4;//parallel bits 
      input rst;
      input clk;
      input [3:0]msg;
    //  wire [n-k-1:0]g = 27'b101011000010010101101111001;//去掉了最高位之后的生成多项式
      wire [0:(n-k)*(n-k)-1]AP =729'b101110000000000000000000000011001000000000000000000000001100100000000000000000000001000010000000000000000000100100001000000000000000000011100000100000000000000000000000000010000000000000000100000000001000000000000000110000000000100000000000000111000000000010000000000000111100000000001000000000000110000000000000100000000000011000000000000010000000000101100000000000001000000000011000000000000000100000000001100000000000000010000000001000000000000000001000000000100000000000000000100000001100000000000000000010000101000000000000000000001000110100000000000000000000100010100000000000000000000010100100000000000000000000001111100000000000000000000000110000000000000000000000000111000000000000000000000000011100000000000000000000000;
      wire [0:(n-k)*p-1]T = 108'b101101100011001010010111000010001100111011111100011010110110001100100001001110101101010110011111110011100111;
      output reg [n-1:0] bch_dataout;
      reg [n-k-1:0] D_register;
   //   reg flag=0;
     // reg [3:0]ui;
      integer count;
      integer t,line_address, line_address2;
      
      
      
      initial
      begin
          D_register<=0;
          bch_dataout<=0;
          count<=-1;
          t<=n-k-1;
      end
      
      
      
      always@(posedge clk)
      begin
          if(rst)
          begin 
              D_register<=0;
              bch_dataout<=0;
              count<=-1;
              t=n-k-1;
          end
          //
          else if (count<120&&!rst)
          begin

              count = count + 1;
              bch_dataout<=(bch_dataout<<4)+msg;
              for (t=n-k-1;t>-1;t=t-1)
              begin
               
                  if (t==n-k-1) 
                  begin
                      line_address=(n-k-1-t)*27;//矩阵A^4的行列地址
                      line_address2=(n-k-1-t)*4;//矩阵的[A^3B A^2B A^B B]的行列地址
                      
                      D_register[t] <=  (AP[ line_address]&D_register[26])^(AP[ line_address+1]&D_register[25])^(AP[ line_address+2]&D_register[24])^(AP[ line_address+3]&D_register[23])^(AP[ line_address+4]&D_register[22])^
                                         (AP[ line_address+5]&D_register[21])^(AP[ line_address+6]&D_register[20])^(AP[ line_address+7]&D_register[19])^(AP[ line_address+8]&D_register[18])^(AP[ line_address+9]&D_register[17])^
                                         (AP[ line_address+10]&D_register[16])^(AP[ line_address+11]&D_register[15])^(AP[ line_address+12]&D_register[14])^(AP[ line_address+13]&D_register[13])^(AP[ line_address+14]&D_register[12])^
                                         (AP[ line_address+15]&D_register[11])^(AP[ line_address+16]&D_register[10])^(AP[ line_address+17]&D_register[9])^(AP[ line_address+18]&D_register[8])^(AP[ line_address+19]&D_register[7])^
                                         (AP[ line_address+20]&D_register[6])^(AP[ line_address+21]&D_register[5])
                                         ^(AP[ line_address+22]&D_register[4])^(AP[line_address+23]&D_register[3])^(AP[ line_address+24]&D_register[2])^
                                         (AP[ line_address+25]&D_register[1])^(AP[ line_address+26]&D_register[0]) ^
                                           (T[ line_address2]&msg[3])^(T[ line_address2+1]&msg[2])^
                                           (T[ line_address2+2]&msg[1])^(T[ line_address2+3]&msg[0]);
                  end
                  else 
                  begin 
                      line_address=line_address+27;
                      line_address2=line_address2+4;
        
                      D_register[t] <= (AP[ line_address]&D_register[26])^(AP[ line_address+1]&D_register[25])^(AP[ line_address+2]&D_register[24])^(AP[ line_address+3]&D_register[23])^(AP[ line_address+4]&D_register[22])^
                                         (AP[ line_address+5]&D_register[21])^(AP[ line_address+6]&D_register[20])^(AP[ line_address+7]&D_register[19])^(AP[ line_address+8]&D_register[18])^(AP[ line_address+9]&D_register[17])^
                                         (AP[ line_address+10]&D_register[16])^(AP[ line_address+11]&D_register[15])^(AP[ line_address+12]&D_register[14])^(AP[ line_address+13]&D_register[13])^(AP[ line_address+14]&D_register[12])^
                                         (AP[ line_address+15]&D_register[11])^(AP[ line_address+16]&D_register[10])^(AP[ line_address+17]&D_register[9])^(AP[ line_address+18]&D_register[8])^(AP[ line_address+19]&D_register[7])^
                                         (AP[ line_address+20]&D_register[6])^(AP[ line_address+21]&D_register[5])
                                         ^(AP[ line_address+22]&D_register[4])^(AP[line_address+23]&D_register[3])^(AP[ line_address+24]&D_register[2])^
                                         (AP[ line_address+25]&D_register[1])^(AP[ line_address+26]&D_register[0]) ^     
                                           (T[ line_address2]&msg[3])^(T[ line_address2+1]&msg[2])^
                                           (T[ line_address2+2]&msg[1])^(T[ line_address2+3]&msg[0]);
                  end 
                  

                 
               end
  
          end
          else if(count==120)
          begin
               bch_dataout<=(bch_dataout<<27) + D_register;
               count = count + 1;;
          end
      end    
endmodule
