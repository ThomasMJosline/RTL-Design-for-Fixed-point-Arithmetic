
`timescale 1 ns / 10 ps
module adder_fp_tb;

localparam W_in = 16;
localparam W_in_F = 14;
localparam W_out = 16;
localparam W_out_F = 14;

reg signed [W_in-1:0] a;
reg signed [W_in-1:0] b;

wire signed [W_out-1:0] sum;
wire overflow;
wire underflow;

fp_adder #(.W_in(W_in), .W_in_F(W_in_F), .W_out(W_out), .W_out_F(W_out_F)) 
adder_dut (.a(a), .b(b), .sum(sum), .overflow(overflow), .underflow(underflow));

initial begin
    a = 16'b0; b = 16'b0;
    
    #5 a=16'b0010000000000000 ; b = 16'b1001000000000000 ;    // a = 0.5  b = -1.75

    #3 a=16'b1001000000000000 ; b = 16'b1101000000000000 ;   // a = -1.75  b = -0.75

    #2 a=16'b0101010101010101 ; b = 16'b0010000000000000 ;   // a = 1.33331298828125  b = 0.5

    #2 a=16'b0101010101010101 ; b = 16'b0100000000000000 ;  // a = 1.33331298828125  b = 1

    #2 a=16'b0101010101010101 ; b = 16'b1001000000000000 ;   // a = 1.33331298828125  b = -1.75

    #2 a=16'h7777 ; b = 16'h8887 ; // a = 1.86663818359375 , b = -1.86676025390625

    #2 a=16'hf777 ; b = 16'h8001 ; // a = -0.13336181640625 , b = -1.99993896484375

    #2 a=16'h7079 ; b = 16'h7078; // a = 1.75738525390625 , b = 1.75732421875

    #2 a=16'h0123 ; b = 16'h1234 ; // a = 0.01776123046875 , b = 0.284423828125

    #2 a=16'hfedc ; b = 16'hfabc ; // a = -0.017822265625 , b = -0.082275390625


end




endmodule
