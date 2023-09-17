`timescale 1ns / 1ps

module tb_palindrome();

    reg in, clk, reset;
    wire out;
    
    palindrome_detector #(.BITS(10)) DUT(out, in, clk, reset);
    
    always #10 clk = ~clk;
    initial begin 
        clk = 0;
        reset = 1;
        
        #20 reset = 0;
        
        #20 in = 1;
        #20 in = 0;
        #20 in = 1;
        #20 in = 1;
        #20 in = 0;
        #20 in = 0;
        #20 in = 1;
        #20 in = 1;
        #20 in = 0;
        #20 in = 1;
        #30
        $finish;
    end

endmodule
