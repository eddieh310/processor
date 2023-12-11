// Code your design here
/* ***************************************************************\
| Name of program: design.sv
| Author: Edward Herrera
| Date Created: 4/30/21
| Date last updated: 5/12/23
| Function: 1 bit ALU and 32 bit ALU capable of add, sub, and, or, nor, nand, slt, instruction split that divides instruction into appropriate fields, sign extender for 16 bit imm
| Method: uses gates and muxes to create datapath
| Additional Comments: none
\****************************************************************/
`timescale 1ps/100fs
//`include "registerfile.sv"
//`include "datapath.sv"


module alu1bit(a, b, cin, control, less, result, cout, set, overflow);
  input a, b;	// inputs a and b, 1 bit inputs
  input [3:0]control ; // input operation, 4 bit control
  input cin;    // input cin, 1 bit carry-in
  input less;   // input less, 1 bit less
  output result; // output result, 1 bit result 
  output cout;   // output carryout, 1 bit carryout
  output set;    // output set, 1 bit set output
  output overflow; //output overflow, 1 bit overflow 
  
  /*
  each input and its 4 bit alu control
  
  add-0010
  sub-0110
  and-0000
  or-0001
  nor-1100
  nand-1101
  slt-0111
  */
  
  wire w1, w2, w3, w4, w5, w6, w7, w8;  //internal connections
  //w1 - used for notting a and in a mux
  //w2 - used fot notting b and in b mux
  //w3 - used to hold output of a mux
  //w4 - used to hold output of b mux
  //w5 - used to hold w3 and w4
  //w6 - used to hold w3 or w4
  //w7 - used to hold sum of one bit adder
  wire o1, o2, o3, o4, o5, o6, o7, o8, o9, ov1; //internal overflow connections
  wire ov2, ov3, ov4, ov5, ov6, ov7;
  wire r1; //temporary
  
  not n1(w1,a); //w1 holds not a
  mux2to1 mux1(a,w1,control[3],w3); //mux to select a or not a
  
  not n2(w2,b); //w2 holds not b
  mux2to1 mux2(b,w2,control[2],w4);  //mux to select b or not b
  
  and u1(w5, w3, w4); // w5 holds w3 and w4
  
  or u2(w6, w3, w4); //w6 holds w3 or w4
  
  onebitfullAdder u3(w3,w4,cin,w7,cout); //instatiate adder
  
  and a1(set,w7,w7); //and gate to set set to w7
  
  
  mux4to1 mux3(w5,w6,w7,less,control[1:0],result); //4to1 mux for selecting output
  
  //overflow below
  not n3(o1,control[2]); //o1 holds sub_n
  not n4(r1,result);     //r1 holds result_n
  
  and u5(o2,o1,w1);  //o2 = sub_n and a_n
  and u6(o3,o2,w2);  //o3 = sub_n and a_n and b_n
  and u7(o4,o3,result); //o4 = sub_n and a_n and b_n and result
  
  and u8(o5,o1,a); //o5 = sub_n and a
  and u9(o6,o5,b); //o6 = o5 && b
  and d1(o7,o6,r1);//o7 = sub_n and a and b and result_n
  
  and d2(o8,control[2],w1); //o8 = sub and a_n
  and d3(o9,o8,b);          //o9 = sub and a_n and b
  and d4(ov1,o9,result);   //ov1 = sub and a_n and b and result
  
  and d5(ov2, control[2],a);  //ov2 = sub and a
  and d6(ov3,ov2,w2);  //ov3 = sub and a and b_n
  and d7(ov4, ov3, r1); //ov4 = sub and a and b_n and result_n
  
  //or all overflow wires and store into overflow output
  or f1(ov5, o4, o7); 
  or f2(ov6,ov5,ov1);
  or f3(overflow,ov6,ov4);
  
endmodule

