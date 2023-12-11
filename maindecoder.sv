//include files you need to use here

/*******************************************
/	Name: Edward Herrera
/
/	Module name: maindecoder
/
/	Inputs:  6 bit opcode
/
/	Output:  Control unit bits MemtoReg, MemWrite, ALUSrc, RegDst,
/			 PCSrc, and RegWrite, ALUop, branch
/
/	Purpose: Generate control signals and ALUop using case statements
/
/******************************************/

module maindecoder(input [5:0] op, output MemtoReg,output MemWrite,output [1:0] ALUop,output ALUSrc,output RegDst,output RegWrite,output branch);
  //input [5:0] op;
  //output MemtoReg,MemWrite,ALUSrc,RegDst,RegWrite,branch;
  //output [1:0] ALUop;
  
  reg  holder0,holder1,holder2,holder3,holder4,holder5,holder6,holder7;
  //holder[7] = branch
  //holder[6] = regwrite
  //holder[5] = memtoreg
  //holder[4] = memwrite
  //holder[3] = aluop[1]
  //holder[2] = aluop[0]
  //holder[1] = alusrc
  //holder[0] = regdst
  
  //use case statements to select appropriate signals 
  always @* begin
    case (op)
      6'b000000: begin
        //r-type
        assign holder7 = 1'b1;
        assign holder6 = 1;
        assign holder5 = 0;
        assign holder4 = 0;
        assign holder3 = 1;
        assign holder2 = 0;
        assign holder1 = 0;
        assign holder0 = 1;
      end 
      6'b000100: begin
        //beq
        assign holder7=1;
        assign holder6=0;
        assign holder5=1; // dont care
        assign holder4=0;
        assign holder3=0;
        assign holder2=1;
        assign holder1=0;
        assign holder0=0; //dont care
      end 
      6'b100011: begin
        //lw
        assign holder0=0;
        assign holder1=1;
        assign holder2=0;
        assign holder3=0;
        assign holder4=0;
        assign holder5=1;
        assign holder6=1;
        assign holder7=0;
      end 
      6'b101011: begin 
        //sw
        assign holder3=0;
        assign holder2=0;
        assign holder5=0; //dont care
        assign holder4=1;
        assign holder7=0;
        assign holder1=1;
        assign holder0=0; //dont care
        assign holder6=0;
      end 
      6'b001000: begin
        //addi
        assign holder3=0;
        assign holder2=0;
        assign holder5=0;
        assign holder4=0;
        assign holder7=0;
        assign holder1=1;
        assign holder0=0;
        assign holder6=1;
      end
      default: begin
        $display ("invalid entry3");
        $display (op);
      end 
    endcase
  end 
  
  //assign outputs 
  assign branch=holder7; 
  assign RegWrite=holder6;
  assign MemtoReg=holder5;
  assign MemWrite=holder4;
  assign ALUop[1]=holder3;
  assign ALUop[0]=holder2;
  assign ALUSrc=holder1;
  assign RegDst=holder0;
  
  
  
endmodule 
      
      
       
    
      
    
  