`timescale 1ns / 1ps

module johnson_counter(
    output reg[3:0] out,
    input clk, reset
    );
    
    always@(posedge clk) begin
        if(reset) out <= 4'd0;
        else out <= {out[2:0], ~out[3]};
    end
    
endmodule
