`timescale 1ns / 1ps

module universal_shift_register(
    output reg[7:0] parallel_out,
    output serial_out_right, serial_out_left,
    input[7:0] parallel_input,
    input serial_in_right, serial_in_left,
    input[1:0] sel,
    input clk, reset
    );
    
    always@(posedge clk) begin
        if(reset) 
        parallel_out <= 8'b00000000;
        else begin
            case(sel) 
                2'b01: parallel_out <= {serial_in_right, parallel_out[7:1]};
                2'b10: parallel_out <= {parallel_out[6:0], serial_in_left};
                2'b11: parallel_out <= parallel_input;
                default: parallel_out <= parallel_out;
            endcase
        end
    end
    
    assign serial_out_right = parallel_out[0];
    assign serial_out_left = parallel_out[7];
    
endmodule
