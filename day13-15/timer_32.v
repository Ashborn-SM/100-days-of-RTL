`timescale 1ns / 1ps

module timer_32 (
        input[7:0]  TCR_VAL,
        input[31:0] PR_VAL,
        input[31:0] MR0_VAL, MR1_VAL, MR2_VAL, MR3_VAL,
        input[15:0] MCR_VAL,
        input       clk, reset
    );
    
    wire[7:0]       IR, TCR;
    wire[31:0]      PR, MR0, MR1, MR2, MR3;
    wire[15:0]      MCR;
    
    wire[31:0]      TC, PC;
    
    reg[7:0]        SET_IR, SET_TCR;
    
    reg             TC_RESET, PC_RESET;
    
    reg             COUNTER_ENABLE, COUNTER_RESET;
    
    reg             T_CLK, P_CLK;     
    
    register_N #(.SIZE(8)) INTERRUPT_REGISTER(IR, SET_IR, clk, reset);
    register_N #(.SIZE(8)) TIMER_CONTROL_REGISTER(TCR, SET_TCR, clk, reset);
    
    counter_32 TIMER_COUNTER(TC, T_CLK, TC_RESET);
    counter_32 PRESCALE_COUNTER(PC, P_CLK, PC_RESET);
    
    register_N #(.SIZE(32)) PRESCALE_REGISTER(PR, PR_VAL, clk, reset);
    
    register_N #(.SIZE(32)) MATCH_REGISTER_0(MR0, MR0_VAL, clk, reset);
    register_N #(.SIZE(32)) MATCH_REGISTER_1(MR1, MR1_VAL, clk, reset);
    register_N #(.SIZE(32)) MATCH_REGISTER_2(MR2, MR2_VAL, clk, reset);
    register_N #(.SIZE(32)) MATCH_REGISTER_3(MR3, MR3_VAL, clk, reset);

    register_N #(.SIZE(16)) MATCH_CONTROL_REGISTER(MCR, MCR_VAL, clk, reset);
    
    always@(TCR_VAL) begin
        if(reset) SET_TCR <= {8{1'b0}};
        else SET_TCR <= TCR_VAL;
    end

    // PRESCALER
    always@(posedge clk) begin
        if(reset || COUNTER_RESET) begin 
            PC_RESET <= 1'b1;
            T_CLK <= 1'b1;
            P_CLK <= 1'b1;
        end
        else if(COUNTER_ENABLE) begin
            P_CLK <= 1'b1;
            if(PC == PR) begin
                PC_RESET <= 1'b1;
                T_CLK <= 1'b1;
            end
        end
    end
    
    // TIMER
    always@(posedge clk) begin
        if(reset) begin
            SET_IR <= {8{1'b0}};
            TC_RESET <= 1'b1;
            COUNTER_ENABLE <= 1'b0;
            COUNTER_RESET <= 1'b0;  
        end
        else begin
            COUNTER_RESET <= SET_TCR[1];
            COUNTER_ENABLE <= SET_TCR[0];
            if(COUNTER_RESET) TC_RESET <= 1'b1;
            else if(COUNTER_ENABLE) begin
                TC_RESET <= 1'b0;
                
                if((TC == MR0)) begin
                    if(MCR[0]) SET_IR[0] <= 8'h1;
                    if(MCR[1] && (PC == PR)) TC_RESET <= 1'b1;
                    if(MCR[2]) begin 
                        SET_TCR[0] <= 1'b0;
                        COUNTER_ENABLE <= 1'b0; 
                        T_CLK <= 1'b0;
                        P_CLK <= 1'b0;
                    end
                end
                if((TC == MR1)) begin
                    if(MCR[3]) SET_IR[1] <= 8'h1;
                    if(MCR[4] && (PC == PR)) TC_RESET <= 1'b1;
                    if(MCR[5]) begin 
                        SET_TCR[0] <= 1'b0;
                        COUNTER_ENABLE <= 1'b0; 
                        T_CLK <= 1'b0;
                        P_CLK <= 1'b0;
                    end
                end
                if((TC == MR2)) begin
                    if(MCR[6]) SET_IR[2] <= 8'h1;
                    if(MCR[7] && (PC == PR)) TC_RESET <= 1'b1;
                    if(MCR[8]) begin 
                        SET_TCR[0] <= 1'b0;
                        COUNTER_ENABLE <= 1'b0; 
                        T_CLK <= 1'b0;
                        P_CLK <= 1'b0;
                    end
                end
                if((TC == MR3)) begin
                    if(MCR[9]) SET_IR[3] <= 8'h1;
                    if(MCR[10] && (PC == PR)) TC_RESET <= 1'b1;
                    if(MCR[11]) begin 
                        SET_TCR[0] <= 1'b0;
                        COUNTER_ENABLE <= 1'b0; 
                        T_CLK <= 1'b0;
                        P_CLK <= 1'b0;
                    end
                end
            end
        end            
    end
    
    // RESET
    always@(negedge clk) begin
        if(!reset && COUNTER_ENABLE && !COUNTER_RESET) begin
            TC_RESET <= 1'b0;
            PC_RESET <= 1'b0;
            T_CLK <= 1'b0;
            P_CLK <= 1'b0;
        end
    end
    
endmodule
