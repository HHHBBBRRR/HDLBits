module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] DFF;

    assign out = DFF[0];
    always @(posedge clk) begin
        if(!resetn) begin
            DFF <= 0;
        end
        else begin
            DFF <= {in,DFF[3:1]};
        end
    end

endmodule
