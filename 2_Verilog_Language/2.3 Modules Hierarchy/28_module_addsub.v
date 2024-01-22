module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] notb;
    wire carry;
    
    assign notb = b ^ {32{sub}};
    
    add16 adder1 (.a(a[15:0]), .b(notb[15:0]), .cin(sub), .sum(sum[15:0]), .cout(carry));
    add16 adder2 (.a(a[31:16]), .b(notb[31:16]), .cin(carry), .sum(sum[31:16]));

endmodule
