module top_module(
    input clk,
    input in,
    input reset,
    output done
); 
    parameter IDLE = 0,
              START = 1,
              DATA = 2,
              STOP = 3,
              ERROR = 4;
    reg [2:0] state,next_state;
    reg [2:0] count;

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
                        if (in == 1) begin
                            next_state = STOP;
                        end
                        else begin
                            next_state = ERROR;
                        end
                    end
                    else begin
                        next_state = DATA;
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
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    assign done = (state == STOP) ? 1'b1 : 1'b0;

endmodule
