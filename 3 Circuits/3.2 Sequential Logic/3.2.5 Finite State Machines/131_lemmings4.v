module top_module(
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
); 
    parameter [2:0] LEFT   = 3'b000,
                    RIGHT  = 3'b001,
                    FALL_L = 3'b010,
                    FALL_R = 3'b011,
                    DIG_L  = 3'b100,
                    DIG_R  = 3'b101,
                    SPLAT  = 3'b110;
    reg [2:0] state,next_state;

    reg [6:0] counter;

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            counter <= 0;
        end
        else if(state == FALL_L || state == FALL_R) begin
            counter <= counter + 1;
        end
        else begin
            counter <= 0;
        end
    end

    always @(*) begin
        case (state)
            LEFT :  if (ground) begin
                        if (dig) begin
                            next_state = DIG_L;
                        end
                        else begin
                            if (bump_left) begin
                                next_state = RIGHT;
                            end
                            else begin
                                next_state = LEFT;
                        end 
                        end
                    end
                    else begin
                        next_state = FALL_L;
                    end
            RIGHT : if (ground) begin
                        if (dig) begin
                            next_state = DIG_R;
                        end
                        else begin
                            if (bump_right) begin
                                next_state = LEFT;
                            end
                            else begin
                                next_state = RIGHT;
                            end 
                        end
                    end
                    else begin
                        next_state = FALL_R;
                    end  
            FALL_L :if (ground) begin
                if (counter > 7'd19) begin
                            next_state = SPLAT;
                        end
                        else begin
                            next_state = LEFT;
                        end
                    end
                    else begin
                        next_state = FALL_L;
                    end
            FALL_R :if (ground) begin
                if (counter > 7'd19) begin
                            next_state = SPLAT;
                        end
                        else begin
                            next_state = RIGHT;
                        end
                    end
                    else begin
                        next_state = FALL_R;
                    end
            DIG_L  :if (ground) begin
                        next_state = DIG_L;
                    end
                    else begin
                        next_state = FALL_L;
                    end
            DIG_R  :if (ground) begin
                        next_state = DIG_R;
                    end
                    else begin
                        next_state = FALL_R;
                    end
            SPLAT  :    next_state = SPLAT;        
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
            digging = 1'b0;
        end
        else if(state == DIG_L || state == DIG_R) begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b0;
            digging = 1'b1;
        end
        else if(state == LEFT || state == RIGHT) begin
            walk_left = (state == LEFT) ? 1'b1 : 1'b0;
            walk_right = (state == RIGHT) ? 1'b1 : 1'b0;
            aaah = 1'b0;
            digging = 1'b0;
        end
        else begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b0;
            digging = 1'b0;
        end
    end

endmodule
