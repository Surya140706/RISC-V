`timescale 1ns / 1ps

module ImmediateGenerator(
    input [31:0] instruction,
    output reg [31:0] immediate
);

parameter R      = 7'b0110011;   // REGISTER
parameter LOAD   = 7'b0000011;   // LOAD
parameter I      = 7'b0010011;   // ARITHMETIC IMMEDIATE
parameter STORE  = 7'b0100011;   // STORE
parameter BR     = 7'b1100011;   // BRANCH
parameter U1     = 7'b0110111;   // LUI
parameter U2     = 7'b0010111;   // AUIPC
parameter J1     = 7'b1101111;   // JAL
parameter J2     = 7'b1100111;   // JALR

wire [6:0] opcode;

assign opcode = instruction[6:0];

always @(*)
begin
    case(opcode)

        LOAD,
        I,
        J2:
            immediate = {{20{instruction[31]}}, instruction[31:20]};

        STORE:
            immediate = {{20{instruction[31]}},
                         instruction[31:25],
                         instruction[11:7]};

        BR:
            immediate = {{19{instruction[31]}},
                         instruction[31],
                         instruction[7],
                         instruction[30:25],
                         instruction[11:8],
                         1'b0};

        U1,
        U2:
            immediate = {instruction[31:12], 12'b0};

        J1:
            immediate = {{11{instruction[31]}},
                         instruction[31],
                         instruction[19:12],
                         instruction[20],
                         instruction[30:21],
                         1'b0};

        default:
            immediate = 32'd0;

    endcase
end
