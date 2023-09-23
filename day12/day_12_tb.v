`timescale 1ns / 1ps

module tb_circular_shifter();
    reg[7:0] in;
    reg[2:0] shift;
    wire[7:0] out;
    
    circular_shifter_8 dut(out, in, shift);
    initial begin 
        #10 in = 8'haf;
        shift = 3'h0;
        
        #10 in = 8'haf;
        shift = 3'h1;
        
        #10 in = 8'haf;
        shift = 3'h2;
        
        #10 in = 8'haf;
        shift = 3'h3;
        
        #10 in = 8'haf;
        shift = 3'h4;
        
    end
endmodule
