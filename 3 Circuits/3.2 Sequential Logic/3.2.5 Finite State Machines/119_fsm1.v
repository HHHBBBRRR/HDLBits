module top_module(
    input clk,
    input areset,
    input in,
    output out
);  
    parameter A = 0, B = 1; 
    reg state, next_state;

    always @(*) begin
        if (state == A) begin
            if (in == 1'b1) begin
                next_state = A;
            end
            else begin
                next_state = B;
            end
        end
        else begin
            if (in == 1'b1) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
    end

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state = B;
        end
        else begin
            state = next_state;
        end
    end

    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
