module top_module (
    input clk,
    input x,
    output z
); 
    wire wire1,wire2,wire3;
    reg Q1 = 1'b0;
    reg Q2 = 1'b0;
    reg Q3 = 1'b0;

    assign wire1 = x ^ Q1;
    assign wire2 = x & ~Q2;
    assign wire3 = x | ~Q3;

    always @(posedge clk) begin
        Q1 <= wire1;
    end
    always @(posedge clk) begin
        Q2 <= wire2;
    end
    always @(posedge clk) begin
        Q3 <= wire3;
    end

    assign z = ~(Q1|Q2|Q3);

endmodule
