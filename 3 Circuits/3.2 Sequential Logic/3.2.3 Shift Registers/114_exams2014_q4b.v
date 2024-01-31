module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
    wire [3:0] Q;
    
    MUXDFF dff0 (.clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(Q[1]), .R(SW[0]), .Q(Q[0]));
    MUXDFF dff1 (.clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(Q[2]), .R(SW[1]), .Q(Q[1]));
    MUXDFF dff2 (.clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(Q[3]), .R(SW[2]), .Q(Q[2]));
    MUXDFF dff3 (.clk(KEY[0]), .E(KEY[1]), .L(KEY[2]), .w(KEY[3]), .R(SW[3]), .Q(Q[3]));
    
    assign LEDR = Q;

endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    wire wire1,wire2;

    assign wire1 = E ? w : Q;
    assign wire2 = L ? R : wire1;
    
    always @(posedge clk) begin
        Q <= wire2;
    end
    
endmodule
