module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out
);
    parameter A = 0, 
    		  B = 1, 
    		  C = 2, 
    		  D = 3;
    
    always @(*) begin
        case (state)
            A : if (in) begin
                    next_state = B;
                end
                else begin
                    next_state = A;
                end
            B : if (in) begin
                    next_state = B;
                end
                else begin
                    next_state = C;
                end
            C : if (in) begin
                    next_state = D;
                end
                else begin
                    next_state = A;
                end
            D : if (in) begin
                    next_state = B;
                end
                else begin
                    next_state = C;
                end
        endcase
    end

    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
