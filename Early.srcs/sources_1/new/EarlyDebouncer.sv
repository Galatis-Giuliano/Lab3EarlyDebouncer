`timescale 1ns / 1ps

module EarlyDebouncer(
        input logic bu,
        input logic reset,
        input logic clk,
        output logic edb
    );
    localparam stableTime = 2_000_000;
    
    logic maxTick, enable;
    BinaryCounter #(.N(21)) tickTock(.clk(clk), .reset(~enable), .enable(enable), .maxValue(stableTime), .q(), .maxTick(maxTick));
    
    typedef enum {S0, S1, S2, S3,OFF} state_type;
    state_type state_reg, state_next;
    
    always_ff @(posedge clk, posedge reset)
    begin
        if(reset)
            state_reg <= OFF;
        else
            state_reg <= state_next;
    end
    
    
    always_comb
    begin
        edb = edb;
        enable = enable;
        state_next = state_next;
        
        case(state_reg)
            S0:
            begin
                enable = 1'b0;
                //edb = 1'b0;
                if(bu)
                begin
                    edb = 1'b1;
                    enable = 1'b1;
                    state_next = S1;
                end
                else
                    state_next = S0;
            end
            S1:
                if(maxTick)
                    if(~bu)
                    begin
                        edb = 1'b0;
                        state_next = S3;
                    end
                    else
                        state_next = S2;
                else
                    edb = 1'b1;             //Can Likely remove this without consequences
            S2:
            begin
                enable = 1'b0;
                //edb = 1'b1;
                if(~bu)
                begin
                    edb = 1'b0;
                    enable = 1'b1;
                    state_next = S3;
                end
                else
                    state_next = S2;
            end
            S3:
                if(maxTick)
                    if(bu)
                    begin
                        edb = 1'b1;
                        state_next = S1;
                    end
                    else
                        state_next = S0;
                else
                    edb = 1'b0;
            OFF:
                begin
                    state_next = S0;
                    edb = 1'b0;
                end
        endcase
    end
    
    //assign enable = ~((state_reg == S0) ||(state_reg == S2));
    
endmodule
