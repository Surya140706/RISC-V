`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2026 14:27:34
// Design Name: 
// Module Name: DataMemory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DataMemory(
    input clk,
    input MemRead,
    input MemWrite,
    input [31:0] address,
    input [2:0] func3,
    input [31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] memory [0:255];

wire [31:0] raw_read = memory[address[31:2]];

always @(*) begin
    if (MemRead) begin
        case(func3)
            3'b000: begin // LB
                case(address[1:0])
                    2'b00: read_data = {{24{raw_read[7]}}, raw_read[7:0]};
                    2'b01: read_data = {{24{raw_read[15]}}, raw_read[15:8]};
                    2'b10: read_data = {{24{raw_read[23]}}, raw_read[23:16]};
                    2'b11: read_data = {{24{raw_read[31]}}, raw_read[31:24]};
                endcase
            end
            3'b100: begin // LBU
                case(address[1:0])
                    2'b00: read_data = {24'b0, raw_read[7:0]};
                    2'b01: read_data = {24'b0, raw_read[15:8]};
                    2'b10: read_data = {24'b0, raw_read[23:16]};
                    2'b11: read_data = {24'b0, raw_read[31:24]};
                endcase
            end
            3'b001: begin // LH
                case(address[1])
                    1'b0: read_data = {{16{raw_read[15]}}, raw_read[15:0]};
                    1'b1: read_data = {{16{raw_read[31]}}, raw_read[31:16]};
                endcase
            end
            3'b101: begin // LHU
                case(address[1])
                    1'b0: read_data = {16'b0, raw_read[15:0]};
                    1'b1: read_data = {16'b0, raw_read[31:16]};
                endcase
            end
            3'b010: begin // LW
                read_data = raw_read;
            end
            default: read_data = raw_read;
        endcase
    end else begin
        read_data = 32'b0;
    end
end

always @(posedge clk)
begin
    if(MemWrite) begin
        case(func3)
            3'b000: begin // SB
                case(address[1:0])
                    2'b00: memory[address[31:2]] <= {memory[address[31:2]][31:8], write_data[7:0]};
                    2'b01: memory[address[31:2]] <= {memory[address[31:2]][31:16], write_data[7:0], memory[address[31:2]][7:0]};
                    2'b10: memory[address[31:2]] <= {memory[address[31:2]][31:24], write_data[7:0], memory[address[31:2]][15:0]};
                    2'b11: memory[address[31:2]] <= {write_data[7:0], memory[address[31:2]][23:0]};
                endcase
            end
            3'b001: begin // SH
                case(address[1])
                    1'b0: memory[address[31:2]] <= {memory[address[31:2]][31:16], write_data[15:0]};
                    1'b1: memory[address[31:2]] <= {write_data[15:0], memory[address[31:2]][15:0]};
                endcase
            end
            3'b010: begin // SW
                memory[address[31:2]] <= write_data;
            end
            default: memory[address[31:2]] <= write_data;
        endcase
    end
end

endmodule