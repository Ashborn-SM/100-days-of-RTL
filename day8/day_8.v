`timescale 1ns / 1ps

module sequence_detector_1101(
    output reg out,
    input in, clk, reset
    );
    
    localparam integer s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011;
    reg set_output;
    reg[2:0] present_state, next_state;
    
    always@(posedge clk) begin
        if(reset) present_state <= s0;
        else begin 
            present_state <=  next_state;
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
                    if(in) next_state = s2;
                    else next_state = s0;
                end
            s2: begin 
                    if(in) next_state = s2;
                    else next_state = s3;
                end
            s3 : next_state = s0;
            default: next_state = s0;
        endcase
    end
    
    always@(present_state, in) begin
        case(present_state) 
           s0: set_output = 0; 
           s1: set_output = 0; 
           s2: set_output = 0; 
           s3: begin
               if(in) set_output = 1;
               else set_output = 0;
               end 
           default: set_output = 0; 
        endcase
    end
        
endmodule
