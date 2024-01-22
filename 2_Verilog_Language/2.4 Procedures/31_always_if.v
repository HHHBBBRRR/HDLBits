module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   
); 

    assign out_assign = (sel_b1 == 1'b1) ? (sel_b2 == 1'b1 ? b : a) : a;
    
    always @(*) begin
        if (sel_b1 == 1'b1) begin
            if (sel_b2 == 1'b1) begin
                out_always = b;
            end
            else out_always = a;
        end
        else begin
            out_always = a;
        end
    end

endmodule
