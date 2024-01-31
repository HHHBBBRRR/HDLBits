module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q 
); 
    integer i;

    always @(posedge clk) begin
        if (load == 1'b1) begin
            q <= data;
        end
        else begin
            q[0] <= q[0];
            q[511] <= (q[511] ^ q[510] ) || q[510];
            for (i = 1; i <= 510; i = i + 1) begin
                q[i] <= (q[i] ^ q[i - 1] ) || (~q[i+1] & q[i-1]); 
            end
        end
    end

endmodule
