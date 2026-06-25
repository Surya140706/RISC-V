module Alu_control(
    input [1:0] Aluop,
    input [2:0] func3,
    input [6:0] func7,
    output reg [3:0] ALUcontrol
);

parameter [3:0] ADD  = 4'b0000;
parameter [3:0] SUB  = 4'b0001;
parameter [3:0] AND  = 4'b0010;
parameter [3:0] OR   = 4'b0011;
parameter [3:0] XOR  = 4'b0100;
parameter [3:0] SLL  = 4'b0101;
parameter [3:0] SRL  = 4'b0110;
parameter [3:0] SRA  = 4'b0111;
parameter [3:0] SLT  = 4'b1000;
parameter [3:0] SLTU = 4'b1001;

always @(*)
begin
    case(Aluop)

        // LOAD / STORE
        2'b00:
            ALUcontrol = ADD;

        // BRANCH
        2'b01:
        begin
            case(func3)

                3'b000: ALUcontrol = SUB; // BEQ

                3'b001: ALUcontrol = SUB; // BNE

                3'b100: ALUcontrol = SLT; // BLT

                3'b101: ALUcontrol = SLT; // BGE

                default: ALUcontrol = ADD;

            endcase
        end

        // R-TYPE
        2'b10:
        begin
            case(func3)

                3'b000:
                    ALUcontrol = (func7[5]) ? SUB : ADD;

                3'b001:
                    ALUcontrol = SLL;

                3'b010:
                    ALUcontrol = SLT;

                3'b011:
                    ALUcontrol = SLTU;

                3'b100:
                    ALUcontrol = XOR;

                3'b101:
                    ALUcontrol = (func7[5]) ? SRA : SRL;

                3'b110:
                    ALUcontrol = OR;

                3'b111:
                    ALUcontrol = AND;

                default:
                    ALUcontrol = ADD;

            endcase
        end

        // I-TYPE
        2'b11:
        begin
            case(func3)

                3'b000:
                    ALUcontrol = ADD;   // ADDI

                3'b001:
                    ALUcontrol = SLL;   // SLLI

                3'b010:
                    ALUcontrol = SLT;   // SLTI

                3'b011:
                    ALUcontrol = SLTU;  // SLTIU

                3'b100:
                    ALUcontrol = XOR;   // XORI

                3'b101:
                    ALUcontrol = (func7[5]) ? SRA : SRL;

                3'b110:
                    ALUcontrol = OR;    // ORI

                3'b111:
                    ALUcontrol = AND;   // ANDI

                default:
                    ALUcontrol = ADD;

            endcase
        end

        default:
            ALUcontrol = ADD;

    endcase
