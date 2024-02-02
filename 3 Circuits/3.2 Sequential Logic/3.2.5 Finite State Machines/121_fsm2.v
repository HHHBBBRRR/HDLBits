module top_module(
    input clk,
    input areset,
    input j,
    input k,
    output out
);  
    parameter OFF = 0, ON = 1; 
    reg state, next_state;

    always @(*) begin
        case (state)
            ON : if (k) begin
                next_state = OFF;
            end
            else begin
                next_state = ON;
            end
            OFF : if (j) begin
                next_state = ON;
            end
            else begin
                next_state = OFF;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
    end

    assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
