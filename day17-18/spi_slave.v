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
        output reg      o_TX_DV,    // Finished transmission
        input[7:0]      i_TX_DATA,  // Data to be transmiited to master
        input           i_TX_DV,    // To register i_TX_DATA (1 cc pulse)
        
        // RX (MOSI) Singals
        output reg      o_RX_DV,    // Data received pulse
        output reg[7:0] o_RX_DATA  // Received Data     
    );
    
    reg[2:0]        rx_counter;
    reg[2:0]        tx_counter;
    reg[7:0]        tx_data;
    reg[7:0]        rx_data;
    reg             r_MISO;
    reg             r_TX_DV;
    reg             r_RX_DV;
    reg             begin_TX;
    reg             delay_0;
    reg[1:0]        begin_counter;
    reg             r_MISO;
    reg             r2_RX_DV;
    
    //  MISO
    always@(posedge S_CLK, negedge delay_0) begin
        if(begin_TX) begin
            tx_counter <= 3'b110;
            o_MISO <= tx_data[3'b111];
            r_TX_DV <= 1'b0;
        end
        else begin
            r_TX_DV <= 1'b0;
            o_MISO = tx_data[tx_counter];
            tx_counter <= tx_counter - 1;
            if(tx_counter == 3'b000) r_TX_DV <= 1'b1;
        end
    end
    
    always@(negedge P_CLK) begin
        if(~i_SS & delay_0) begin_TX <= 1'b1;
        else begin_TX <= 1'b0;
    end

    always@(posedge P_CLK, posedge reset) begin
        if(reset) begin
            tx_data <= 8'h0;
            o_TX_DV <= 1'b0;
            o_RX_DATA <= 8'h0;
        end
        else begin
            delay_0 <= i_SS;
            if(i_TX_DV) tx_data <= i_TX_DATA;    
            o_TX_DV <= (i_SS | begin_TX)? 1'b0: r_TX_DV;
            r2_RX_DV <= r_RX_DV;
            o_RX_DV <= i_SS? 1'b0: r2_RX_DV;
            o_RX_DATA <= i_SS? o_RX_DATA: rx_data;
        end
    end
    
    // MOSI
    always@(negedge S_CLK, posedge i_SS) begin
        if(i_SS) begin
            rx_counter <= 3'b111;
            rx_data <= 8'h0;
            r_RX_DV <= 1'b0;
        end
        else begin
            r_RX_DV <= 1'b0;
            rx_counter <= rx_counter - 1;
            rx_data <= {rx_data[6:0], i_MOSI};
            if(rx_counter === 3'b000) r_RX_DV <= 1'b1;
        end
    end
    
endmodule
