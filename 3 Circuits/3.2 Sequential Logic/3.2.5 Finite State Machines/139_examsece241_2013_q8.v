module top_module (
    input clk,
    input aresetn,
    input x,
    output z
); 
    parameter s0 = 2'b00,
              s1 = 2'b01,
              s2 = 2'b11;
    reg [1:0] state,next_state;

    always @(*) begin
        case (state)
            s0: if (x == 1'b1) begin
                    next_state = s1;
                end
                else begin
                    next_state = s0;
                end
            s1: if (x == 1'b1) begin
                    next_state = s1;
                end
                else begin
                    next_state = s2;
                end
            s2: if (x == 1'b1) begin
                    next_state = s1;
                end
                else begin
                    next_state = s0;
                end
            default: next_state = s0;
        endcase
    end

    always @(posedge clk or negedge aresetn) begin
        if(!aresetn) begin
            state <= s0;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        if (state == s2 && x == 1'b1) begin
            z = 1'b1;
        end
        else begin
            z = 1'b0;
        end
    end

endmodule
