module top_module (
    input clk,
    input reset,
    output [3:1] ena,
    output [15:0] q
);
    assign ena[1] = (q[3:0] == 4'd9) ? 1'b1 : 1'b0;
    assign ena[2] = (q[7:4] == 4'd9 && q[3:0] == 4'd9) ? 1'b1 : 1'b0;
    assign ena[3] = (q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd9) ? 1'b1 : 1'b0;
    
    CounterBCD counter0 (.clk(clk), .reset(reset), .ena(1'b1), .q(q[3:0]));
    CounterBCD counter1 (.clk(clk), .reset(reset), .ena(ena[1]), .q(q[7:4]));
    CounterBCD counter2 (.clk(clk), .reset(reset), .ena(ena[2]), .q(q[11:8]));
    CounterBCD counter3 (.clk(clk), .reset(reset), .ena(ena[3]), .q(q[15:12]));

endmodule

module CounterBCD (
    input clk,
    input reset,
    input ena,
    output [3:0] q
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000;
        end
        else if(ena) begin
            if(q == 4'd9) begin
                q <= 4'b0000;
            end
            else begin
                q <= q + 1;
            end
        end
    end
    
endmodule
