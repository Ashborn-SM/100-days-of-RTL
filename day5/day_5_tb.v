`timescale 1ns / 1ps

module tb_johnson_counter();
    reg clk, reset;
    wire[3:0] out;
    
    johnson_counter DUT(out, clk, reset);
    
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        
        #20 reset = 0;
    end

endmodule
