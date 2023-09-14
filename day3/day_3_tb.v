`timescale 1ns / 1ps

module day_3_tb();
    reg[7:0] parallel_input;
    reg serial_in_right, serial_in_left, clk, reset;
    reg[1:0] sel;
    wire[7:0] parallel_output;
    wire serial_out_right, serial_out_left;
  
    universal_shift_register dut(parallel_output, serial_out_right, serial_out_left, parallel_input, serial_in_right,
                                 serial_in_left, sel, clk ,reset);
  
  always #10 clk = ~clk;
  initial begin
   
    clk = 0; 
    reset = 1;
    
    #20 reset = 0;
    
    parallel_input = 8'b10101101;
    serial_in_left = 1'b0;
    serial_in_right = 1'b0;
    
    #20 sel = 2'b11;
    #20 sel = 2'b00;
    #20 sel = 2'b01;
    #20 sel = 2'b10; 
    
  end

   
endmodule
