`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2023 10:13:40
// Design Name: 
// Module Name: tb_johnson_counter
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


module tb_johnson_counter();
    reg clk, reset;
    wire[3:0] out;
    
    johnson_counter DUT(out, clk, reset);
    
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        
        #20 reset = 0;
    end

endmodule
