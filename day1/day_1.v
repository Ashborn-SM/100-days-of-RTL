`timescale 1ns / 1ps

module adder(
    output p, g, o,
    input a, b, c
    );
    
    xor(p, a, b);
    xor(o, p, c);
    and(g, a, b);
   
endmodule

module CLA(
    output o0, o1, o2, o3, o4, o5, o6, o7,
    output c8,
    input i0, i1, i2, i3, i4, i5, i6, i7,
    input u0, u1, u2, u3, u4, u5, u6, u7,
    input c0
    );
    
    wire c1, c2, c3, c4, c5, c6, c7;
    wire p0, p1, p2, p3, p4, p5, p6, p7;
    wire g0, g1, g2, g3, g4, g5, g6, g7;
    
    adder a0(p0, g0, o0, i0, u0, c0);
    adder a1(p1, g1, o1, i1, u1, c1);
    adder a2(p2, g2, o2, i2, u2, c2);
    adder a3(p3, g3, o3, i3, u3, c3);
    adder a4(p4, g4, o4, i4, u4, c4);
    adder a5(p5, g5, o5, i5, u5, c5);
    adder a6(p6, g6, o6, i6, u6, c6);
    adder a7(p7, g7, o7, i7, u7, c7);
    
    assign c1 = g0 | (p0 & c0);
    assign c2 = g1 | (p1 & g0) | (p1 & p0 & c0);
    assign c3 = g2 | (p2 & (g1 | (p1 & g0) | (p1 & p0 & c0)));
    assign c4 = g3 | (p3 & (g2 | (p2 & (g1 | (p1 & g0) | (p1 & p0 & c0)))));
    assign c5 = g4 | (p4 & (g3 | (p3 & (g2 | (p2 & (g1 | (p1 & g0) | (p1 & p0 & c0)))))));
    assign c6 = g5 | (p5 & (g4 | (p4 & (g3 | (p3 & (g2 | (p2 & (g1 | (p1 & g0) | (p1 & p0 & c0)))))))));
    assign c7 = g6 | (p6 & (g5 | (p5 & g4 | (p4 & (g3 | (p3 & (g2 | (p2 & (g1 | (p1 & g0) | (p1 & p0 & c0))))))))));
    assign c8 = g7 | (p7 & (g6 | (p6 & (g5 | (p5 & g4 | (p4 & (g3 | (p3 & (g2 | (p2 & (g1 | (p1 & g0) | (p1 & p0 & c0))))))))))));
    
endmodule
