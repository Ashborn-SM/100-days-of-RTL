`timescale 1ns / 1ps

module demux(
  output reg o0, o1, o2, o3,
  input in,
  input[1:0] sel
);
    reg[3:0] out;
    always@(*) begin
        case(sel)
              2'b00: {o3, o2, o1, o0} = {3'b000, in};
              2'b01: {o3, o2, o1, o0} = {2'b00, in, 1'b0};
              2'b10: {o3, o2, o1, o0} = {1'b0, in, 2'b00};
              2'b11: {o3, o2, o1, o0} = {in, 3'b000};
              default: {o3, o2, o1, o0} = {3'b000, in};
        endcase
    end
endmodule
