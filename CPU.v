
module CPU(
    input clk,
    input reset,
    output [31:0] PC_out,
    output [31:0] instruction_out,
    output [31:0] ALU_out
);

wire [31:0] PC;
wire [31:0] PC_next;
wire [31:0] instruction;

wire Jump;
wire Branch;
wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;

wire [1:0] ALUOp;
wire [1:0] MemtoReg;

wire [31:0] immediate;

wire [31:0] readr1;
wire [31:0] readr2;

wire [3:0] ALUcontrol;

wire [31:0] ALU_B;
wire [31:0] ALU_result;
wire [31:0] ALU_A;



wire zero;
wire beq_taken;
wire bne_taken;
wire blt_taken;
wire bge_taken;
wire branch_taken;

wire [31:0] PC_branch;

wire [31:0] memory_data;
wire [31:0] write_back_data;

wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;
assign ALU_A =
       (instruction[6:0] == 7'b0010111) ? PC :
       readr1;
assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];
assign rd  = instruction[11:7];

assign ALU_B = (ALUSrc) ? immediate : readr2;

assign write_back_data =
        (MemtoReg == 2'b00) ? ALU_result :
        (MemtoReg == 2'b01) ? memory_data :
        (MemtoReg == 2'b10) ? (PC + 32'd4) :
                              immediate;
                            



assign PC_out          = PC;
assign instruction_out = instruction;
assign ALU_out         = ALU_result;

assign PC_branch = PC + immediate;

assign PC_next =
       (branch_taken || Jump) ?
       PC_branch :
       (PC + 32'd4);

assign beq_taken =
       Branch &&
       (instruction[14:12] == 3'b000) &&
       zero;

assign bne_taken =
       Branch &&
       (instruction[14:12] == 3'b001) &&
       !zero;

assign blt_taken =
       Branch &&
       (instruction[14:12] == 3'b100) &&
       ($signed(readr1) < $signed(readr2));

assign bge_taken =
       Branch &&
       (instruction[14:12] == 3'b101) &&
       ($signed(readr1) >= $signed(readr2));

assign branch_taken =
       beq_taken ||
       bne_taken ||
       blt_taken ||
       bge_taken;
       
       

ProgramCounter PC_unit(
    .clk(clk),
    .reset(reset),
    .PC_next(PC_next),
    .PC(PC)
);

InstructionMemory IM(
    .address(PC),
    .instruction(instruction)
);

Control_unit CU(
    .opcode(instruction[6:0]),
    .Jump(Jump),
    .Branch(Branch),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .ALUOp(ALUOp),
    .MemtoReg(MemtoReg),
    .MemRead(MemRead),
    .MemWrite(MemWrite)
);

RegisterFile RF(
    .addr1(rs1),
    .addr2(rs2),
    .regdest(rd),
    .clk(clk),
    .reset(reset),
    .regload(RegWrite),
    .writedata(write_back_data),
    .readr1(readr1),
    .readr2(readr2)
);

ImmediateGenerator IG(
    .instruction(instruction),
    .immediate(immediate)
);

Alu_control AC(
    .Aluop(ALUOp),
    .func3(instruction[14:12]),
    .func7(instruction[31:25]),
    .ALUcontrol(ALUcontrol)
);

ALU ALU_unit(
    .ALUcontrol(ALUcontrol),
    .A(ALU_A),
    .B(ALU_B),
    .zero(zero),
    .ALU_result(ALU_result)
);

DataMemory DM(
    .clk(clk),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .address(ALU_result),
    .write_data(readr2),
    .read_data(memory_data)
);

endmodule
