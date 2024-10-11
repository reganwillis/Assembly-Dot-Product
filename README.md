# Assembly Dot Product
## Performance Analysis
We calculate the CPU performance and energy consumption of two different processors as they compute the dot product of two vectors. The processors are described below:
##### Processor A
Processor A uses a subset of the MIPS instruction set architecture (ISA). The key difference in the ISA of Processor A is that there is no multiplication instruction. The instructions used are as follows:
`lw, add, la, li, add, addi, blt`
We assume Processor A to have a clock frequency of 1GHz. Like MIPS, it has a 4-byte word size.
##### Processor B
Processor B uses a larger subset of the MIPS ISA. As stated above, this ISA includes a multiplication instruction, in addition to Processor A's instructions listed above. Like Processor A, we assume Processor B to have a clock frequency of 1GHz. It also uses a 4-byte word size.
### Data
Both processors were tested using four vector pairs of varying lengths: 5, 10, 20, and 50. We shall use the last vector pair, of length 50, for the code testing and performance evaluation. The vector pair, *A* and *B*, and vector length, *n*, are shown below:
```
A = 2, 2, 3, 4, 5, 2, 2, 3, 4, 5, 3, 7, 8, 9, 10, 2, 2, 3, 4, 5, 2, 2, 3, 4, 5, 2, 2, 3, 4, 5, 3, 7, 8, 9, 10, 2, 2, 3, 4, 5, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
B = 3, 7, 8, 9, 10, 2, 2, 3, 4, 5, 3, 7, 8, 9, 10, 2, 2, 3, 4, 5, 2, 2, 3, 4, 5, 2, 2, 3, 4, 5, 3, 7, 8, 9, 10, 2, 2, 3, 4, 5, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
n = 50
```
### Code
TODO: describe code
Two programs were written for calculating the dot product of two vectors. Program A was written for Processer A, and Program B was written for Processor B. We shall first discuss the similar portions of the programs, and then discuss the differences caused by the differing ISA.
A dot product is defined as the sum of the products of two vectors at each index.
TODO: dot product formula
#### Initialization
We start the program by loading the vector length and word size into temporary registers. We also create a variable to hold the result of the dot product. The dot product is initialized to zero and will be increased as each product of the vectors is added to it. We will compute the dot product using a loop, so we also designate a temporary register to hold an iterator variable that will increment by one as each product is calculated. It will run for the vector length. The last step of initialization is to load in the addresses of the two input vectors. The code block below shows the initialization steps:
```
lw $t0, n  # vector length

add $t1, $zero, $zero  # sum: holds the dot product
add $t2, $zero, $zero  # i: dot product loop iterator
lw $t7, word_length

# addresses pointers of vectors A, B
la $t3, A
la $t4, B
```
#### Dot Product Loop
We then create the loop that calculates the dot product. After every loop iteration, we check if the value of our iterator is less than the vector length. When that is no longer true, the loop is allowed to exit. Inside the loop, the first step is to load the vector at each index into a register so that it can be calculated. We use a `load word` instruction with the offset set at 0 and the base register set as the address of the vector at index i. At the end of the loop we increment the address by the word size to load the next index. We also increment the iterator variable. Finally, inside the loop we multiply the vectors at i and add their product to the sum. The multiplication implementation is shown in the section below. The code block below shows the dot product loop, excluding the multiplication.
```
# loop over every index of the vectors
DOT_PRODUCT_LOOP:
    lw $s1, 0($t3)
    lw $s2, 0($t4)

    # ** multiplication goes here **

    add $t1, $t1, $t6  # add product to sum

    addi $t2, $t2, 1  # ++i
    add $t3, $t3, $t7  # address + 4
    add $t4, $t4, $t7  # address + 4

    blt $t2, $t0, DOT_PRODUCT_LOOP  # i < vector length
```
#### Multiplication
As stated above, multiplication is implemented differently for the different processors. Processor A does not include a multiplication instruction, so we implement a loop to add A[i] to itself B[i] times. We implement another iterator and exit the loop when this iterator is greater than or equal to B[i]. The product is stored in a temporary register. The code block for multiplication in Processor A is shown below:
```
    # multiply vectors at i
    li $t5, 0  # j: multiplier loop iterator
    li $t6, 0  # product

    MULTIPLIER_LOOP:
        add $t6, $t6, $s1 

        addi $t5, $t5, 1  # ++j
        blt $t5, $s2, MULTIPLIER_LOOP  # j < b[i]
```
Implementing multiplication in Processor B is much more simple, and only requires one multiplication instruction. The instruction is shown below:
```
# multiply vectors at i
mul $t6, $s1, $s2
```
#### Testing
The result of the dot product from the vectors described in Data is 1666. For both programs, the result is stored in temporary register $t1. The value of $t1 after program execution is shown as 0x00000682, which is 1666 in hexadecimal. The figure below shows the assembled code and register contents after running the program.
TODO: insert results.png
### Evaluation
The assembly code for both processors was assembled and run using MIPS Assembler and Runtime Simulator (MARS) 4.5. The input data used was the vector pair described in Data. We will describe below the CPU performance and energy consumption of the two processors.
We shall also use this information to calculate the MIPS/mW for each processor.
#### CPU Performance
We can calculate the CPU performance with the average number of clock cycles per instruction (CPI) in a workload. We calculate the percentage of each instruction type times the clock cycles per instruction of that type, and add those together. For our purpose, we assume R-type instructions require an average of 3 clocks, I-type instructions require an average of 2 clocks, and J-type instructions require an average of 5 clocks. We will use the MIPS Instruction Counter tool to get the number of each type of instruction.
We calculate CPI with the following equation:
```
CPI = [3(number of R-type instructions) + 2(number of I-type instructions) + 5(number of J-type instructions)] / total number of instructions
```
##### Processor A CPI
Processor A uses 1595 instructions, according to the MIPS Instruction Counter tool. It uses 744 R-type instructions, 850 I-type instructions, and 0 J-type instructions. The result of the instruction counter is shown in the figure below:
TODO: insert processor-A_instruction-counter.png
```
CPI = [3(744) + 2(850) + 5(0)] / 1595
CPI = 3932 / 1595
CPI = 2.47
```
As shown, Processor A uses 2.47 clocks per instruction.
TODO: show a table of results included values collected from MARS
##### Processor B CPI
Processor B uses 461 instructions, according to the MIPS Instruction Counter tool. It uses 252 R-type instructions, 208 I-type instructions, and 0 J-type instructions. The result of the instruction counter is shown in the figure below:
TODO: insert processor-B_instruction-counter.png
```
CPI = [3(461) + 2(208) + 5(0)] / 461
CPI = 1799 / 461
CPI = 3.90
```
As shown, Processor B uses 3.9 clocks per instruction.
TODO: show a table of results included values collected from MARS
#### Energy Consumption
We calculated the energy consumed by both processors assuming an energy consumption per instruction as described below:
* ALU: 2 fj
* Jump: 5 fj
* Branch: 5 fj
* Memory: 20 fj
* Other: 4 fj
We calculate energy consumption with the following equation:
```
Total energy consumption = 2(number of ALU instructions) + 5(number of jump instructions) + 5(number of branch instructions) + 20(number of memory instructions) + 4(number of other-type instructions)
```
##### Processor A Energy Consumption
The MIPS Instruction Statistics tool shows a different number of instructions for Processor A than the MIPS Instruction Counter tool. It shows 1594 instructions. TODO: why? Of these instructions, the number of each instruction is described below:
ALU: 850
Jump: 0
Branch: 321
Memory: 102
Other: 321
TODO: describe the other category
The result is shown in the instructions statistics below:
TODO: insert processor-A_instruction-statistics.png
```
Total energy consumption = 2(850) + 5(0) + 5(321) + 20(102) + 4(321)
Total energy consumption = 1700 + 0 + 1605 + 2040 + 1284
Total energy consumption = 6629 fj
```
As shown above, the total energy consumption for Processor A is 6629 femtojoules.
##### Processor B Energy Consumption
The MIPS Instruction Statistics tool also shows a different number of instructions for Processor A than the MIPS Instruction Counter tool. It shows 460 instructions. TODO: why? Of these instructions, the number of each instruction is described below:
ALU: 208
Jump: 0
Branch: 50
Memory: 102
Other: 100
The result is shown in the instructions statistics below:
TODO: insert processor-B_instruction-statistics.png
```
Total energy consumption = 2(208) + 5(0) + 5(50) + 20(102) + 4(100)
Total energy consumption = 416 + 0 + 250 + 2040 + 400
Total energy consumption = 3106 fj
```
As shown above, the total energy consumption for Processor B is 3106 femtojoules.
#### MIPS/mW
The MIPS per mW for a processor are calculated as simply the MIPS divided by the mW.
MIPS (Million Instructions per Second) is the number of million instructions per second a processor can execute. It is calculated with the equation below:
```
MIPS = (Clock rate)/(CPI x 10^6)
```
Power in milliwatts is the amount of energy over the execution time, shown below:
```
Power (mW) = (Energy/Execution Time) x 10^3
```
Finally, execution time is calculated as described below. It requires the clock period, which can be calculated from the clock frequency, also shown below:
```
Period = 1/Frequency
Execution Time = Clocks x Period
```
##### Processor A
The calculations for MIPS/mW for Processor A are shown below:
```
MIPS = (1 GHz)/(2.47 x 10^6)
MIPS = 2.47 x 10^15

Period = 1/1 GHz
Period = 1 nanosecond

Execution Time = 3932 clocks x 1 nanosecond
Execution Time = 3932 nanoseconds

Power (mW) = (6629 fj/3932 nanoseconds) x 10^3
Power (mW) = (1.686 x 10^-6) x 10^3
Power (mW) = 1.686 x 10^-3

MIPS/mW = (2.47 x 10^15)/(1.686 x 10^-3)
MIPS/mW = 1.465 x 10^18
```
Processor A computes 2.47x10^15 millions of instructions per second for this workload. The workload consumes 1.686x10^-3 milliwatts. The energy efficiency of this processor for this workload is 1.465 x 10^18 MIPS per milliwatt.
TODO: results table
##### Processor B
The calculations for MIPS/mW for Processor B are shown below:
```
MIPS = (1 GHz)/(3.9 x 10^6)
MIPS = 3.9 x 10^15

Period = 1/1 GHz
Period = 1 nanosecond

Execution Time = 1799 clocks x 1 nanosecond
Execution Time = 1799 nanoseconds

Power (mW) = (3106 fj/1799 nanoseconds) x 10^3
Power (mW) = (1.726 x 10^-6) x 10^3
Power (mW) = 1.726 x 10^-3

MIPS/mw = (3.9 x 10^15)/(1.726 x 10^-3)
MIPS/mW = 2.259 x 10^18
```
TODO: results table
Processor B computes 3.9x10^15 millions of instructions per second for this workload. The workload consumes 1.726x10^-3 milliwatts. The energy efficiency of this process for this workload is 2.259 x 10^18 MIPS per milliwatt.
### Conclusion
TODO: Discuss how using different instruction set architectures impacts the performance and energy consumption of the processor.
Processor B, at 3.9 CPI, is slower than Processor A at 2.47 CPI. It uses less instructions, but the instructions require more clocks because they are more complex. Specifically, the multiplication instruction will require more clocks than an addition instruction, which can be used repeatedly for multiplication.
Processor A consumes over twice the energy that Processor B consumes. This is because the instruction count of Processor A is over three times the instruction count of Processor B. More instructions use more energy.
Processor B has a higher MIPS per milliwatt than Processor A, meaning it is more energy efficient for this particular workload.
Overall, Processor B is slower but more energy efficient than Processor A for the workload of computing a dot product for two vectors of size 50.
