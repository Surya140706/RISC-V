module Control_unit(
    input [6:0] opcode,
    output Jump,
    output Branch,
    output RegWrite,
    output ALUSrc,
    output [1:0] ALUOp,
    output [1:0] MemtoReg,
    output MemRead,
    output MemWrite
);

//| Instruction | ALUSrc | MemtoReg1 | MemtoReg0 | RegWrite | MemRead | MemWrite | Branch | ALUOp1 | ALUOp0 | Jump |
//|-------------|---------|-----------|-----------|----------|---------|----------|--------|--------|--------|------|
//| R           |    0    |     0     |     0     |    1     |    0    |    0     |   0    |   1    |   0    |  0   |
//| LOAD        |    1    |     0     |     1     |    1     |    1    |    0     |   0    |   0    |   0    |  0   |
//| I           |    1    |     0     |     0     |    1     |    0    |    0     |   0    |   1    |   1    |  0   |
//| STORE       |    1    |     X     |     X     |    0     |    0    |    1     |   0    |   0    |   0    |  0   |
//| BR          |    0    |     X     |     X     |    0     |    0    |    0     |   1    |   0    |   1    |  0   |
//| U1 (LUI)    |    X    |     1     |     0     |    1     |    0    |    0     |   0    |   X    |   X    |  0   |
//| U2 (AUIPC)  |    1    |     0     |     0     |    1     |    0    |    0     |   0    |   0    |   0    |  0   |
//| J1 (JAL)    |    X    |     1     |     1     |    1     |    0    |    0     |   0    |   X    |   X    |  1   |
//| J2 (JALR)   |    1    |     1     |     1     |    1     |    0    |    0     |   0    |   0    |   0    |  1   |

parameter R = 7'b0110011;    //REGISTER
parameter LOAD = 7'b0000011;  //MEMORY LOAD
parameter I = 7'b0010011;   // ARTHEMETIC IMMEDIATE
parameter STORE  = 7'b0100011;
parameter BR = 7'b1100011;  // BRANCH TYPE
parameter U1    = 7'b0110111;  // LUI
parameter U2 = 7'b0010111;  // AUIPC
parameter J1   = 7'b1101111; //JAL
parameter J2   = 7'b1100111;  //JALR

assign Branch      = (opcode == BR);

assign Jump        = (opcode == J1) || (opcode == J2);

assign MemWrite    = (opcode == STORE);

assign MemRead     = (opcode == LOAD);

assign ALUSrc      = (opcode == LOAD) || (opcode == I) || (opcode == STORE) || (opcode == U2) || (opcode == J2);

assign RegWrite    = (opcode == R) || (opcode == LOAD) || (opcode == I) || (opcode == U1) || (opcode == U2) || (opcode == J1) || (opcode == J2);

assign ALUOp[1]    = (opcode == R) || (opcode == I);

assign ALUOp[0]    = (opcode == BR) || (opcode == I);

assign MemtoReg[1] = (opcode == U1) || (opcode == J1) || (opcode == J2);

assign MemtoReg[0] = (opcode == LOAD) || (opcode == U1);



endmodule
