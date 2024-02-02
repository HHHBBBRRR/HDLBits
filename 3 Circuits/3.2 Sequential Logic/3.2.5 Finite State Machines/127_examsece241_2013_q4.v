module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter S0 = 2'd0,
              S1 = 2'd1,
              S2 = 2'd2,
              S3 = 2'd3;

    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
            S0: if (s[1] == 1'b1) begin
                    next_state = S1;        
                end
                else begin
                    next_state = S0;
                end
            S1: if (s[2] == 1'b1 && s[1] == 1'b1) begin
                    next_state = S2;        
                end
                else if(s[1] == 1'b0) begin
                    next_state = S0;
                end
                else begin
                    next_state = S1;
                end
            S2: if (s[3] == 1'b1 && s[2] == 1'b1 && s[1] == 1'b1) begin
                    next_state = S3;         
                end
                else if(s[2] == 1'b0) begin
                    next_state = S1;
                end
                else begin
                    next_state = S2;
                end
            S3: if(s[3] == 1'b0) begin
                    next_state = S2;
                end
                else begin
                    next_state = S3;
                end
            default: next_state = S0;
        endcase
    end

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <=  S0;
        end
        else begin
            state <= next_state;
        end
    end
    
    reg lower;
    always @(posedge clk) begin
        if (reset || next_state > state) begin
            lower = 1'b0;
        end
        else if(next_state < state) begin
            lower = 1'b1;
        end
    end

    always @(*) begin
        case (state)
            S0: begin {fr3, fr2, fr1} = 3'b111; dfr = 1'b1; end
            S1: begin {fr3, fr2, fr1} = 3'b011; dfr = lower; end
            S2: begin {fr3, fr2, fr1} = 3'b001; dfr = lower; end
            S3: begin {fr3, fr2, fr1} = 3'b000; dfr = lower; end
        endcase
    end

endmodule
