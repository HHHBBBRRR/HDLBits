module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out
);
    parameter A = 0, 
    		  B = 1, 
    		  C = 2 , 
    		  D = 3;

    assign next_state[A] = (state[A] & ~in) || (state[C] & ~in);
    assign next_state[B] = (state[A] & in) || (state[D] & in) || (state[B] & in);
    assign next_state[C] = (state[B] & ~in) || (state[D] & ~in);
    assign next_state[D] = state[C] & in;

    always @(*) begin
        if (state[D] == 1'b1) begin
            out = 1;
        end
        else begin
            out = 0;
        end
    end

endmodule
