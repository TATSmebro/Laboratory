# CS 21 WFR/FYZ -- S1 AY 2024-2025
# PILAPIL, Marcus Corso S. -- 10/09/2024
# cs21lab6_1.asm -- Shifting and Masking

.text
main:
    	# Prompt and get input for x (fib(0))
    	li $v0, 4
    	la $a0, prompt
    	syscall
    	
    	# Get input
    	li $v0, 5
    	syscall
    	move $s0, $v0
   
   	li $t0, 0x80000000	# $t0 = 1000 0000 0000 0000 0000 0000 0000 0000
   	
    	# For Output 1
	li $s1, 0xFFFFFFFF	# $s1 = 1111 1111 1111 1111 1111 1111 1111 1111
    	move $s3, $s0

check_MSB:
    	bltz $s3, for_out1	# If MSB is found, proceed to next step
    	addi $t3, $t3, 1	# $t3 -> MSB Counter; Increment Counter
    	sll $s3, $s3, 1		# Shift input left by 1
    	j check_MSB
    	
for_out1:
	srlv $s1, $s1, $t3
    	# For Output 1

	 	 	
    	# For Output 2 
    	andi $t1, $s0, 15	# Isolate bits3-0
    	beqz $t1, zero		# If 0, output 0
    	subi $t2, $t1, 1	# Subtract 1 to shamt since there is already a 1 in MSB
    	srav $s2, $t0, $t2	# Shift right arithmetic by $t2 amount to add 1s to the left
    	or $s2, $s2, $t1	# Combine result and 3-0 bits from input
    	j output
    	# For Output 2
   
    	
zero:	
	move $s2, $t1

output:    	
    	# Print output 1
    	li $v0, 4
    	la $a0, result1
    	syscall

    	move $a0, $s1
    	li $v0, 1
    	syscall
    	
    	# Print output 2
    	li $v0, 4
    	la $a0, result2
    	syscall

    	move $a0, $s2
    	li $v0, 1
    	syscall
    	
    	# Exit
    	li $v0, 10
    	syscall


.data
prompt:    .asciiz "Enter an Integer: "
result1:    .asciiz "Output 1: "
result2:    .asciiz "Output 2: "
