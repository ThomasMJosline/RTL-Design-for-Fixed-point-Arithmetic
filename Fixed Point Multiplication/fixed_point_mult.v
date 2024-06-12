module fp_mult #(
    parameter W_len =16 , //!Word length of inputs
    parameter W_fract = 14 //! Length of fractional part of input
) (
    input clk,
    input reset,
    input signed [W_len-1:0] a,
    input signed [W_len-1:0] b,
    output reg signed [W_len-1:0] product,
    output reg overflow, //!Shows whether overflow have occured or not
    output reg underflow //!Shows whether underflow have occured or not
);

wire signed [2*W_len-1:0] product_i;

assign product_i = a*b;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        product <= 0;
        overflow <= 0;
        underflow <= 0;
    end
    else begin
        product <= product_i[W_len+W_fract-1:W_fract];

        if (a[W_len-1] != b[W_len-1] ) begin
            if (product_i[(2*W_len-1)-(W_len-W_fract)] == 0) begin
                overflow <= 0;
                underflow <= 1;
            end 
            else begin
                overflow <= 0;
                underflow <= 0;                
            end
        end

        else begin
            if (product_i[(2*W_len-1)-(W_len-W_fract)] == 1) begin
                overflow <= 1;
                underflow <= 0;
            end 
            else begin
                overflow <= 0;
                underflow <= 0;   
            end
        end
    end
end

endmodule
