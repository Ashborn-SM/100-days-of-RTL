`timescale 1ns / 1ps

module tb_sequence_detector();
    reg in, clk, reset;
    wire out;
    
    sequence_detector_10101 DUT(out, in, clk, reset);
    
    always #10 clk = ~clk;
    initial begin
        clk = 1;
        reset = 1;
        
        #20 reset = 0;
        #15
        #20 in = 1;
        #20 in = 0;
        #20 in = 1;
        #20 in = 0;
        #20 in = 1;
        #20 in = 0;
        #20 in = 1;
        #20 in = 1;
    end
endmodule
