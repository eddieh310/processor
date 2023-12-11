`include "datapath.sv"
`include "control.sv"
//include the file to your instruction split here

  
/*******************************************
/	Name: Edward Herrera
/
/	Module name: top
/
/	Inputs:  32 bit instruction
/			  
/            
/
/	Output:  Control unit bits MemtoReg, MemWrite, ALUSrc, RegDst,
/			 Branch, and RegWrite, PCSrc, zero, overflow
/            16 bit imm
/            4 bit alu control
/            32 bit alu result
/            6 bit funct and opcode
/
/	Purpose: Implement Single Cycle Processor complete with instruction split, control unit, and datapath, takes a 32 bit instruction and returns 32 bit alu result along with control signals  
/
/******************************************/

`timescale 1ps/100fs

module top(
  input [31:0] Instr,
  output [5:0] top_Func, top_Opcode,
  output [4:0] top_Rs_number, top_Rt_number,
  output [15:0] top_Immediate_16,
  output top_MemtoReg, top_MemWrite, top_PCSrc, top_ALUSrc, 
  output top_RegDst, top_RegWrite, top_Zero, top_Overflow,
  output [3:0] top_ALUControl,
  output [31:0] top_ALUResult
);
  
  
  //call to inst_split from lab7
  //fill in the blanks with the variable names from your lab 7 and include
  //the file at the top
  instr_split split(.instr(Instr), 
                   .op(top_Opcode), 
                   .rs(top_Rs_number), 
                   .rt(top_Rt_number), 
                   .funct(top_Func),
                   .imm(top_Immediate_16)
           );
                  
  //1 bit input zero from datapath
  //6 bit inputs Func and Opcode from inst_split
  //1 bit outputs MemtoReg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite
  //PCSrc will be a combination of your decode ANDed with zero
  control decoder(.Func(top_Func), 
                  .Opcode(top_Opcode),
                  .Zero(top_Zero),
                  .MemtoReg(top_MemtoReg), 
                  .MemWrite(top_MemWrite), 
                  .PCSrc(top_PCSrc), 
                  .ALUSrc(top_ALUSrc), 
                  .RegDst(top_RegDst), 
                  .RegWrite(top_RegWrite), 
                  .ALUControl(top_ALUControl)
           );
  
  //1 bit inputs ALUSrc from control
  //4 bit input ALUControl from control
  //5 bit inputs Rs_number and Rt_number from inst_split
  //16 bit input Immediate from inst_split
  //1 bit outputs zero
  //32 bit output ALU_result
  datapath path(.rs_number(top_Rs_number), 
                .rt_number(top_Rt_number), 
                .imm_16(top_Immediate_16), 
                .ALUSrc(top_ALUSrc), 
                .ALUControl(top_ALUControl), 
                .zero(top_Zero), 
                .ovfl(top_Overflow),
                .ALUResult(top_ALUResult)
            );
  
endmodule