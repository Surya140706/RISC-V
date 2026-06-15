RV32I 32-Bit Single-Cycle RISC-V Processor

This project implements a 32-bit Single-Cycle RISC-V Processor based on the RV32I instruction set architecture using Verilog HDL. The processor executes each instruction in a single clock cycle and includes all essential datapath and control modules required for instruction fetch, decode, execute, memory access, and write-back operations.

Key features:

Supports the RV32I base integer instruction set.
Single-cycle datapath architecture.
Modular Verilog design for easy understanding and debugging.
Separate Instruction Memory and Data Memory modules.
ALU supporting arithmetic, logical, comparison, and shift operations.
Control Unit for instruction decoding and control signal generation.
Register File with 32 general-purpose registers.
Immediate Generator and Branch Control Logic.
Designed and simulated using Xilinx Vivado.

Modules included:

Program Counter (PC)
Instruction Memory
Control Unit
Register File
Immediate Generator
ALU Control Unit
Arithmetic Logic Unit (ALU)
Data Memory
Branch and Jump Logic
Multiplexers and Supporting Datapath Components

The project serves as an educational implementation of the RISC-V architecture and provides a foundation for future enhancements such as pipelining, hazard handling, forwarding, cache integration, and FPGA deployment.
