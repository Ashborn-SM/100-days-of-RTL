`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2023 08:01:48
// Design Name: 
// Module Name: slave
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

// P_CLK = 20MHz = 50ns
// S_CLK = 5MHz = 200ns
// SPI Mode = 3 (CPOL = 1 CPHA = 0)

module slave(
        input           P_CLK,      // Peripheral Clock
        input           reset,      // Master reset
        
        // SPI Interface
        input           S_CLK,      // Serial Clock
        input           i_SS,       // Slave Select (active low)
        input           i_MOSI,
        output reg      o_MISO, 
        
        // TX (MISO) Signals
        output reg      o_TX_READY, // Ready for next byte Transmission
        input[7:0]      i_TX_DATA,  // Data to be transmiited to master
        input[7:0]      i_TX_DV,    // To register i_TX_DATA (1 cc pulse)
        
        // RX (MOSI) Singals
        output reg      o_RX_DV,    // Data received pulse
        output reg[7:0] o_RX_DATA  // Received Data     
    );
    
    reg[2:0]        rx_counter;
    reg[2:0]        tx_counter;
    reg[7:0]        tx_data;
    
    // MOSI
    always@(posedge S_CLK, posedge i_SS) begin
        if(i_SS) begin
            o_RX_DV <= 1'b0;
            o_RX_DATA <= 8'h0;
            rx_counter <= 3'h0;
        end
        else begin
            o_RX_DV <= 1'b0;
            o_RX_DATA <= {o_RX_DATA[6:0], i_MOSI};
            rx_counter <= rx_counter + 1;
            if(rx_counter == 3'b111) o_RX_DV <= 1'b1;
        end 
    end
    
    // MISO
    always@(posedge S_CLK, posedge i_SS) begin
        if(i_SS) begin
            o_MISO <= tx_data[3'b111];
            tx_counter <= 3'b110;
            o_TX_READY <= 1'b0;
        end
        else begin
            o_MISO <= tx_data[tx_counter];
            tx_counter <= tx_counter - 1;
            if(tx_counter == 3'b000) o_TX_READY <= 1'b1;
        end
    end
    
    always@(posedge P_CLK, negedge reset) begin
        if(reset)  tx_data <= 8'h0;    
        else if(i_TX_DV) tx_data <= i_TX_DATA;
    end
    
    
endmodule
