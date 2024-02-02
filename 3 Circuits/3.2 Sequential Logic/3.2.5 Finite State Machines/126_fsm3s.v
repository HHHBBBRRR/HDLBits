module top_module(
    input clk,
    input in,
    input reset,
    output out
);
    parameter A=0,B=1,C=2,D=3;
    reg [1:0] state,next_state;

    always begin
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

    always @(posedge clk) begin
        if(reset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    always begin
        if (state == D) begin
            out = 1'b1;
        end
        else begin
            out = 1'b0;
        end
    end

endmodule
