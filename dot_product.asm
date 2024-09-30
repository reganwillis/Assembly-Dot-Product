# MIPS program to calculate the dot product of two vectors.
# Description:  Two vectors are hardcoded in, the dot product is calculated,
#               and the result is diaplayed in decimal.
# Tested using MARS 4.5 simulator with inputs: TODO
# Bugs and Concerns:    Input vectors must be of the same length.

a = [2, 2, 3, 4, 5]  # TODO: store in $s1
b = [3, 7, 8, 9, 10]  # TODO: store in $s2
addi $t0, $zero, 5  # vector length

add $t1, $zero, $zero  # sum: holds the dot product
add $t2, $zero, $zero  # i: dot product loop iterator

# loop over every index of the vectors

# load vectors at the index
# TODO: compute offset
lw $t3, $t2($s1)  # a[i] 2
lw $t4, $t2($s2)  # b[i] 3

# multiply vectors at i
add $t5, $zero, $zero  # j: multiplier loop iterator
add $t6, $zero, $zero  # product
add $t6, $t6, $t3
addi $t5, $t5, 1  # ++j
blt $t4, $t5, L22  # b[i] < j

add $t1, $t1, $t6  # add product to sum
addi $t2, $t2, 1  # ++i
blt $t2, $t0, L26  # i < vector length
