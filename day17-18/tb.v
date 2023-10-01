`timescale 1ns / 1ps

module tb();
    reg P_CLK, reset; 
    
    wire o_MISO;
    wire o_TX_READY;
    wire[7:0] o_RX_DATA;
    reg[7:0] i_TX_DATA;
    reg i_TX_DV;
    wire o_RX_DV;
    
    reg[7:0] i_TX_DATA_S;
    wire[7:0] o_RX_DATA_S;
    reg i_TX_DV_S;
    wire o_TX_READY_S, o_RX_DV_S, o_SCLK;
    wire CS;
    wire o_MOSI;
    
    slave dut1(P_CLK, reset, o_SCLK, CS, o_MOSI, o_MISO, o_TX_READY, i_TX_DATA, i_TX_DV, o_RX_DV, o_RX_DATA);
    spi dut2(P_CLK, reset, i_TX_DATA_S, i_TX_DV_S, o_TX_READY_S, o_RX_DATA_S, o_RX_DV_S, o_SCLK, o_MOSI, o_MISO, CS);
    
    always #100 P_CLK = ~P_CLK;
    initial begin
        P_CLK = 1;
        reset = 1;
        i_TX_DATA = 8'hZ;
        i_TX_DV = 1'bZ;
        
        i_TX_DATA_S = 8'hz;
        i_TX_DV_S = 1'bz;
        
        #300 i_TX_DATA = 8'hae;
        reset = 0;
        i_TX_DV = 1'b1;
        #200 i_TX_DV = 1'b0;
        #200 i_TX_DV_S = 1'b1;
        i_TX_DATA_S = 8'hb5;
        #200 i_TX_DV_S = 1'b0;
    end
    
endmodule
