`timescale 1ns / 1ps

module counter_32(
        output[31:0] out,
        input clk, reset
    );
    reg[31:0] counter;
    always@(posedge clk) begin
        if(reset) counter = {32{1'b0}};
        else counter = counter + 1;
    end
endmodule
