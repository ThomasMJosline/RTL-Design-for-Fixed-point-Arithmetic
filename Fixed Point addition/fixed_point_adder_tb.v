`timescale 1 ns / 10 ps
module adder_fp_tb;

localparam W_len = 16;
localparam W_fract = 14;



reg clk;
reg reset;
reg signed [W_len-1:0] a;
reg signed [W_len-1:0] b;


wire signed [W_out-1:0] sum;
wire overflow;
wire underflow;

fp_adder #(.W_len(W_len), .W_fract(W_fract)) 
adder_dut (.a(a), .b(b), .clk(clk),.reset(reset), .sum(sum), .overflow(overflow), .underflow(underflow));

initial begin
    clk = 1; reset = 0;
    a = 16'b0; b = 16'b0;

    #5 reset = 1;

    #10 reset = 0;
    
    #10 a=16'h2000 ; b = 16'h9000 ;    // a = 0.5  b = -1.75

    #10 a=16'h9000 ; b = 16'hd000 ;   // a = -1.75  b = -0.75
`
    #10 a=16'h5555 ; b = 16'h2000 ;   // a = 1.33331298828125  b = 0.5

    #10 a=16'h5555 ; b = 16'h4000 ;  // a = 1.33331298828125  b = 1

    #10 a=16'h5555 ; b = 16'h9000 ;   // a = 1.33331298828125  b = -1.75

    #10 a=16'h7777 ; b = 16'h8887 ; // a = 1.86663818359375 , b = -1.86676025390625

    #10 a=16'hf777 ; b = 16'h8001 ; // a = -0.13336181640625 , b = -1.99993896484375

    #10 a=16'h7079 ; b = 16'h7078; // a = 1.75738525390625 , b = 1.75732421875

    #10 a=16'h0123 ; b = 16'h1234 ; // a = 0.01776123046875 , b = 0.284423828125

    #10 a=16'hfedc ; b = 16'hfabc ; // a = -0.017822265625 , b = -0.082275390625

    #10 a=16'habcd ; b = 16'hbcde ; // a =-1.31561279296875 , b = -1.0489501953125  


end

always #(5) clk = ~clk;

endmodule
