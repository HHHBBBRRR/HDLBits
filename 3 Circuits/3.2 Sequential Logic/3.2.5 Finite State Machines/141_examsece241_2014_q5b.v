module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A = 2'b01,
              B = 2'b10;
    reg [1:0] state,next_state;

    always @(*) begin
        case (state)
            A : if (x) begin
                    next_state = B;
                end
                else begin
                    next_state = A;
                end
            B : if (x) begin
                    next_state = B;
                end
                else begin
                    next_state = B;
                end 
            default: next_state = A;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            A : if (x) begin
                z = 1'b1;
            end
            else begin
                z = 1'b0;
            end
            B : if (x) begin
                z = 1'b0;
            end
            else begin
                z = 1'b1;
            end
        endcase
    end

endmodule
