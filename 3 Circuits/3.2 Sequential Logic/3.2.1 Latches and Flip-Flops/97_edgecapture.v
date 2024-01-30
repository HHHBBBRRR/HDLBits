module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_dly;
    wire [31:0] capture;

    always @(posedge clk) begin
        in_dly <= in;
    end

    assign capture = in_dly & ~in;

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            out <= 32'b0;
        end
        else begin
            out <= capture | out;
        end
    end

endmodule
