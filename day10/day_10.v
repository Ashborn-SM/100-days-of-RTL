`timescale 1ns / 1ps

module barrel_shifter_8(
    output[7:0] out,
    input[7:0] in, 
    input[2:0] sel
    );
    
    reg[7:0] temp;
    
    always@(*) begin
        case(sel) 
            3'b000: temp = in << 0;
            3'b001: temp = in << 1;
            3'b010: temp = in << 2;
            3'b011: temp = in << 3;
            3'b100: temp = in << 4;
            3'b101: temp = in << 5;
            3'b110: temp = in << 6;
            3'b111: temp = in << 7;
            default: temp = in;
        endcase
    end
    
    assign out = temp;
endmodule
