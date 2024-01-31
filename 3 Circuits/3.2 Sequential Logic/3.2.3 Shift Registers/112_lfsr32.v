module top_module(
    input clk,
    input reset,
    output [31:0] q
); 
    wire tag1, tag2, tag3, tag4;

    assign tag1 = q[1] ^ q[0];
    assign tag2 = q[2] ^ q[0];
    assign tag3 = q[22] ^ q[0];
    assign tag4 = q[0] ^ 1'b0;

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end
        else begin
            q <= {tag4,q[31:23],tag3,q[21:3],tag2,tag1};
        end
    end

endmodule
