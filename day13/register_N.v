`timescale 1ns / 1ps

module register_N
    #(parameter SIZE = 8)(
     output reg[SIZE-1:0] out,
     input[SIZE-1:0] in,
     input clk, reset
    );
    
    always@(posedge clk, posedge reset) begin
        if(reset) out <= {SIZE{1'b0}};
        else out <= in;
    end
    
endmodule
