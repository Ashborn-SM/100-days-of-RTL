`timescale 1ns / 1ps

module tb();
    reg[7:0] tcr;
    reg[31:0] pr, mr0, mr1;
    reg[15:0] mcr;
    reg clk, reset;
    
    timer_32 dut(tcr, pr, mr0, mr1, mr1, mr1, mcr, clk ,reset);
    always #50 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        
        tcr = 2;
        pr = 3;
        mr0 = 3;
        mr1 = 0;
        mcr = 3;
        
        #100 reset = 0;
    end
    
endmodule
