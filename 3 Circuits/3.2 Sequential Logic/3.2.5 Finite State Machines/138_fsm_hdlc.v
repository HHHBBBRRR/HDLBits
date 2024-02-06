module top_module(
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err
);
    parameter   NONE  = 0,
                ONE   = 1,
                TWO   = 2,
                THREE = 3,
                FOUR  = 4,
                FIVE  = 5,
                SIX   = 6,
                DISC  = 7,
                FLAG  = 8,
                ERROR = 9;
    
    reg [3:0] state, next_state;

    always @(*) begin
        case (state)
            NONE :  if (in) begin
                        next_state = ONE;
                    end
                    else begin
                        next_state = NONE;
                    end
            ONE  :  if (in) begin
                        next_state = TWO;
                    end
                    else begin
                        next_state = NONE;
                    end
            TWO :  if (in) begin
                        next_state = THREE;
                    end
                    else begin
                        next_state = NONE;
                    end
            THREE :  if (in) begin
                        next_state = FOUR;
                    end
                    else begin
                        next_state = NONE;
                    end
            FOUR :  if (in) begin
                        next_state = FIVE;
                    end
                    else begin
                        next_state = NONE;
                    end
            FIVE :  if (in) begin
                        next_state = SIX;
                    end
                    else begin
                        next_state = DISC;
                    end
            SIX :   if (in) begin
                        next_state = ERROR;
                    end
                    else begin
                        next_state = FLAG;
                    end
            DISC:   if (in) begin
                        next_state = ONE;
                    end
                    else begin
                        next_state = NONE;
                    end
            FLAG:   if (in) begin
                        next_state = ONE;
                    end
                    else begin
                        next_state = NONE;
                    end
            ERROR:  if (in) begin
                        next_state = ERROR;
                    end
                    else begin
                        next_state = NONE;
                    end
            default:    next_state = NONE;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= NONE;
        end
        else begin
            state <= next_state;
        end
    end

    assign disc = (state == DISC) ? 1 : 0;
    assign flag = (state == FLAG) ? 1 : 0;
    assign err  = (state == ERROR)? 1 : 0; 

endmodule
