module fp_adder #(
    parameter W_len =16 ,  //!Word length 
    parameter W_fract= 14 //! Length of fractional part 
) (
    input clk,
    input reset,
    input signed [W_len-1:0] a, 
    input signed [W_len-1:0] b,
    output reg signed [W_len-1:0] sum,
    output reg overflow, //!Shows whether overflow have occured or not
    output reg underflow //!Shows whether underflow have occured or not
);

wire [W_len-1:0]sum_i;

assign sum_i = a + b;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        sum <= 0;
        overflow <= 0;
        underflow <= 0;
    end
    else begin
        sum <= sum_i;
        if (a[W_len-1] != b[W_len-1])
        begin 
            overflow <= 0;
            underflow <= 0;
        end 
        else begin
            if (a[W_len-1] == 0 ) begin
                if (sum_i[W_len-1]==1) begin
                    overflow <= 1'b1;
                    underflow <= 1'b0;   
                end
                else begin
                    overflow <= 1'b0;
                    underflow <= 1'b0;
                end
            end
            else begin
                if (sum_i[W_len-1]==1) begin
                    overflow <= 0;
                    underflow <= 0;   
                end
                else begin
                    overflow <= 0;
                    underflow <= 1'b1;
                end
            end
        end
    end
end

endmodule
