`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2020 07:54:07 PM
// Design Name: 
// Module Name: SIM
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


module SIM();
    
    localparam T = 10;
    
     logic bu;
     logic reset;
     logic clk;
     logic [6:0] sseg;
     logic [7:0] an;
    
    
    TickTop uut(.*);
    
    always
    begin
        clk = 1'b0;
        #(T/2)
        clk = 1'b1;
        #(T/2);
    end
    
    initial
    begin
        
        reset = 1;
        
        #20 reset = 0;
        
        #20 bu = 1;
        
        #20 bu = 0;
        
        #20000000 bu = 1;
        
        #20 bu = 0;
        #20 bu = 1;
        #20 bu = 0;
        #20 bu = 1;
        #20 bu = 0;
        
        #20000000 bu = 1;
        
        #20 bu = 0;
        #20 bu = 1;
        #20 bu = 0;
        #20 bu = 1;
        #20 bu = 0;
        
        //#20 bu = 0;
        //#20 bu = 1;
        //#20 bu = 0;
    end
    

endmodule
