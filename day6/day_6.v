`timescale 1ns / 1ps

module palindrome_detector
    #(parameter BITS = 4)(
        output out,
        input in, clk, reset
    );
    
    localparam integer counter_size = $clog2(BITS);
    localparam integer half_size = BITS/2;
    
    reg[BITS-1:0] time_t;
    reg[counter_size-1:0] counter;
    reg[half_size-1: 0] cmp_1;
    reg[half_size-1: 0] cmp_2;
    reg set;

    integer i;
    
    always@(posedge clk) begin
        if(reset) begin
            time_t <= {BITS{1'b0}};
            counter <= {half_size{1'b0}};
            set <= 1'b0;
            cmp_1 <= {half_size{1'b0}};
            cmp_2 <= {half_size{1'b0}};
        end
        else begin
            time_t = {time_t[BITS-1-1:0], in};
            counter <= (counter == BITS-1)? counter: counter + 1;
        end
    end
    
    always@(*) begin
        if(counter == BITS-1) begin
            cmp_2 = time_t[half_size-1: 0];
            if(BITS&1) cmp_1 = time_t[BITS-1: half_size+1];
            else cmp_1 = time_t[BITS-1: half_size];
            for(i = 0; i<half_size; i = i + 1) cmp_2[i] = time_t[half_size-1-i];
            set = cmp_2 == cmp_1;
        end
    end
    
    assign out = set;
    
endmodule
