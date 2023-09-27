`timescale 1ns / 1ps

module mux(
        output out,
        input  a, b, c, d,
        input[1:0] sel
    );
    reg o;
    always@(*) begin
        case(sel)
            2'b00: o = a;
            2'b01: o = b;
            2'b10: o = c;
            2'b11: o = d;
            default: o = 0;
        endcase
    end
    
    assign out = o;
    
endmodule
