module top_module(
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
); 
    parameter IDLE  = 0,
              START = 1,
              DATA  = 2,
              CHECK = 3,
              STOP  = 4,
              ERROR = 5;
    reg [2:0] state, next_state;
    reg [2:0] count;
    reg [7:0] out_byte_r;

    always @(*) begin
        case (state)
            IDLE :  if (in == 1) begin
                        next_state = IDLE;
                    end
                    else begin
                        next_state = START;
                    end 
            START : next_state = DATA; 
            DATA  : if (count == 7) begin
                        if (^{out_byte_r, in} == 1) begin
                            next_state = CHECK;
                        end
                        else begin
                            next_state = ERROR;
                        end       
                    end
                    else begin
                        next_state = DATA;
                    end
            CHECK : if (in == 1) begin
                            next_state = STOP;
                        end
                        else begin
                            next_state = ERROR;
                        end
            STOP  : if (in == 1) begin
                        next_state = IDLE;
                    end
                    else begin
                        next_state = START;
                    end
            ERROR : if (in == 1) begin
                        next_state = IDLE;
                    end
                    else begin
                        next_state = ERROR;
                    end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end
        else if(state == START) begin
            count <= 0;
        end
        else if(state == DATA) begin
            count <= count + 1;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            out_byte_r <= 0;
        end
        else if(next_state == DATA) begin
            out_byte_r <= {in, out_byte_r[7:1]};
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    assign done = (state == STOP) ? 1'b1 : 1'b0;
	assign out_byte = (state == STOP) ? out_byte_r : 8'bx;

endmodule
