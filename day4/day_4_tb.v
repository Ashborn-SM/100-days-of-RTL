`timescale 1ns / 1ps

module tb_ring_counter();
    wire[3:0] out;
    reg clk, reset, preset;
    
    ring_counter DUT(out, clk, reset, preset);
    
    always #10 clk = ~clk;
    
    initial begin
        clk = 0;
        preset = 1;
        reset = 1;
        
        #20 reset = 0;
        #20 preset = 0;    
    end
endmodule
