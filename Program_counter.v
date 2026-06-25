
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
