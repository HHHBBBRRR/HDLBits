module top_module(
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,   
    output done
); 
    parameter BYTE1 = 2'd0,
              BYTE2 = 2'd1,
              BYTE3 = 2'd2,
              DONE  = 2'd3;
    reg [1:0] state,next_state;

    always @(*) begin
        case (state)
            BYTE1 : if (in[3]) begin
                        next_state = BYTE2;
                    end
                    else begin
                        next_state = BYTE1;
                    end
            BYTE2 : next_state = BYTE3;
            BYTE3 : next_state = DONE;
            DONE :  if (in[3]) begin
                        next_state = BYTE2;
                    end
                    else begin
                        next_state = BYTE1;
                    end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= BYTE1;
        end
        else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if(state == BYTE1) begin
            out_bytes[23:16] <= in;
        end
        else if(state == BYTE2) begin
            out_bytes[15:8] <= in;
        end
        else if(state == BYTE3) begin
            out_bytes[7:0] <= in;
        end
        else begin
            out_bytes[23:16] <= in;
        end
    end

    assign done = (state == DONE);

endmodule
