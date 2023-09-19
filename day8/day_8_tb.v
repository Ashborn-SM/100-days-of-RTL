`timescale 1ns / 1ps

module tb_sequence_detector();
    reg clk, in, reset;
    wire out;
    
    sequence_detector_1101 DUT(out, in, clk, reset);
    
    always #5 clk = ~clk;
    initial begin
        clk = 1;
        reset = 1;
        
        #35 reset = 0;
        
        in = 1;
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        
    end
endmodule
