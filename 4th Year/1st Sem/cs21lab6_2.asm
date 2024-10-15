.data
f_a:    .float -25.6046352386474609375
f_b:    .float -8.25049304962158203125     
f_c:    .float 0.0         

.text
main:
	# Load the IEEE-754 representations of 3.75 and -5.125 as integers
	lw $t0, f_a           
	lw $t1, f_b            

    	# Step 1: Extract the components of each IEEE-754 operand
    	# For 3.75 ($t0)
    	andi $t2, $t0, 0x80000000  # Extract the sign of $t0 -> $t2 (0 if positive)
    	srl  $t3, $t0, 23          # Shift right to get exponent of $t0-> $t3
    	andi $t3, $t3, 0xFF        # Mask to keep only the 8-bit exponent -> $t3
    	andi $t4, $t0, 0x7FFFFF    # Mask to get mantissa of $t0-> $t4
    	ori  $t4, $t4, 0x800000    # Add the implicit leading 1 to mantissa -> $t4 (mantissa = 0x00f00000)

    	# For -5.125 ($t1)
    	andi $t5, $t1, 0x80000000  # Extract the sign of $t1 -> $t5
    	srl  $t6, $t1, 23          # Shift right to get exponent of $t1 -> $t6
    	andi $t6, $t6, 0xFF        # Mask to keep only the 8-bit exponent -> $t6
    	andi $t7, $t1, 0x7FFFFF    # Mask to get mantissa of $t1 -> $t7
    	ori  $t7, $t7, 0x800000    # Add the implicit leading 1 to mantissa -> $t7 (mantissa = 0x00a40000)

    	# Step 2: Adjust the exponents to match
    	blt  $t6, $t3, f_bless
    	sub  $t8, $t6, $t3         # Compute exponent difference: $t8 = exp($t6) - exp($t3)
    	srlv $t4, $t4, $t8         # Shift $t4 right by the difference -> $t4
    	move $t3, $t6              # Set final exponent
    	slt  $s1, $t4, $t7	   # Set $s1 to 1 if $t7 > $t4
	j step3
	
f_bless:
	sub  $t8, $t3, $t6         # Compute exponent difference: $t8 = exp($t3) - exp($t6)
    	srlv $t7, $t7, $t8         # Shift $t4 right by the difference-> $t4 
    	move $t6, $t3              # Set final exponent

step3:
    	# Step 3: If the operand is negative, convert the mantissa to two's complement
    	beq  $t5, $zero, skip_negate   # If sign of $t1 is positive, skip
    	not  $t7, $t7              
    	addi $t7, $t7, 1         
    	
    	beq  $t2, $zero, skip_negate   # If sign of $t0 is positive, skip
    	not  $t4, $t4             
    	addi $t4, $t4, 1           

skip_negate:
    	# Step 4: Add the mantissas
    	add  $t9, $t4, $t7         # Add the mantissas

    	# Step 5: Check the result's sign and convert back to signed magnitude if necessary
    	bltz $t9, handle_negative_result  # If $t9 is negative, convert it back to signed magnitude
    	j normalization

handle_negative_result:
    	not  $t9, $t9              # Invert the bits
    	addi $t9, $t9, 1           # Add 1 to convert to signed magnitude -> $t9 

	
normalization:
	addi $s2, $s2, 8

normloop:
    	# Step 6: Normalize the result (ensure the implicit 1 is at bit 23)
    	bltz $t9, normalized 
    	sll  $t9, $t9, 1
    	subi $s2, $s2, 1	# $s2 = shift counter
    	j normloop
    	
normalized:
	srl  $t9, $t9, 8
    	add  $t3, $t3, $s2           # Decrease the exponent by shamt -> $t3

    	# Step 7: Compose the final IEEE-754 result
    	sll  $t3, $t3, 23          # Shift the exponent to its correct position -> $t3
    	andi $t9, $t9, 0x7FFFFF    # Mask to keep only 23 bits of mantissa
    	or   $t9, $t9, $t3         # Combine exponent and mantissa
    	
    	# Check which sign to copy
    	bnez  $s1, copy_fb

copy_fa:    	
    	or   $t9, $t9, $t2         # Combine sign, exponent, and mantissa
	j store

copy_fb:
	or   $t9, $t9, $t5         # Combine sign, exponent, and mantissa

store:
    	# Store the result back into memory as a floating-point number
    	sw $t9, f_c                # Store result in f_c

    	# Exit the program
    	li $v0, 10                 # Exit system call
    	syscall