module alu32bit(a,b,control,out,ovfl1,zero);
  input  [31:0] a,b; //32 bit a , 32 bit b
  input  [3:0] control; //32 bit control
  output  [31:0] out; //32 bit output
  output ovfl1, zero; //1 bit overlflow and zero output
  wire ovfl; //temp ovfl wire
  
  //carry out wires
  wire cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout8, cout9, cout10;
  wire cout11, cout12, cout13, cout14, cout15, cout16, cout17, cout18, cout19;
  wire cout20, cout21, cout22, cout23, cout24, cout25, cout26, cout27, cout28;
  wire cout29, cout30, cout31, cout32;
  
  //temp set wire
  wire set;
  
  
  wire w1, w2, w3, w4, w5, w6, w7, w8;
  
  //setwire for connecting set to less
  wire setwire;
  
  alu1bit u1(a[31],b[31],cout31,control,1'b0,out[31], cout32,setwire, ovfl1);
  alu1bit u2(a[30],b[30],cout1,control,1'b0,out[30], cout31, set, ovfl);
  alu1bit u3(a[29],b[29],cout2,control,1'b0,out[29], cout1, set, ovfl);
  alu1bit u4(a[28],b[28],cout3,control,1'b0,out[28], cout2, set, ovfl);
  alu1bit u5(a[27],b[27],cout4,control,1'b0,out[27], cout3, set, ovfl);
  alu1bit u6(a[26],b[26],cout5,control,1'b0,out[26], cout4, set, ovfl);
  alu1bit u7(a[25],b[25],cout6,control,1'b0,out[25], cout5, set, ovfl);
  alu1bit u8(a[24],b[24],cout7,control,1'b0,out[24], cout6, set, ovfl);
  alu1bit u9(a[23],b[23],cout8,control,1'b0,out[23], cout7, set, ovfl);
  alu1bit a1(a[22],b[22],cout9,control,1'b0,out[22], cout8, set, ovfl);
  alu1bit a2(a[21],b[21],cout10,control,1'b0,out[21], cout9, set, ovfl);
  alu1bit a3(a[20],b[20],cout11,control,1'b0,out[20], cout10, set, ovfl);
  alu1bit a4(a[19],b[19],cout12,control,1'b0,out[19], cout11, set, ovfl);
  alu1bit a5(a[18],b[18],cout13,control,1'b0,out[18], cout12, set, ovfl);
  alu1bit a6(a[17],b[17],cout14,control,1'b0,out[17], cout13, set, ovfl);
  alu1bit a7(a[16],b[16],cout15,control,1'b0,out[16], cout14, set, ovfl);
  alu1bit a8(a[15],b[15],cout16,control,1'b0,out[15], cout15, set, ovfl);
  alu1bit a9(a[14],b[14],cout17,control,1'b0,out[14], cout16, set, ovfl);
  alu1bit d1(a[13],b[13],cout18,control,1'b0,out[13], cout17, set, ovfl);
  alu1bit d2(a[12],b[12],cout19,control,1'b0,out[12], cout18, set, ovfl);
  alu1bit d3(a[11],b[11],cout20,control,1'b0,out[11], cout19, set, ovfl);
  alu1bit d4(a[10],b[10],cout21,control,1'b0,out[10], cout20, set, ovfl);
  alu1bit d5(a[9],b[9],cout22,control,1'b0,out[9], cout21, set, ovfl);
  alu1bit d6(a[8],b[8],cout23,control,1'b0,out[8], cout22, set, ovfl);
  alu1bit d7(a[7],b[7],cout24,control,1'b0,out[7], cout23, set, ovfl);
  alu1bit d8(a[6],b[6],cout25,control,1'b0,out[6], cout24, set, ovfl);
  alu1bit d9(a[5],b[5],cout26,control,1'b0,out[5], cout25, set, ovfl);
  alu1bit h1(a[4],b[4],cout27,control,1'b0,out[4], cout26, set, ovfl);
  alu1bit h2(a[3],b[3],cout28,control,1'b0,out[3], cout27, set, ovfl);
  alu1bit h3(a[2],b[2],cout29,control,1'b0,out[2], cout28, set, ovfl);
  alu1bit h4(a[1],b[1],cout30,control,1'b0,out[1], cout29, set, ovfl);
  alu1bit h5(a[0],b[0],control[2],control,setwire,out[0], cout30, set, ovfl);
  
  //zero wires
  wire z1, z2, z3, z4, z5, z6, z7, z8, z9, z10, z11, z12, z13, z14, z15, z16;
  wire z17, z18, z19, z20, z21, z22, z23, z24, z25, z26, z27, z28, z29, z30;
  wire z31, z32;
  
  //or all result bits and not it to get zero output
  or o1(z1,out[31],out[30]);
  or o2(z2,z1,out[29]);
  or o3(z3,z2,out[28]);
  or o4(z4,z3,out[27]);
  or o5(z5,z4,out[26]);
  or o6(z6,z5,out[25]);
  or o7(z7,z6,out[24]);
  or o8(z8,z7,out[23]);
  or o9(z9,z8,out[22]);
  or o11(z10,z9,out[21]);
  or o12(z11,z10,out[20]);
  or o13(z12,z11,out[19]);
  or o14(z13,z12,out[18]);
  or o15(z14,z13,out[17]);
  or o16(z15,z14,out[16]);
  or o17(z16,z15,out[15]);
  or o18(z17,z16,out[14]);
  or o19(z18,z17,out[13]);
  or o20(z19,z18,out[12]);
  or o21(z20,z19,out[11]);
  or o22(z21,z20,out[10]);
  or o23(z22,z21,out[9]);
  or o24(z23,z22,out[8]);
  or o25(z24,z23,out[7]);
  or o26(z25,z24,out[6]);
  or o27(z26,z25,out[5]);
  or o28(z27,z26,out[4]);
  or o29(z28,z27,out[3]);
  or o30(z29,z28,out[2]);
  or o31(z30,z29,out[1]);
  or o32(z31,z30,out[0]);
  
  not n1(zero,z31);
  
endmodule

module instr_split (instr,op,rs,rt,funct,imm);
  input [31:0] instr; //32 bit instruction
  output [5:0] op,funct; //6 bit opcode and funct
  output [4:0] rs, rt; //5 bit rs and rt
  output [15:0] imm; //16 bit immediate
  
  //temporary wires
  wire [5:0] opcode;
  wire [4:0] rs_wire;
  wire [4:0] rt_wire;
  wire [5:0] funct_wire;
  wire [15:0] imm_wire;

  //split instruction into fields
  assign opcode = instr[31:26];
  assign rs_wire = instr[25:21];
  assign rt_wire = instr[20:16];
  assign funct_wire = instr[5:0];
  assign imm_wire = instr[15:0];
  
  //assing outputs to temporary wires
  assign op = opcode;
  assign funct = funct_wire;
  assign rs = rs_wire;
  assign rt = rt_wire;
  assign imm = imm_wire;
  
endmodule


module sign_extender (imm,ext);
  input [15:0] imm; //16 bit immediate
  output [31:0] ext; //32 bit sign extended output
  
  wire sb; //sign bit wire
  
  and u1(sb,1'b1,imm[15]); //calculate sign bit
  
  //and with 1 to store appropriate bit into output
  and u2(ext[31],sb,1'b1);
  and u3(ext[30],sb,1'b1);
  and u4(ext[29],sb,1'b1);
  and u5(ext[28],sb,1'b1);
  and u6(ext[27],sb,1'b1);
  and u7(ext[26],sb,1'b1);
  and u8(ext[25],sb,1'b1);
  and u9(ext[24],sb,1'b1);
  and u10(ext[23],sb,1'b1);
  and u11(ext[22],sb,1'b1);
  and u12(ext[21],sb,1'b1);
  and u13(ext[20],sb,1'b1);
  and u14(ext[19],sb,1'b1);
  and u15(ext[18],sb,1'b1);
  and u16(ext[17],sb,1'b1);
  and u17(ext[16],sb,1'b1);
  
  and d1(ext[15],imm[15],1'b1);
  and d2(ext[14],imm[14],1'b1);
  and d3(ext[13],imm[13],1'b1);
  and d4(ext[12],imm[12],1'b1);
  and d5(ext[11],imm[11],1'b1);
  and d6(ext[10],imm[10],1'b1);
  and d7(ext[9],imm[9],1'b1);
  and d8(ext[8],imm[8],1'b1);
  and d9(ext[7],imm[7],1'b1);
  and d10(ext[6],imm[6],1'b1);
  and d11(ext[5],imm[5],1'b1);
  and d12(ext[4],imm[4],1'b1);
  and d13(ext[3],imm[3],1'b1);
  and d14(ext[2],imm[2],1'b1);
  and d15(ext[1],imm[1],1'b1);
  and d16(ext[0],imm[0],1'b1);
  
endmodule

//mux4to1 taken from lab 6 stage 1

module mux4to1(a,b,c,d, s, m);
  input a,b,c,d; //1 bit inputs
  input [1:0] s;//2 bit selector
  output m; //result 
  
  wire mux1_output, mux2_output; //temp wires
  
  //instatiate 2 to 1 mux to create 4 to 1 mux
  mux2to1 mux1(a, b, s[0], mux1_output);
  mux2to1 mux2(c, d, s[0], mux2_output);
  mux2to1 mux3(mux1_output, mux2_output, s[1], m);
  
endmodule

//mux32 bit logic taken from mux2to1 logic which was taken from lecture 18, slide 38

module mux32bit(x,y,s,m);
  input [31:0] x,y; //establishing x and y are representing the inputs to select from
  input s; //establishing s represents the input that is the selector for the mux
  output [31:0] m; //establishing that the output of the mux will be connected to m
  
  wire s_not; //creating an internal connection element for the s_not signal
  
  not(s_not,s); //implementing the not gate that takes the input s and nots it
  
  wire [31:0] p1, p2; //temporaries
  
  
  //use mux2to1 logic for each of 32 bits and store in m(result)
  and(p1[31],x[31],s_not);
  and(p2[31],y[31],s);
  or(m[31], p1[31],p2[31]);
  
  and(p1[30],x[30],s_not);
  and(p2[30],y[30],s);
  or(m[30], p1[30],p2[30]);
  
  and(p1[29],x[29],s_not);
  and(p2[29],y[29],s);
  or(m[29], p1[29],p2[29]);
  
  and(p1[28],x[28],s_not);
  and(p2[28],y[28],s);
  or(m[28], p1[28],p2[28]);
  
  and(p1[27],x[27],s_not);
  and(p2[27],y[27],s);
  or(m[27], p1[27],p2[27]);
  
  and(p1[26],x[26],s_not);
  and(p2[26],y[26],s);
  or(m[26], p1[26],p2[26]);
  
  and(p1[25],x[25],s_not);
  and(p2[25],y[25],s);
  or(m[25], p1[25],p2[25]);
  
  and(p1[24],x[24],s_not);
  and(p2[24],y[24],s);
  or(m[24], p1[24],p2[24]);
  
  and(p1[23],x[23],s_not);
  and(p2[23],y[23],s);
  or(m[23], p1[23],p2[23]);
  
  and(p1[22],x[22],s_not);
  and(p2[22],y[22],s);
  or(m[22], p1[22],p2[22]);
  
  and(p1[21],x[21],s_not);
  and(p2[21],y[21],s);
  or(m[21], p1[21],p2[21]);
  
  and(p1[20],x[20],s_not);
  and(p2[20],y[20],s);
  or(m[20], p1[20],p2[20]);
  
  and(p1[19],x[19],s_not);
  and(p2[19],y[19],s);
  or(m[19], p1[19],p2[19]);
  
  and(p1[18],x[18],s_not);
  and(p2[18],y[18],s);
  or(m[18], p1[18],p2[18]);
  
  and(p1[17],x[17],s_not);
  and(p2[17],y[17],s);
  or(m[17], p1[17],p2[17]);
  
  and(p1[16],x[16],s_not);
  and(p2[16],y[16],s);
  or(m[16], p1[16],p2[16]);
  
  and(p1[15],x[15],s_not);
  and(p2[15],y[15],s);
  or(m[15], p1[15],p2[15]);
  
  and(p1[14],x[14],s_not);
  and(p2[14],y[14],s);
  or(m[14], p1[14],p2[14]);
  
  and(p1[13],x[13],s_not);
  and(p2[13],y[13],s);
  or(m[13], p1[13],p2[13]);
  
  and(p1[12],x[12],s_not);
  and(p2[12],y[12],s);
  or(m[12], p1[12],p2[12]);
  
  and(p1[11],x[11],s_not);
  and(p2[11],y[11],s);
  or(m[11], p1[11],p2[11]);
  
  and(p1[10],x[10],s_not);
  and(p2[10],y[10],s);
  or(m[10], p1[10],p2[10]);
  
  and(p1[9],x[9],s_not);
  and(p2[9],y[9],s);
  or(m[9], p1[9],p2[9]);
  
  and(p1[8],x[8],s_not);
  and(p2[8],y[8],s);
  or(m[8], p1[8],p2[8]);
  
  and(p1[7],x[7],s_not);
  and(p2[7],y[7],s);
  or(m[7], p1[7],p2[7]);
  
  and(p1[6],x[6],s_not);
  and(p2[6],y[6],s);
  or(m[6], p1[6],p2[6]);
  
  and(p1[5],x[5],s_not);
  and(p2[5],y[5],s);
  or(m[5], p1[5],p2[5]);
  
  and(p1[4],x[4],s_not);
  and(p2[4],y[4],s);
  or(m[4], p1[4],p2[4]);
  
  and(p1[3],x[3],s_not);
  and(p2[3],y[3],s);
  or(m[3], p1[3],p2[3]);
  
  and(p1[2],x[2],s_not);
  and(p2[2],y[2],s);
  or(m[2], p1[2],p2[2]);
  
  and(p1[1],x[1],s_not);
  and(p2[1],y[1],s);
  or(m[1], p1[1],p2[1]);
  
  and(p1[0],x[0],s_not);
  and(p2[0],y[0],s);
  or(m[0], p1[0],p2[0]);
  
endmodule
 
//mux2to1 taken from lecture 18, slide 38
  
module mux2to1(x,y,s,m);
  input x,y; //establishing x and y are representing the inputs to select from
  input s; //establishing s represents the input that is the selector for the mux
  output m; //establishing that the output of the mux will be connected to m
  
  wire s_not; //creating an internal connection element for the s_not signal
  
  not(s_not,s); //implementing the not gate that takes the input s and nots it
  
  wire p1, p2; //these are intermediates to represent the result of each and gate
  //the choice of p comes from the idea that and is a product operation, so these are product terms
  
  //implement the and gates in the diagram
  and(p1,x,s_not);
  and(p2,y,s);
  
  //produce the outcome m by implementing the or gate
  or(m, p1,p2);
  
endmodule

//1bit full adder taken from lab 5 

module onebitfullAdder (A, B, Cin, S, Cout);

  input  A, B, Cin; //inputs

  output  S, Cout;  //outputs

  wire a1, a2, a3;  //internal connections
  
  //implementation of 1 bit Full Adder
  
  xor u1(a1,A,B);   //a1 = A xor B
  xor u2(S,a1,Cin); // S = a1 xor Cin
  
  and u3(a2,A,B);    // a2 = A and B
  and u4(a3,a1,Cin); // a3 = a1 and Cin
  or u5(Cout,a2,a3); //Cout = a2 or a3
    

endmodule
         