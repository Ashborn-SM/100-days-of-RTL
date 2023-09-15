`timescale 1ns / 1ps

module ring_counter(
    output reg[3:0] out,
    input clk, reset
    );
    
    always@(posedge clk) begin
        if(reset) out <= 4'b0001;
        else out <= (out[3] & 1'b1)? 4'b0001: {out[2:0], 1'b0};
    end
    
endmodule
