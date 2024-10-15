# CS 21 WFR/FYZ -- S1 AY 2024-2025
# PILAPIL, Marcus Corso S. -- 10/02/2024
# cs21le5a.asm -- GCD Recurssion


.text
main:
    	# Prompt and get the first input (a)
    	li $v0, 4              # print_string
    	la $a0, prompt1        
    	syscall

    	li $v0, 5		# read_int
    	syscall
    	move $s0, $v0          

    	# Prompt and get the second input (b)
    	li $v0, 4		
    	la $a0, prompt2        
    	syscall

    	li $v0, 5		
    	syscall
    	move $s1, $v0          

    	# Call gcd function
    	move $a0, $s0		
    	move $a1, $s1		
    	jal gcd

    	# Print the result
    	move $t0, $v0
    	
    	li $v0, 4		
    	la $a0, result
    	syscall

    	move $a0, $t0          
    	li $v0, 1              
    	syscall

    	# Exit
    	li $v0, 10
    	syscall

# Recursive GCD function
gcd:
    	###### PREAMBLE ######
    	subu $sp, $sp, 16       
    	sw $ra, 12($sp)         
	###### PREAMBLE ######

    	# Base case: if b == 0, return a
    	beqz $a1, ret_a

    	# Compute remainder(a, b) and store it in $s2
    	div $a0, $a1		# divide a by b
    	mfhi $s1		# get the remainder

    	# Recursive call gcd(b, remainder(a, b))
    	move $a0, $a1          
    	move $a1, $s1         
    	jal gcd                

    	###### END ######
    	lw $ra, 12($sp)
    	addu $sp, $sp, 16
    	###### END ######
    	
    	jr $ra

ret_a:
    	# Base case: return a
    	move $v0, $a0
    	
    	###### END ######
    	lw $ra, 12($sp)
    	addu $sp, $sp, 16
    	###### END ######
    	
    	jr $ra


.data

prompt1:    .asciiz "Enter the first number: "
prompt2:    .asciiz "Enter the second number: "
result:     .asciiz "\nThe GCD is: "