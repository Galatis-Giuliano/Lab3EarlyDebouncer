`timescale 1ns / 1ps

module Comparator
    #(parameter N = 8)
    (
        input logic [N - 1: 0] x,
        input logic [N - 1: 0] y,
        output logic z
    );
    
    assign z = (x > y);
    
endmodule