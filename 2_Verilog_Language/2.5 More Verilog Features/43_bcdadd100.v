module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum 
);
    wire [399:0] cout_temp;

    bcd_fadd add0 (.a(a[3:0]), .b(b[3:0]), .cout(cout_temp[0]), .cin(cin), .sum(sum[3:0]));

    genvar i;
    generate for(i = 4 ; i < 400; i = i + 4) begin : U
        bcd_fadd (.a(a[i+3:i]), .b(b[i+3:i]), .cout(cout_temp[i]), .cin(cout_temp[i-4]), .sum(sum[i+3:i]));
    end
    endgenerate

    assign cout = cout_temp[396];
    
endmodule
