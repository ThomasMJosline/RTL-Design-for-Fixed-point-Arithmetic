module fp_mult #(
    parameter W_in =16 , //!Word length of inputs
    parameter W_in_F = 14, //! Length of fractional part of input
    parameter W_out =16 ,  //!Word length of outputs
    parameter W_out_F = 14 //! Length of fractional part of output
) (
    input signed [W_in-1:0] a,
    input signed [W_in-1:0] b,
    output signed [W_out-1:0] PRODUCT,
    output reg OVERFLOW, //!Shows whether overflow have occured or not
    output reg UNDERFLOW //!Shows whether underflow have occured or not
);

reg signed [2*W_in-1:0] PRODUCT_i;

always @(*) begin
    PRODUCT_i = a*b;
    if (PRODUCT_i > 32'sh1FFFC000 ) begin
        OVERFLOW = 1;
        UNDERFLOW = 0;
    end
    else begin
        if (PRODUCT_i < 32'shE0000000 )begin
            OVERFLOW = 0;
            UNDERFLOW = 1;
        end
        else begin
            OVERFLOW = 0;
            UNDERFLOW = 0;
        end
    end    
end

assign PRODUCT = PRODUCT_i[W_out+W_out_F-1:W_out_F];

endmodule
