module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min
);
    always @(*) begin
        reg [7:0]r1,r2;

        if (a < b) begin
            r1 = a;
        end
        else begin
            r1 = b;
        end

        if (c < d) begin
            r2 = c;
        end
        else begin
            r2 = d;
        end

        if (r1 < r2) begin
            min = r1;
        end
        else begin
            min = r2;
        end
    end

endmodule
