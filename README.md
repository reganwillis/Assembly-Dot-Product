# Assembly Dot Product
## Performance Analysis
We calculate the CPU performance and energy consumption of two different processors as they compute the dot product of two vectors. The processors are described below:
##### Processor A
Processor A uses a subset of the MIPS instruction set architecture (ISA). The key difference in the ISA of Processor A is that there is no multiplication instruction. The instructions used are as follows:
lw, add, la, li, add, addi, blt
We assume Processor A to have a clock frequency of 1GHz.
##### Processor B
Processor B uses a larger subset of the MIPS ISA. As stated, this ISA includes a multiplication instruction, in addition to Processor A's instructions listed above. Like Processor A, we assume Processor B to have a clock frequency of 1GHz.
### Data
Both processors were tested using four vector pairs of varying lengths: 5, 10, 20, and 50. We shall use the last vector pair, of length 50, for the code testing and performance evaluation. The vector pair, A and B, is shown below:
TODO: print out the two vectors
### Code
TODO: describe code
TODO: make note of how offset was calculated for lw
#### Testing
The result of the dot product should be TODO. When running both processors, the result was stored to register TODO.
TODO: insert screenshot of results from MARS
### Evaluation
The assembly code for both processors was assembled and run using MIPS Assembler and Runtime Simulator (MARS) 4.5. The input data used was the vector pair described in Data. We will describe below the CPU performance and energy consumption of the two processors.
We shall also use this information to calculate the MIPS/mW for each processor.
#### CPU Performance
TODO: describe Clocks per Instruction (CPI) including how it is calculated
We assume R-type instructions require an average of 3 clocks, I-type instructions require an average of 2 clocks, and J-type instructions require an average of 5 clocks.
##### Processor A CPI
Processor A uses 209 instructions, according to the MIPS Instruction Counter tool. It uses 96 R-type instructions, 112 I-type instructions, and no J-type instructions. The result of the instruction counter is shown in the figure below:
TODO: insert instruction counter screenshot
TODO: show a table of results included values collected from MARS
##### Processor B CPI
Processor B uses 56 instructions, according to the MIPS Instruction Counter tool. It uses 27 R-type instructions, 28 I-type instructions, and no J-type instructions. The result of the instruction counter is shown in the figure below:
TODO: insert instruction counter screenshot
TODO: show a table of results included values collected from MARS
#### Energy Consumption
We calculated the energy consumed by both processors assuming an energy consumption per instruction as described below:
1) ALU: 2 fj
2) Jump: 5 fj
3) Branch: 5 fj
4) Memory: 20 fj
5) Other: 4 fj
##### Processor A Energy Consumption
The MIPS Instruction Statistics tool shows a different number of instructions for Processor A than the MIPS Instruction Counter tool. It shows 208 instructions. TODO: why? Of these instructions, the number of each instruction is described below:
ALU: 112
Jump: 0
Branch: 42
Memory: 12
Other: 42
TODO: describe the other category
The result is shown in the instructions statistics below:
TODO: insert instruction statistics screenshot
##### Processor B Energy Consumption
The MIPS Instruction Statistics tool also shows a different number of instructions for Processor A than the MIPS Instruction Counter tool. It shows 55 instructions. TODO: why? Of these instructions, the number of each instruction is described below:
ALU: 28
Jump: 0
Branch: 5
Memory: 12
Other: 10
The result is shown in the instructions statistics below:
TODO: insert instruction statistics screenshot
#### MIPS/mW
TODO: describe MIPS/mW including how it is calculated
##### Processor A
TODO
TODO: results table
##### Processor B
TODO
TODO: results table
### Conclusion
TODO
TODO: Discuss how using different instruction set architectures impacts the performance and energy consumption of the processor.
