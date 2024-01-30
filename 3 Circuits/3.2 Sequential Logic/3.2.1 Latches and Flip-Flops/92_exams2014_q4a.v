module top_module (
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
