

module InstructionMemory(
    input [31:0] address,
    output [31:0] instruction
);

reg [31:0] memory [0:255];

initial
begin
      // addi x2,x0,5
    memory[0] = 32'h00500113;

    // auipc x1,1
    memory[1] = 32'h00001097;

end

assign instruction = memory[address[31:2]];

endmodule
