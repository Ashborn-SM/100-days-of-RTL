`timescale 1ns / 1ps

module sequence_detector_10101(
    output reg out,
    input in, clk, reset
);

    reg[3:0] s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011,
        s4 = 3'b100;
    reg[2:0] present_state, next_state;
    reg set_output;

    always@(posedge clk) begin
        if(reset) begin
            present_state <= 3'b000;
            next_state <= 3'b000;
            set_output <= 1'b0;
        end
        else begin
            present_state <= next_state;
            out <= set_output;
        end
    end
    
    always@(present_state, in) begin
        case(present_state) 
             s0: begin
                if(in) next_state = s1;
                else next_state = s0;
                end
             s1: begin
                if(in) next_state = s1;
                else next_state = s2;
                end
             s2: begin
                if(in) next_state = s3;
                else next_state = s0;
                end
             s3: begin
                if(in) next_state = s1;
                else next_state = s4;
                end
             s4: begin
                if(in) next_state = s3;
                else next_state = s0;
                end         
             default: next_state = s0;   
        endcase
    end
    
    always@(present_state, in) begin
        case(present_state)
            s0: set_output = 0;
            s1: set_output = 0;
            s2: set_output = 0;
            s3: set_output = 0;
            s4: begin if(in) set_output = 1;
                      else set_output = 0;
                end
        endcase
    end 

endmodule
