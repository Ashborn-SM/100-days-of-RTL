`timescale 1ns / 1ps

module HA(
    output s, c,
    input a, b
    );
    
    assign s = a ^ b;
    assign c = a & b;

endmodule

module FA(
    output s, cout,
    input a, b, cin
    );
    
    wire p, g, t;
    
    HA h(p, g, a, b);
    xor(s, p, cin);
    and(t, p, cin);
    or(cout, g, t);
        
endmodule

module braun_multiplier(
    output[7:0] o,
    input[3:0] i0, i1
    );

    wire a1b0, a0b1, a2b0, a1b1, a3b0, a2b1,
         a0b2, a1b2, a2b2, a3b1,
         a0b3, a1b3, a2b3, a3b2,
         a3b3;
    wire s0, s1, s3, s4, s5;
    wire c0, c1, c2, c3, c4, c5, c6, c7, c8, c9;
    
    and(o[0], i0[0], i1[0]);
    
    and(a1b0, i0[1], i1[0]);
    and(a0b1, i0[0], i1[1]);
    and(a2b0, i0[2], i1[0]);
    and(a1b1, i0[1], i1[1]);
    and(a3b0, i0[3], i1[0]);
    and(a2b1, i0[2], i1[1]);
    
    and(a0b2, i0[0], i1[2]);
    and(a1b2, i0[1], i1[2]);
    and(a2b2, i0[2], i1[2]);
    and(a3b1, i0[3], i1[1]);
    
    and(a0b3, i0[0], i1[3]);
    and(a1b3, i0[1], i1[3]);
    and(a2b3, i0[2], i1[3]);
    and(a3b2, i0[3], i1[2]);
    
    and(a3b3, i0[3], i1[3]);
    
    HA h1(o[1], c0, a1b0, a0b1);
    HA h2(s0, c1, a2b0, a1b1);
    HA h3(s1, c2, a3b0, a2b1);
    
    FA f1(o[2], c3, a0b2, s0, c0);
    FA f2(s2, c4, a1b2, s1, c1);
    FA f3(s3, c5, a2b2, a3b1, c2);
    
    FA f4(o[3], c6, a0b3, s2, c3);
    FA f5(s4, c7, a1b3, s3, c4);
    FA f6(s5, c8, a2b3, a3b2, c5);
    
    HA h4(o[4], c9, s4, c6);
    FA f7(o[5], c9, s5, c9, c7);
    FA f8(o[6], o[7], a3b3, c9, c8);
    
endmodule

