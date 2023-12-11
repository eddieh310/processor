`include "registerfile.sv"
//`include "design.sv"

/*******************************************
/	Name: Edward Herrera
/
/	Module name: datapath
/
/	Inputs:  5-bit rs number, 5-bit rt number, and 16 bit immediate
/			 Control bits ALUSrc, and ALUControl
/
/	Output:  The 32 bit ALU_result and 1 bit outputs Overflow and Zero
/
/	Purpose: Read values into registers from register file, then sign extend the 16 bit immediate, then instatiate 32 bit mux and 32 bit ALU
/
/******************************************/

`timescale 1ps/100fs

module datapath(
  input [4:0] rs_number, rt_number,
  input [15:0] imm_16,
  input ALUSrc,
  input [3:0] ALUControl,
  output zero,
  output ovfl,
  output [31:0] ALUResult
);
  //temporaries to hold rd1, rd2, signextended imm, srcB
  wire [31:0] rd1, rd2;
  wire [31:0] ext;
  wire [31:0] srcB;

  //read values into registers from register file
  registerFile read_registers(.A1(rs_number), 
                              .A2(rt_number), 
                              .RD1(rd1), 
                              .RD2(rd2));
  
  //16 to 32 bit sign extension
  sign_extender se(imm_16,ext);
  
  //32 bit mux
  mux32bit mux32(rd2,ext,ALUSrc,srcB);
  
  //32 bit ALU
  alu32bit alu(rd1,srcB,ALUControl,ALUResult,ovfl,zero);
  

endmodule