`include "Instruction_Memory.sv"
`include "processor.sv"


/*******************************************
/	Name: Edward Herrera
/
/	Module name: processor_tb
/
/	Inputs:  none
/
/	Output:  Basically everything from your processor
/
/	Purpose: Test the processor with a series of instructions
/
/	
/
/******************************************/

`timescale 1ps/100fs

`define DELAY 400

module processor_tb;
  
  //declare the input address to start fetching instructions
  reg [4:0] word_address;
  //declare the outputs including the instruction itself,
  //and then all the processor outputs
  wire [31:0] instruction;
  wire [5:0] Func, Opcode;
  wire [4:0] Rs, Rt;
  wire [15:0] Immediate;
  wire MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite, Zero, Overflow;
  wire [3:0] ALUControl;
  wire [31:0] Result;
  
  //fetch an address every "DELAY" ps
  inst_mem fetch_instruction(.addr(word_address), .data(instruction));
  
  //call the module that will run your code
  //most of these ports are outputs to test your code
  //click Open EPWave after run or open the waveform to see these as a wave output
  top dut(.Instr(instruction), 
          .top_Func(Func),
          .top_Opcode(Opcode), 
          .top_Rs_number(Rs), 
          .top_Rt_number(Rt), 
          .top_Immediate_16(Immediate), 
          .top_MemtoReg(MemtoReg), 
          .top_MemWrite(MemWrite), 
          .top_PCSrc(PCSrc), 
          .top_ALUSrc(ALUSrc), 
          .top_RegDst(RegDst), 
          .top_RegWrite(RegWrite), 
          .top_Zero(Zero),
          .top_Overflow(Overflow),
          .top_ALUControl(ALUControl),
          .top_ALUResult(Result)
       );
  
  //start at the first instruction of the instruction file
  initial begin
    word_address = 0;
  end
  
  //Every "DELAY" ps, increase the address. Change delay to see what happens when doing timing analysis
  always begin
    #(`DELAY) word_address = word_address + 1;
  end
  
  //output the values into the EPWave or waveform
  initial begin
    $dumpfile("a.vcd");
    $dumpvars();
  end
  
  initial begin
    $display("\t\ttime\t\tinstr\t\t\t\taluresult");
    $monitor("%d\t%b\t%b",$time,instruction,Result);
  end
  
  //this runs exactly 31 instructions. You can't go past 32 instructions just because
  //of the constraint set in Instruction_Memory
  initial #12000 $finish;
endmodule