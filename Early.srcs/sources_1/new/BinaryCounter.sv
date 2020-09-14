`timescale 1ns / 1ps


module BinaryCounter
    #(parameter N = 8)
    (
        input logic clk, reset,
        input logic enable,
        input logic [N - 1:0] maxValue = 2**N-1,
        output logic [N - 1:0] q,
        output logic maxTick
    );
    
    
    logic [N - 1:0] r_next, r_reg;
    
    always_ff @(posedge clk, posedge reset)
    begin
        if(reset)
            r_reg <= 0;
        else
            r_reg <= r_next;
    end
    
    //assign r_next = enable? r_reg + 1: r_reg;
    
    always_comb
    begin
        r_next = r_next;
        if(enable)
            if(~maxTick)
                r_next = r_reg + 1;
            else
                r_next = 1'b0;
        else
            r_next = r_reg;
    end
    
    assign q = r_reg;
    
    assign maxTick = (r_reg == maxValue) ? 1'b1: 1'b0;
    
endmodule


