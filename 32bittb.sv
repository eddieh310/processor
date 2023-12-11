/* ***************************************************************\
| Name of program: CSE341 32 Bit ALU test bench
| Author: Ian Witmer
| Date Created: 5/2/2023
| Date last updated: 5/3/2023
| Function: Tests the functionality of a 32 Bit ALU.
|
|THE TEST CASES DO NOT TEST FOR THE ZERO OUTPUT CORRECTNESS SO THAT IF YOU FAIL A TEST
|YOU WILL KNOW IT IS BECAUSE OF ISSUES WITH RESULT OR OVERFLOW, WHICH IS MUCH MORE
|HELPFUL. TO TEST YOUR ZERO CORRECTNESS, JUST LOOK AT THE ZERO VALUE FOR EACH CASE IN
|THE LOG AND MAKE SURE IT IS ONLY 1 WHEN RESULT IS 0.
|
|!!!!!Replace the dashes before and within testALU with the values that
|correspond to your module name, and its input and output names!!!!!!!!!!!!
\****************************************************************/

module alu32_tb;
  reg [3:0] ALUctl_tb;    
  reg [31:0] A_tb, B_tb;
  wire [31:0] result_tb;
  wire overflow_tb, zero_tb;
  
  ___ testALU(.__(A_tb), .__(B_tb), .__(ALUctl_tb), .__(result_tb), .__(overflow_tb), .__(zero_tb));
  initial begin
    ALUctl_tb = 4'b0000;
    A_tb = 32'h0000_0000;
    B_tb = 32'h0000_0000;
    end
  always begin
    //test and
    #400 if (result_tb !== 32'h0000_0000) $display("AND CASE1 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'h0000_0000) $display("AND CASE2 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'h0000_0000) $display("AND CASE3 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'h4000_0000) $display("AND CASE4 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'hC000_0000) $display("AND CASE5 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h8000_0000) $display("AND CASE6 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h8000_0000) $display("AND CASE7 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h8000_0000) $display("AND CASE8 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("AND CASE9 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'h0000_0000) $display("AND CASE10 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'h0000_0000) $display("AND CASE11 Failed");
    A_tb = 32'hAAAA_AAAA; B_tb = 32'h5555_5555;
    #400 if (result_tb !== 32'h0000_0000) $display("AND CASE12 Failed");
    ALUctl_tb = 4'b0001; A_tb = 32'h0000_0000; B_tb = 32'h0000_0000; //set up for or
    
    
    //test or
    #400 if (result_tb !== 32'h0000_0000) $display("OR CASE1 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'h4000_0000) $display("OR CASE2 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'h4000_0000) $display("OR CASE3 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'h4000_0000) $display("OR CASE4 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'hC000_0000) $display("OR CASE5 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'hC000_0000) $display("OR CASE6 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'hC000_0000) $display("OR CASE7 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h8000_0000) $display("OR CASE8 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("OR CASE9 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("OR CASE10 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("OR CASE11 Failed");
    A_tb = 32'hAAAA_AAAA; B_tb = 32'h5555_5555;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("OR CASE12 Failed");
    ALUctl_tb = 4'b1100; A_tb = 32'h0000_0000; B_tb = 32'h0000_0000; //set up for nor
    
    
    
    //test nor
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("NOR CASE1 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'hBFFF_FFFF) $display("NOR CASE2 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'hBFFF_FFFF) $display("NOR CASE3 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'hBFFF_FFFF) $display("NOR CASE4 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h3FFF_FFFF) $display("NOR CASE5 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h3FFF_FFFF) $display("NOR CASE6 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h3FFF_FFFF) $display("NOR CASE7 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h7FFF_FFFF) $display("NOR CASE8 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'h0000_0000) $display("NOR CASE9 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'h0000_0000) $display("NOR CASE10 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'h0000_0000) $display("NOR CASE11 Failed");
    A_tb = 32'hAAAA_AAAA; B_tb = 32'h5555_5555;
    #400 if (result_tb !== 32'h0000_0000) $display("NOR CASE12 Failed");
    ALUctl_tb = 4'b0010; A_tb = 32'h0000_0000; B_tb = 32'h0000_0000; //set up for add
    
    
    
    //test add
    #400 if (result_tb !== 32'h0000_0000 | overflow_tb !== 0) $display("ADD CASE1 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'h4000_0000 | overflow_tb !== 0) $display("ADD CASE2 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'h4000_0000 | overflow_tb !== 0) $display("ADD CASE3 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'h8000_0000 | overflow_tb !== 1) $display("ADD CASE4 Failed");//overflow case
    A_tb = 32'hC000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h8000_0000 | overflow_tb !== 0) $display("ADD CASE5 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h4000_0000 | overflow_tb !== 1) $display("ADD CASE6 Failed");//overflow case
    A_tb = 32'h8000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h4000_0000| overflow_tb !== 1) $display("ADD CASE7 Failed");//overflow case
    A_tb = 32'h8000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h0000_0000| overflow_tb !== 1) $display("ADD CASE8 Failed");//overflow case
    A_tb = 32'hFFFF_FFFF; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'hFFFF_FFFE | overflow_tb !== 0) $display("ADD CASE9 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'hFFFF_FFFF | overflow_tb !== 0) $display("ADD CASE10 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'hFFFF_FFFF | overflow_tb !== 0) $display("ADD CASE11 Failed");
    A_tb = 32'hAAAA_AAAA; B_tb = 32'h5555_5555;
    #400 if (result_tb !== 32'hFFFF_FFFF | overflow_tb !== 0) $display("ADD CASE12 Failed");
    ALUctl_tb = 4'b0110; A_tb = 32'h0000_0000; B_tb = 32'h0000_0000; //set up for sub
    
    
    
    //test sub
    #400 if (result_tb !== 32'h0000_0000 | overflow_tb !== 0) $display("SUB CASE1 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'hC000_0000 | overflow_tb !== 0) $display("SUB CASE2 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'h4000_0000 | overflow_tb !== 0) $display("SUB CASE3 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'h0000_0000 | overflow_tb !== 0) $display("SUB CASE4 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h0000_0000 | overflow_tb !== 0) $display("SUB CASE5 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h4000_0000 | overflow_tb !== 0) $display("SUB CASE6 Failed");//overflow edge case (no overflow, the negative representation is just the same as the positive)
    A_tb = 32'h8000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'hC000_0000 | overflow_tb !== 0) $display("SUB CASE7 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h0000_0000 | overflow_tb !== 0) $display("SUB CASE8 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'h0000_0000 | overflow_tb !== 0) $display("SUB CASE9 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'hFFFF_FFFF | overflow_tb !== 0) $display("SUB CASE10 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'h0000_0001 | overflow_tb !== 0) $display("SUB CASE11 Failed");
    A_tb = 32'hAAAA_AAAA; B_tb = 32'h5555_5555;
    #400 if (result_tb !== 32'h5555_5555 | overflow_tb !== 1) $display("SUB CASE12 Failed");//overflow case
    ALUctl_tb = 4'b0111; A_tb = 32'h0000_0000; B_tb = 32'h0000_0000; //set up for slt
    
    
    
    //test slt
    #400 if (result_tb !== 32'h0000_0000) $display("SLT CASE1 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'h0000_0001) $display("SLT CASE2 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'h0000_0000) $display("SLT CASE3 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'h0000_0000) $display("SLT CASE4 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h0000_0000) $display("SLT CASE5 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h0000_0000) $display("SLT CASE6 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h0000_0001) $display("SLT CASE7 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h0000_0000) $display("SLT CASE8 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'h0000_0000) $display("SLT CASE9 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'h0000_0001) $display("SLT CASE10 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'h0000_0000) $display("SLT CASE11 Failed");
    A_tb = 32'hAAAA_AAAA; B_tb = 32'h1555_5555;
    #400 if (result_tb !== 32'h0000_0001) $display("SLT CASE12 Failed");
    ALUctl_tb = 4'b1101; A_tb = 32'h0000_0000; B_tb = 32'h0000_0000; //set up for nand
    
    
    
    //test NAND
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("NAND CASE1 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("NAND CASE2 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("NAND CASE3 Failed");
    A_tb = 32'h4000_0000; B_tb = 32'h4000_0000;
    #400 if (result_tb !== 32'hBFFF_FFFF) $display("NAND CASE4 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h3FFF_FFFF) $display("NAND CASE5 Failed");
    A_tb = 32'hC000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h7FFF_FFFF) $display("NAND CASE6 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'hC000_0000;
    #400 if (result_tb !== 32'h7FFF_FFFF) $display("NAND CASE7 Failed");
    A_tb = 32'h8000_0000; B_tb = 32'h8000_0000;
    #400 if (result_tb !== 32'h7FFF_FFFF) $display("NAND CASE8 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'h0000_0000) $display("NAND CASE9 Failed");
    A_tb = 32'hFFFF_FFFF; B_tb = 32'h0000_0000;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("NAND CASE10 Failed");
    A_tb = 32'h0000_0000; B_tb = 32'hFFFF_FFFF;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("NAND CASE11 Failed");
    A_tb = 32'hAAAA_AAAA; B_tb = 32'h5555_5555;
    #400 if (result_tb !== 32'hFFFF_FFFF) $display("NAND CASE12 Failed");
    ALUctl_tb = 4'b0000; A_tb = 32'h0000_0000; B_tb = 32'h0000_0000; //set up for and
    
  end
  initial begin
    $dumpfile("thirtytwobitalu.vcd");
    $dumpvars;
  end
  initial begin
    $display("\t\ttime\t\ta\t\tb\tALUctl\t\tresult\toverflow\tzero");
    $monitor("%d\t%d\t%d\t%d\t%d\t%d\t\t%d",$time,A_tb,B_tb,ALUctl_tb,result_tb,overflow_tb,zero_tb);
  end
 initial
   #33200 $finish;
endmodule