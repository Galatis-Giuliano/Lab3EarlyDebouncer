`timescale 1ns / 1ps

module TickTop(
        input logic bu,
        input logic reset,
        input logic clk,
        output logic [6:0] sseg,
        output logic [7:0] an
    );
    logic edb,edbTick,edgeDetectedTick;
    
    logic [7:0] debounceCounter, edgeDetectCounter;
    
    EarlyDebouncer debouncer(.clk(clk), .reset(reset), .bu(bu), .edb(edb));
    
    EdgeDetector edgeDetectorButton(.clk(clk), .reset(reset), .bu(bu), .edgeOut(edgeDetectedTick));
    EdgeDetector edgeDetectorDebounce(.clk(clk), .reset(reset), .bu(edb), .edgeOut(edbTick));
    
    BinaryCounter #(.N(8)) debounceCount(.clk(clk), .reset(reset), .enable(edbTick), .q(debounceCounter), .maxTick());
    BinaryCounter #(.N(8)) edgeDetectCount(.clk(clk), .reset(reset), .enable(edgeDetectedTick), .q(edgeDetectCounter), .maxTick());
    
    time_mux_disp sevenSegmentDisplay(
        .in0({1'b1 ,edgeDetectCounter[3:0], 1'b1}),
        .in1({1'b1 ,edgeDetectCounter[7:4], 1'b1}),
        .in2(),
        .in3(),
        .in4({1'b1 ,debounceCounter[3:0], 1'b1}),
        .in5({1'b1 ,debounceCounter[7:4], 1'b1}),
        .in6(),
        .in7(),
        .clk(clk),
        .sseg(sseg),.dp(),.an(an)
        );
    
endmodule
