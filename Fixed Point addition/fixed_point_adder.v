module fp_adder #(
    parameter W_in =16 ,  //!Word length of inputs 
    parameter W_in_F = 14, //! Length of fractional part of output
    parameter W_out =16 , //!Word length of output
    parameter W_out_F = 14 //! Length of fractional part of output
) (
    input signed [W_in-1:0] a, 
    input signed [W_in-1:0] b,
    output reg signed [W_out-1:0] sum,
    output reg overflow, //!Shows whether overflow have occured or not
    output reg underflow //!Shows whether underflow have occured or not
);

always @(*) begin
    sum = a + b;
    if (a[W_in-1] != b[W_in-1])
    begin 
        overflow = 0;
        underflow = 0;
    end 
    else begin
        if (a[W_in-1] == 0 ) begin
            if (sum[W_in-1]==1) begin
                overflow = 1'b1;
                underflow = 0;   
            end
            else begin
                overflow = 0;
                underflow = 0;
            end
        end
        else begin
            if (sum[W_in-1]==1) begin
                overflow = 0;
                underflow = 0;   
            end
            else begin
                overflow = 0;
                underflow = 1'b1;
            end
        end
    end
end

endmodule
