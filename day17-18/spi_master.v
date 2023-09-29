`timescale 1ns / 1ps

module spi
    #(
    // SPI_MODE = 0 --> CPOL = 0, CPHA = 0
    // SPI_MODE = 1 --> CPOL = 0, CPHA = 1
    // SPI_MODE = 2 --> CPOL = 1, CPHA = 0
    // SPI_MODE = 3 --> CPOL = 1, CPHA = 1
    
        parameter           SPI_MODE = 0,
                            CLOCK_DIVIDER = 4
    )
    (   
        input               P_clk,          // Peripheral clock
        input               reset,          // SPI reset
        
        // TX (MOSI) Signals
        input[7:0]          i_TX_DATA,      // Data to be transmitted on MOSI
        input               i_TX_DV,        // Data Valid pulse with i_TX_DATA(1 clock cycle)
        output reg          o_TX_READY,     // Transmit ready for next byte
        
        // RX (MISO) Signals
        output reg[7:0]     o_RX_DATA,      // Received Data at MISO
        output reg          o_RX_DV,        // Data Valid pulse(1 clock cycle)
        
        // SPI interface
        output reg          o_SCLK,         // Serial clock
        output reg          o_MOSI,         // Data out
        input               i_MISO          // Data in
);

    

    reg[$clog2(CLOCK_DIVIDER)-1:0]  sclk_counter;      
    wire                            CPOL, CPHA;
    reg                             rising_edge;
    reg                             falling_edge;
    reg[4:0]                        edge_counter;
    reg                             SPI_CLK;
    reg[2:0]                        tx_counter;
    reg[2:0]                        rx_counter;
    reg[7:0]                        tx_data;
    reg                             tx_dv;
    
    assign CPOL = (SPI_MODE & 2'b10) >> 1;
    assign CPHA = SPI_MODE & 2'b01;

    // Serial Clock
    always@(posedge P_clk, posedge reset) begin
        if(reset) begin
            o_TX_READY <= 1'b0;
            sclk_counter <= 4'h0;
            rising_edge <= 1'b0;
            falling_edge <= 1'b0;
            edge_counter <= 4'h0;
            SPI_CLK <= CPOL;
        end
        else begin
            rising_edge <= 1'b0;
            falling_edge <= 1'b0;
            if(i_TX_DV) begin
                o_TX_READY <= 1'b0;
                edge_counter <= 5'h10;
            end
            else if(edge_counter > 0) begin
                if(sclk_counter == CLOCK_DIVIDER-1) begin
                    falling_edge <= 1'b1;
                    SPI_CLK <= ~SPI_CLK;
                    edge_counter <= edge_counter - 1;
                    sclk_counter <= 1'b0;
                end
                if(sclk_counter == CLOCK_DIVIDER/2 - 1) begin
                    rising_edge <= 1'b1;
                    edge_counter <= edge_counter - 1;
                    sclk_counter <= sclk_counter + 1;
                    SPI_CLK <= ~SPI_CLK;    
                end
                else sclk_counter <= sclk_counter + 1;
            end
            else o_TX_READY <= 1'b1;
        end
    end
    
    always@(posedge P_clk, posedge reset) begin
        if(reset) o_SCLK <= CPOL;
        else o_SCLK <= SPI_CLK;
    end
    
    // Store data
    always@(posedge P_clk, posedge reset) begin
        if(reset) tx_data <= 8'h0;
        else begin
            tx_dv <= i_TX_DV;
            if(i_TX_DV) tx_data <= i_TX_DATA;
        end
    end
    
    // MOSI
    always@(posedge P_clk, posedge reset) begin
        if(reset) begin
            tx_counter <= 3'b000;
            o_MOSI <= 1'b0;
        end
        else begin
            if(o_TX_READY) tx_counter <= 3'b111; 
            else if(tx_dv & ~CPHA) begin
                o_MOSI <= tx_data[3'b111];
                tx_counter <= 3'b110;
            end
            else if((rising_edge & CPHA) | (falling_edge & ~CPHA)) begin
                tx_counter <= tx_counter - 1;
                o_MOSI <= tx_data[tx_counter];
            end  
        end
    end
    
     

endmodule
