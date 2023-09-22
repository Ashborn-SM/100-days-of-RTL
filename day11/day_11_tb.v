`timescale 1ns / 1ps

module tb_barrel_shift();
    reg[7:0] in;
    reg[2:0] sel;
    wire[7:0] out;
    
    barrel_shifter dut(out, in, sel);
    
    initial begin 
        in = 8'haf;
        sel = 3'b011;
        
        #10 in = 8'h3f;
        sel = 3'b101;
        
        #10 in = 8'hfe;
        sel = 3'b011;
        
        #10 in = 8'h9f;
        sel = 3'b001;
    end
endmodule
