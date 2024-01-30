module top_module (
    input clk,
    input d,
    output q
);
    reg pos_edge,neg_edge;

    always @(posedge clk) begin
        pos_edge <= d;
    end

    always @(negedge clk) begin
        neg_edge <= d;
    end

    assign q = clk ? pos_edge : neg_edge;
    
endmodule
