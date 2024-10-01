# MIPS program to calculate the dot product of two vectors.
# Description:  Two vectors are hardcoded in, the dot product is calculated,
#               and the result is diaplayed in decimal.
# Tested using MARS 4.5 simulator with inputs: TODO
# Bugs and Concerns:
#   Input vectors must be of the same length.

.data

A: .word 2, 2, 3, 4, 5
B: .word 3, 7, 8, 9, 10
n: .word 5
word_length: .word 4

.text
lw $t0, n  # vector length

add $t1, $zero, $zero  # sum: holds the dot product
add $t2, $zero, $zero  # i: dot product loop iterator
lw $t7, word_length

# addresses pointers of vectors A, B
la $t3, A
la $t4, B

# loop over every index of the vectors
DOT_PRODUCT_LOOP:
	lw $s1, 0($t3)
	lw $s2, 0($t4)

	# multiply vectors at i
	li $t5, 0  # j: multiplier loop iterator
	li $t6, 0  # product

	MULTIPLIER_LOOP:
		add $t6, $t6, $s1

		addi $t5, $t5, 1  # ++j
		blt $s2, $t5, MULTIPLIER_LOOP  # b[i] < j

	add $t1, $t1, $t6  # add product to sum

	addi $t2, $t2, 1  # ++i
	add $t3, $t3, $t7  # address + 4
	add $t4, $t4, $t7  # address + 4

	blt $t2, $t0, DOT_PRODUCT_LOOP  # i < vector length


































