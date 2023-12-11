/*******************************************
/	Module name: registerFile
/
/	Inputs:  5-bit location of rs and rt
/
/	Output:  Two 32 bit output in read_rs and read_rt
/
/	Purpose: The regFile variable holds random register values set
/			 from the regfile.dat file. The module itself returns
/			 a register value from the file based on the register
/			 number.
/******************************************/

`timescale 1ps/100fs

module registerFile(
  	input [4:0] A1, A2,
  	output [31:0] RD1, RD2
);
  
  
  reg [31:0] regFile [31:0];			//this is the overall register file
  
  initial begin
    $readmemh("regfile.dat",regFile);	//initialize register file to all 0s
  end
  
  assign RD1 = regFile[A1];			//constantly update rs value and rt
  assign RD2 = regFile[A2];			//value based on the location of rs and rt
  										//end the module
endmodule