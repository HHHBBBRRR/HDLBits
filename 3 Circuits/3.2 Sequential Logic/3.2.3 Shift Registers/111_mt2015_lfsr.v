module top_module (
	input [2:0] SW,
	input [1:0] KEY,
	output [2:0] LEDR
);
    wire Q0,Q1,Q2,temp;
    assign temp = Q1 ^ Q2;
    assign LEDR = {Q2,Q1,Q0};

    muxdff dff0 (.clk(KEY[0]), .L(KEY[1]), .r_in(SW[0]), .q_in(Q2), .Q(Q0));
    muxdff dff1 (.clk(KEY[0]), .L(KEY[1]), .r_in(SW[1]), .q_in(Q0), .Q(Q1));
    muxdff dff2 (.clk(KEY[0]), .L(KEY[1]), .r_in(SW[2]), .q_in(temp), .Q(Q2));

endmodule

module muxdff (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q
);
    wire wire1;

    assign wire1 = L ? r_in : q_in;

    always @(posedge clk) begin
        Q <= wire1;
    end

endmodule
