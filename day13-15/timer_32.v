`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2023 18:46:51
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


module timer_32 (
        input[7:0]  TCR_VAL,
        input[31:0] PR_VAL,
        input[31:0] MR0_VAL, MR1_VAL, MR2_VAL, MR3_VAL,
        input[15:0] MCR_VAL,
        input       clk, reset
    );
    
    wire[7:0]       IR, TCR;
    wire[31:0]      MR0, MR1, MR2, MR3;
    wire[15:0]      MCR;
    
    reg[7:0]        SET_IR, SET_TCR;
    
    reg             TC_RESET, PC_RESET;
    reg             SET_TC_RESET, SET_PC_RESET;
    
    reg             COUNTER_ENABLE, COUNTER_RESET;
    
    reg             TIMER_CLK;
    reg             SET_TIMER_CLK;
    
    reg             TIMER_MATCH;
    
    register_N #(.SIZE(8)) INTERRUPT_REGISTER(IR, SET_IR, clk, reset);
    register_N #(.SIZE(8)) TIMER_CONTROL_REGISTER(TCR, SET_TCR, clk, reset);
    
    counter_32 TIMER_COUNTER(TC, TIMER_CLK, TC_RESET);
    counter_32 PRESCALE_COUNTER(PC, clk, PC_RESET);
    
    register_N #(.SIZE(32)) PRESCALE_REGISTER(PR, PR_VAL, clk, reset);
    
    register_N #(.SIZE(32)) MATCH_REGISTER_0(MR0, MR0_VAL, clk, reset);
    register_N #(.SIZE(32)) MATCH_REGISTER_1(MR1, MR1_VAL, clk, reset);
    register_N #(.SIZE(32)) MATCH_REGISTER_2(MR2, MR2_VAL, clk, reset);
    register_N #(.SIZE(32)) MATCH_REGISTER_3(MR3, MR3_VAL, clk, reset);

    register_N #(.SIZE(16)) MATCH_CONTROL_REGISTER(MCR, MCR_VAL, clk, reset);
    
    always@(posedge clk, posedge reset) begin
        if(reset) begin
            TC_RESET <= 1'b1;
            PC_RESET <= 1'b1;
            SET_IR <= {8{1'b0}};
        end
        else begin
           SET_TCR <= TCR_VAL;
           COUNTER_ENABLE <= TCR[0];
           COUNTER_RESET <= TCR[1]; 
           TC_RESET <= SET_TC_RESET;
           PC_RESET <= SET_PC_RESET;
           TIMER_CLK <= SET_TIMER_CLK;
        end
    end
    
    // PRESCALER
    always@(posedge clk) begin
        if(COUNTER_RESET) begin
            SET_TC_RESET <= 1'b1;
            SET_PC_RESET <= 1'b1;
        end
        else if(COUNTER_ENABLE) begin
            SET_TC_RESET <= 1'b0;
            SET_PC_RESET <= 1'b0;
            SET_IR <= {8{1'b0}};
            SET_TIMER_CLK <= 1'b0;
            
            if(PC == PR) begin
                SET_TIMER_CLK <= 1'b1;
                SET_PC_RESET <= 1'b1;
            end
        end
    end
    
    // TIMER
    always@(posedge clk) begin
         if((TC == MR0) && (MCR[0])) SET_IR[0] <= 1'b1;
         if((TC == MR1) && (MCR[3])) SET_IR[1] <= 1'b1;
         if((TC == MR2) && (MCR[6])) SET_IR[2] <= 1'b1;
         if((TC == MR3) && (MCR[9])) SET_IR[3] <= 1'b1;
         SET_TC_RESET <= |{MCR[1], MCR[4], MCR[7], MCR[10]};
         SET_TCR[0] <= |{MCR[2], MCR[5], MCR[8], MCR[11]};
    end
    
endmodule
