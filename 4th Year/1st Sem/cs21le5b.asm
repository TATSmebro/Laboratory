# CS 21 WFR/FYZ -- S1 AY 2024-2025
# PILAPIL, Marcus Corso S. -- 10/02/2024
# cs21le5b.asm -- Fibonacci Recurssion

.text
main:
    	# Prompt and get input for x (fib(0))
    	li $v0, 4
    	la $a0, promptX
    	syscall

    	li $v0, 5
    	syscall
    	move $s0, $v0		# store input x into $s0`

    	# Prompt and get input for y (fib(1))
    	li $v0, 4
    	la $a0, promptY
    	syscall

    	li $v0, 5
    	syscall
    	move $s1, $v0		# store input y into $s1

    	# Prompt and get input for n
    	li $v0, 4
    	la $a0, promptN
    	syscall

    	li $v0, 5
    	syscall
    	move $s2, $v0		# store input n into $s2

    	# Call fib function
    	jal fib

    	# Print the result
    	move $t1, $v0
    	
    	li $v0, 4
    	la $a0, result
    	syscall

    	move $a0, $t1          # move the return value (Fibonacci number) into $a0 for printing
    	li $v0, 1
    	syscall

    	# Exit
    	li $v0, 10
    	syscall

# Recursive Fibonacci function
fib:
    	###### PREAMBLE ######
    	subu $sp, $sp, 32
    	sw $ra, 20($sp)
    	sw $s0, 16($sp)
    	sw $s1, 12($sp)
    	sw $s2, 8($sp)
    	sw $s3, 4($sp)
	###### PREAMBLE ######

    	# Base case 1: if n == 0, return x
    	beqz $s2, ret_x

    	# Base case 2: if n == 1, return y
    	li $t0, 1		# load 1 into $t0
    	beq $s2, $t0, ret_y

    	# Recursive case: fib(n) = fib(n-1) + fib(n-2)
    	subi $s2, $s2, 1	# n = n - 1
    	jal fib			# recursive call fib(n-1)
    
    	# Save result of fib(n-1) in $s3
    	move $s3, $v0

    	# Now compute fib(n-2)
    	lw $s2, 8($sp)		# Restore n (before it was decremented)
    	subi $s2, $s2, 2	# n = n - 2
    	jal fib			# recursive call fib(n-2)

    	# Sum the results of fib(n-1) and fib(n-2)
    	add $v0, $s3, $v0	# fib(n) = fib(n-1) + fib(n-2)

    	###### END ######
    	lw $s0, 16($sp)
    	lw $s1, 12($sp)
    	lw $s2, 8($sp)
    	lw $s3, 4($sp)
    	lw $ra, 20($sp)
    	addu $sp, $sp, 32
    	###### END ######
    	
    	jr $ra

ret_x:
    	# Return x (fib(0))
    	move $v0, $s0          # move x into $v0 (return value)

    	###### END ######
    	lw $s0, 16($sp)
    	lw $s1, 12($sp)
    	lw $s2, 8($sp)
    	lw $s3, 4($sp)
    	lw $ra, 20($sp)
    	addu $sp, $sp, 32
    	###### END ######
    	
    	jr $ra

ret_y:
    	# Return y (fib(1))
    	move $v0, $s1

    	###### END ######
    	lw $s0, 16($sp)
    	lw $s1, 12($sp)
    	lw $s2, 8($sp)
    	lw $s3, 4($sp)
    	lw $ra, 20($sp)
    	addu $sp, $sp, 32
    	###### END ######
    	
    	jr $ra


.data
promptX:    .asciiz "Enter the value for fib(0): "
promptY:    .asciiz "Enter the value for fib(1): "
promptN:    .asciiz "Enter the value for n: "
result:     .asciiz "\nThe nth Fibonacci number is: "