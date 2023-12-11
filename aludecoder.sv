//include files you need to use here

/*******************************************
/	Name: Edward Herrera
/
/	Module name: aludecoder
/
/	Inputs:  6-bit function code , 2 bit aluop
/
/	Output:  4 bit alu control
/
/	Purpose: Use case statements to generate 4 bit alu control from the funct and aluop
/
/******************************************/

module aludecoder(aluop,funct,aluctl);
  input [1:0] aluop;
  input [5:0] funct;
  output [3:0] aluctl;
  
  //temp reg to use in case statements
  reg [3:0] temp;
  
  //case statements with nested case to select alu control
  always @* begin
    case (aluop) 
      2'b00: begin
        assign temp = 4'b0010; //lw sw addi
      end 
      2'b01: begin
        assign temp = 4'b0110; //beq
      end
      2'b10: begin
        case (funct)
          6'b100000: begin
            assign temp = 4'b0010; //add
          end
          6'b100010: begin
            assign temp = 4'b0110; //sub
          end
          6'b100100: begin
            assign temp = 4'b0000; //and
          end
          6'b100101: begin
            assign temp = 4'b001; //or
          end
          6'b100111: begin
            assign temp = 4'b1100; //nor
          end
          6'b101010: begin
            assign temp = 4'b0111; //slt
          end 
          //default: begin
         //   assign temp = 4'b1111;
         // end
        endcase
      end
       // default: begin
       //   assign temp = 4'b1111;
      //  end 
    endcase
  end 
  
  //assign output to temp reg
  assign aluctl = temp;
  
endmodule
        
          
      