`timescale 1ns / 1ps

module EdgeDetector(
        input logic bu,
        input logic reset,
        input logic clk,
        output logic edgeOut
    );
    
    typedef enum {zero, one} state_type;
    
    state_type state_reg, state_next;
    
    always_ff @(posedge clk, posedge reset)
    begin
        if(reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
    end
    
    always_comb
    begin
        edgeOut = 1'b0;
        state_next = zero;
        case(state_reg)
            zero:
                if(bu)
                begin
                    edgeOut = 1'b1;
                    state_next = one;
                end
            one:
                if(bu)
                begin
                    state_next = one;
                end
            default: state_next = zero;
        endcase
    end
endmodule
