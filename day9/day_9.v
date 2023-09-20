`timescale 1ns / 1ps

module multiplier_8x8(
    output[15:0] out,
    input[7:0] a, b
);

    wire[7:0] l0, l1, l2, l3;
    wire c0, c1, c3;
    wire[7:0] m0, m1;
    
    braun_multiplier bm_0(l0, a[3:0], b[3:0]);
    braun_multiplier bm_1(l1, a[3:0], b[7:4]);
    braun_multiplier bm_2(l2, a[7:4], b[3:0]);
    braun_multiplier bm_3(l3, a[7:4], b[7:4]);
    
    CLA c_0(
            m0[0], m0[1], m0[2], m0[3], m0[4], m0[5], m0[6], m0[7],
            c0,
            l1[0], l1[1], l1[2], l1[3], l1[4], l1[5], l1[6], l1[7],
            l2[0], l2[1], l2[2], l2[3], l2[4], l2[5], l2[6], l2[7],
            0
    );
    
    CLA c_1(
            out[4], out[5], out[6], out[7], m1[4], m1[5], m1[6], m1[7],
            c1,
            l0[4], l0[5], l0[6], l0[7], 0, 0, 0, 0, 
            m0[0], m0[1], m0[2], m0[3], m0[4], m0[5], m0[6], m0[7],
            0
    );
    
    CLA c_2(
            out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15],
            c3,
            m1[4], m1[5], m1[6], m1[7], c0, 0, 0, 0,
            l3[0], l3[1], l3[2], l3[3], l3[4], l3[5], l3[6], l3[7],
            0
    );
    
    assign out[3:0] = l0[3:0];

endmodule
