`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026 12:11:47
// Design Name: 
// Module Name: Register
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


module RegisterFile(
input [4:0] addr1,
input [4:0] addr2,
input [4:0] regdest,
input clk,
input reset,
input regload,
input [31:0] writedata,
output  [31:0] readr1,
output  [31:0] readr2
);
integer i;
reg [31:0] R[31:0];
assign readr1=R[addr1];
assign readr2=R[addr2];
always @(posedge clk)
begin
if(reset)
begin
for(i=0;i<32;i=i+1)
R[i]<=32'b0;
end
else 
begin
if (regload)
begin
if(regdest!=5'b0)
R[regdest]<=writedata;
end
end
end
endmodule
