`timescale 1ns / 1ps

module test_cla();
    reg i0, i1, i2, i3, i4, i5, i6, i7;
    reg u0, u1, u2, u3, u4, u5, u6, u7;
    reg cin, bool;
    wire[7:0] out;
    wire cout;
    integer i;
    
    CLA dut(
        o0, o1, o2, o3, o4, o5, o6, o7,
        cout,
        i0, i1, i2, i3, i4, i5, i6, i7,
        u0, u1, u2, u3, u4, u5, u6, u7,
        cin
    );
    
    initial begin
        cin = 0;
        for(i=0; i*3<256; i=i+16) begin
            #10
            {i7, i6, i5, i4, i3, i2, i1, i0} = i;
            {u7, u6, u5, u4, u3, u2, u1, u0} = i*2;
            cin = ~cin;
        end
    end
 
    assign out = {o7, o6, o5, o4, o3, o2, o1, o0};
    
    
endmodule
