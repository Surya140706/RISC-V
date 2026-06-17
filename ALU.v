module ALU(
input [3:0] ALUcontrol,
input [31:0] A,
input [31:0] B,
output zero,
output reg [31:0] ALU_result
    );
    
parameter [3:0] ADD  = 4'b0000;
parameter [3:0] SUB  = 4'b0001;
parameter [3:0] AND = 4'b0010;
parameter [3:0] OR = 4'b0011;
parameter [3:0] XOR = 4'b0100;
parameter [3:0] SLL  = 4'b0101;
parameter [3:0] SRL  = 4'b0110;
parameter [3:0] SRA  = 4'b0111;
parameter [3:0] SLT  = 4'b1000;
parameter [3:0] SLTU = 4'b1001;
    
    assign zero=(ALU_result==32'b0);
    always @(*)
    begin
    case(ALUcontrol)
    ADD:ALU_result=A+B;
    SUB:ALU_result=A-B;
    AND:ALU_result=A&B;
    OR:ALU_result=A|B;
    XOR:ALU_result=A^B;
    SLL:ALU_result=A << B[4:0];
    SRL:ALU_result=A >> B[4:0];
    SRA:ALU_result=$signed(A)>>>B[4:0];
    SLT:ALU_result=($signed(A)<$signed(B))? 32'b1:32'b0;
    SLTU:ALU_result=(A<B)? 32'b1:32'b0;
    default: ALU_result=32'b0;
    endcase
    end
endmodule
