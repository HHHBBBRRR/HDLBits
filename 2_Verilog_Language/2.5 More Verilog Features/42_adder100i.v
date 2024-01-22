module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum 
);
    Fulladder Adder0 (.A(a[0]), .B(b[0]), .CIN(cin), .S(sum[0]), .COUT(cout[0]));
    
    genvar i;
    generate for(i = 1; i < 100; i = i + 1) begin : ripple_adder
        Fulladder (.A(a[i]), .B(b[i]), .CIN(cout[i-1]), .S(sum[i]), .COUT(cout[i]));
    end
    endgenerate

endmodule

module Fulladder (
    input      CIN,
    input      A,B,
    output     S,
    output    COUT
);
    assign S = A ^ B ^ CIN;
    assign COUT = (A & B) | (A & CIN) |(B & CIN);
    
endmodule //Fulladder
