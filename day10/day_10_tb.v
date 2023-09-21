`timescale 1ns / 1ps

module tb_barrel();
    reg[7:0] in;
    reg[2:0] sel;
    wire[7:0] out;
    
    barrel_shifter_8 dut(out, in, sel);
    
    initial begin
        #10
        sel = 3'b100;
        in = 8'b1;
        #10
        sel = 3'b111;
        in = 8'b1;
        #10
        sel = 3'b110;
        in = 8'b1;
        #10
        sel = 3'b101;
        in = 8'b1;
        #10
        sel = 3'b010;
        in = 8'b1;
        #10
        sel = 3'b001;
        in = 8'b1;
    end

endmodule
