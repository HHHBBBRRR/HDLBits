module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire carry;
    wire [15:0] s1,s2;

    add16 adder1 (.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(carry));
    add16 adder2 (.a(a[31:16]), .b(b[31:16]), .cin(1'b0), .sum(s1));
    add16 adder3 (.a(a[31:16]), .b(b[31:16]), .cin(1'b1), .sum(s2));

    always @(*) begin
        if (carry == 1'b0) begin
            sum[31:16] = s1;
        end
        else begin
            sum[31:16] = s2;
        end
    end

endmodule
