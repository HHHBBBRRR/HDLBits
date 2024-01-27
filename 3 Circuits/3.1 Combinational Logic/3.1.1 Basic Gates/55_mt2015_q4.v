module top_module (
    input x, 
    input y, 
    output z
);
    wire ia1_out,ia2_out,ib1_out,ib2_out;

    A IA1 (.x(x), .y(y), .z(ia1_out));
    A IA2 (.x(x), .y(y), .z(ia2_out));
    B IB1 (.x(x), .y(y), .z(ib1_out));
    B IB2 (.x(x), .y(y), .z(ib2_out));

    assign z = ((ia1_out | ib1_out) ^ (ia2_out & ib2_out));

endmodule

module A (
    input x, 
    input y, 
    output z
);
    assign z = (x ^ y) & x;

endmodule

module B ( 
    input x, 
    input y, 
    output z
);
    assign z = x ~^ y;

endmodule
