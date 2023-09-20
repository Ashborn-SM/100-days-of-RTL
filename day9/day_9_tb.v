`timescale 1ns / 1ps

module tb_multiplier();
    reg[7:0] a, b;
    wire[15:0] out;
    
    multiplier_8x8 mul(out, a, b);
    
    initial begin 
        a = 8'hbc;
        b = 8'haf;
        
        #10
        a = 8'hff;
        b = 8'hff;
        #10
        a = 8'h00;
        b = 8'haf;
    end

endmodule
