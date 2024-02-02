module top_module(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
); 
    parameter LEFT=0,RIGHT=1,FALL_L=2,FALL_R=3;
    reg [1:0] state,next_state;

    always @(*) begin
        case (state)
            LEFT :  if (ground) begin
                        if (bump_left) begin
                            next_state = RIGHT;
                        end
                        else begin
                            next_state = LEFT;
                        end 
                    end
                    else begin
                        next_state = FALL_L;
                    end
            RIGHT : if (ground) begin
                        if (bump_right) begin
                            next_state = LEFT;
                        end
                        else begin
                            next_state = RIGHT;
                        end 
                    end
                    else begin
                        next_state = FALL_R;
                    end  
            FALL_L :if (ground) begin
                        next_state = LEFT;
                    end
                    else begin
                        next_state = FALL_L;
                    end
            FALL_R :if (ground) begin
                        next_state = RIGHT;
                    end
                    else begin
                        next_state = FALL_R;
                    end           
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        if (state == FALL_L || state == FALL_R) begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b1;
        end
        else begin
            walk_left = (state == LEFT) ? 1'b1 : 1'b0;
            walk_right = (state == RIGHT) ? 1'b1 : 1'b0;
            aaah = 1'b0;
        end
    end

endmodule
