module top_module (
    input clk,
    input areset,
    input x,
    output reg z 
); 
    parameter idle = 2'b00,
              s1   = 2'b01,
              s2   = 2'b10;
    reg [1:0] state, next_state;

    always@(*)begin
        case(state)
            idle:next_state = x ? s1 : idle;
            s1  :next_state = x ? s2 : s1;
            s2  :next_state = x ? s2 : s1;
            default:next_state = idle;
        endcase
    end

    always@(posedge clk or posedge areset)begin
        if(areset)
            state <= idle;
        else
            state <= next_state;
    end

    assign z = (state == s1) ? 1 : 0;

endmodule
