`timescale 1ns / 1ps

module circular_shifter_8(
    output[7:0] out,
    input[7:0] in,
    input[2:0] shift
    );
    integer i;
    reg[7:0] temp;
    always@(*) begin
        temp = in;
        for(i=0; i<shift; i=i+1) begin
            temp = {temp[0], temp[7:1]};
        end
    end
    assign out = temp;
endmodule
