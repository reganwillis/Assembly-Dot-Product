# calculate the dot product of two vectors

# NOTE: vectors should be hardcoded
# NOTE: vectors must be equal lengths
a = [1, 2, 3, 4, 5]
b = [6, 7, 8, 9, 10]
vector_length = 5

sum = $zero  # var to hold the dot product
i = $zero  # create iterator var

# loop over every index of the vectors
$t1 = mul(a[i], b[i])
sum = sum + $t1
++i
if i < vector_length: goto line 13  # loop condition
