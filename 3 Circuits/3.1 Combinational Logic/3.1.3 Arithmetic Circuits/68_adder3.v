module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum 
);
    Adder adder0 (.cout(cout[0]), .sum(sum[0]), .a(a[0]), .b(b[0]), .cin(cin));
    Adder adder1 (.cout(cout[1]), .sum(sum[1]), .a(a[1]), .b(b[1]), .cin(cout[0]));
    Adder adder2 (.cout(cout[2]), .sum(sum[2]), .a(a[2]), .b(b[2]), .cin(cout[1]));

endmodule

module Adder( 
    input a, b, cin,
    output cout, sum
);
    assign {cout,sum} = a + b + cin;

endmodule
