`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2023 22:03:02
// Design Name: 
// Module Name: timer_32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module timer_32 
    #(
        parameter IR_VAL = 0, TCR_VAL = 0, 
                    TC_VAL = 0, PR_VAL = 0, PC_VAL = 0,
                    MR0_VAL = 0, MR1_VAL = 0, MR2_VAL = 0,
                    MCR_VAL = 0
     )
     (
        
     );
    
    register_N #(.SIZE(8)) INTERRUPT_REGISTER(IR, IR_VAL, clk, reset);
    register_N #(.SIZE(8)) TIMER_CONTROL_REGISTER(TCR, TCR_VAL, clk, reset);
    
    register_N #(.SIZE(32)) TIMER_COUNTER(TC, TC_VAL, clk, reset);
    register_N #(.SIZE(32)) PRESCALE_REGISTER(PR, PR_VAL, clk, reset);
    register_N #(.SIZE(32)) PRESCALE_COUNTER(PC, PC_VAL, clk, reset);
    register_N #(.SIZE(32)) MATCH_REGISTER_0(MR0, MR0_VAL, clk, reset);
    register_N #(.SIZE(32)) MATCH_REGISTER_1(MR1, MR1_VAL, clk, reset);
    register_N #(.SIZE(32)) MATCH_REGISTER_2(MR2, MR2_VAL, clk, reset);

    register_N #(.SIZE(16)) MATCH_CONTROL_REGISTER(MCR, MCR_VAL, clk, reset);
    
    
endmodule
