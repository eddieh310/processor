/*******************************************
/	Name: Edward Herrera
/
/	Module name: control
/
/	Inputs:  6-bit function code and 6-bit opcode.
/			 Also 1 bit input zero coming from the datapath
/
/	Output:  Control unit bits MemtoReg, MemWrite, ALUSrc, RegDst,
/			 PCSrc, and RegWrite, 4 bit ALUControl
/
/	Purpose: Generate control bits with instantiation of aludecoder and maindecoder
/
/******************************************/

`timescale 1ps/100fs
`include "maindecoder.sv"
`include "aludecoder.sv"

module control(
  input [5:0] Func, Opcode,
  input Zero,
  output MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite,
  output [3:0] ALUControl
);
  
  wire branch;
  wire  [1:0] aluop;
  
  
  //Main Decoder
  
  maindecoder md(Opcode,MemtoReg,MemWrite,aluop,
                 ALUSrc,RegDst,RegWrite,branch);
  //ALU Decoder
  
  aludecoder ad(aluop,Func,ALUControl);
  
  //generate pcsrc by anding zero and branch signal
  
  and a1(PCSrc,Zero,branch);
  
endmodule

  
  
  
  
  
  
  