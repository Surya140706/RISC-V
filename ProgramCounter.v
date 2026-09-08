`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.06.2026 14:21:29
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(
    input clk,
    input reset,
    input [31:0] PC_next,
    output reg [31:0] PC
);

always @(posedge clk)
begin
    if(reset)
        PC <= 32'd0;
    else
        PC <= PC_next;
end

endmodule