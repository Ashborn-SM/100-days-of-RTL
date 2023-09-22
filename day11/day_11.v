`timescale 1ns / 1ps

module barrel_shifter(
    output[7:0] out,
    input[7:0] in,
    input[2:0] sel
    );
    integer i;
    reg[7:0] set_output;
    always@(*) begin
        set_output = in >> sel;
        for(i = 0; i<sel; i=i+1) begin
            set_output[7-i] = in[7];
        end
    end
    assign out = set_output;
endmodule
