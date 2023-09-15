`timescale 1ns / 1ps

module tb_ring_counter();
    wire[3:0] out;
    reg clk, reset;
    
    ring_counter DUT(out, clk, reset);
    
    always #10 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        
        #20 reset = 0;    
    end
endmodule
