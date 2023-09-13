`timescale 1ns / 1ps

module test_braun();
    reg[3:0] i0, i1;
    wire[7:0] out;
    integer i;
    
    braun_multiplier DUT(out, i0, i1);
    
    initial begin
        for(i=0; i<16; i=i+1) begin
            #10
            i0 = i;
            i1 = i;
        end
    end


endmodule
