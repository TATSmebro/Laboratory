# CS 21 WFR/FYZ -- S1 AY 2024-2025
# PILAPIL, Marcus Corso S. -- 09/13/2024
# insertionsort.asm -- C to assembly code translation of insertion algorithm

# Define Macros
.macro do_syscall(%n)
	li $v0, %n
	syscall
.end_macro

.macro exit
	do_syscall(10)
.end_macro

.macro print_str(%str)
	la $a0, %str
	do_syscall(4)
.end_macro

.macro print_int(%int)
	move $a0, %int
	do_syscall(1)
.end_macro

.macro scan_int(%address)
	prompt:	do_syscall(5)
		blt $v0, $s1, prompt
		bgt $v0, $s2, prompt
		move %address, $v0
.end_macro

.macro swap(%reg1, %reg2)	# Swapping two register values
	xor %reg1, %reg1, %reg2
	xor %reg2, %reg2, %reg1
	xor %reg1, %reg1, %reg2
.end_macro

.macro allocate_str(%label, %str)
	%label:	.asciiz %str
.end_macro

.text

main:		# Main function
		li $s1, -1000	# Setting $s1 to -1000
		li $s2, 1000	# Setting $s2 to 1000
		
		jal input
		jal sort
		jal output
		exit
		
input:		# Get valid input from user
		scan_int($t1)
		scan_int($t2)
		scan_int($t3)
		scan_int($t4)
		scan_int($t5)
		
		jr $ra

sort:		# Apply insertion sort algorithm
		# $a1 = i, $a2 = j
		li $a1, 1
outerwhile:	
		bge $a1, 5, end_outerwhile
		move $a2, $a1	# j = i
innerwhile:
		bge $0, $a2, end_innerwhile
		
		move $t7, $ra
		jal compare
		move $ra, $t7
		
		# $v0 = List[j-1] and $v1 = List[j]
		bge $v1, $v0, end_innerwhile
		
		#While Body
		li $t0, 1
		beq $a2, $t0, swap1
		
		li $t0, 2
		beq $a2, $t0, swap2
		
		li $t0, 3
		beq $a2, $t0, swap3
		
		li $t0, 4
		beq $a2, $t0, swap4
		
swap1:		swap($t2, $t1)
		j end_swap		

swap2:		swap($t3, $t2)
		j end_swap
		
swap3:		swap($t4, $t3)
		j end_swap
		
swap4:		swap($t5, $t4)
		j end_swap		
		
end_swap:	subi $a2, $a2, 1
		j innerwhile
end_innerwhile:			
		
		addi $a1, $a1, 1
		j outerwhile
end_outerwhile:
		jr $ra

compare:	# Sets the value of $v0 = List[j-1] and $v1 = List[j]
		# $a2 = j
		
		li $t0, 1
		beq $a2, $t0, access_idx1
		
		li $t0, 2
		beq $a2, $t0, access_idx2
		
		li $t0, 3
		beq $a2, $t0, access_idx3
		
		li $t0, 4
		beq $a2, $t0, access_idx4

access_idx1:	move $v1, $t2
		move $v0, $t1
		j end_compare

access_idx2:	move $v1, $t3
		move $v0, $t2
		j end_compare
		
access_idx3:	move $v1, $t4
		move $v0, $t3
		j end_compare
		
access_idx4:	move $v1, $t5
		move $v0, $t4
		j end_compare
						
end_compare:	
		jr $ra
		
output:		# Print values in list
		print_int($t1)
		print_str(space_str)
		
		print_int($t2)
		print_str(space_str)
		
		print_int($t3)
		print_str(space_str)
		
		print_int($t4)
		print_str(space_str)
		
		print_int($t5)
		print_str(space_str)
		
		jr $ra

.data
	allocate_str(space_str, " ")
