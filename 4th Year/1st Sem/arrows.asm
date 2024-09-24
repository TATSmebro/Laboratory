# CS 21 WFR/FYZ -- S1 AY 2024-2025
# PILAPIL, Marcus Corso S. -- 09/25/2024
# arrows.asm -- C to assembly code translation of arrows code

# Define Macros
.macro do_syscall(%n)
	li $v0, %n
	syscall
.end_macro

.macro exit
	do_syscall(10)
.end_macro

.macro print_str(%label)
	la $a0, %label
	do_syscall(4)
.end_macro

.macro scan_int(%address)
	do_syscall(5)
	move %address, $v0
.end_macro

.macro allocate_str(%label, %str)
	%label:	.asciiz %str
.end_macro

# Define variables
.eqv base, $s0
.eqv N, $s1
.eqv h, $s2

.eqv i_counter, $t1
.eqv layer_counter, $t2
.eqv ast_counter, $t3
.eqv space_counter, $t4

.text

main:		# Getting user input
		print_str(base_prompt)
		scan_int(base)
	
		print_str(N_prompt)
		scan_int(N)
	
		move 	$t0, base
		addi 	$t0, $t0, 1
		srl	$t0, $t0, 1	# Division by 2
		move	h, $t0		# Set $s2 (h) to the value of $t0	


# First outer for loop
outer_loop1:	
		bge	i_counter, h, done_outer1

		li	layer_counter, 0
inner_loop1:
		bge 	layer_counter, N, done_inner1
	
		li	ast_counter, 0
		addi	$t5, i_counter, 1
ast_loop1:
		bge	ast_counter, $t5, done_ast1
	
		print_str(ast_str)
	
		addi 	ast_counter, ast_counter, 1
		j 	ast_loop1
done_ast1:

		sub	space_counter, h, i_counter
		subi	space_counter, space_counter, 1
space_loop1:
		bge	$0, space_counter, done_space1
	
		print_str(space_str)
	
		subi 	space_counter, space_counter, 1
		j	space_loop1
done_space1:
	
		addi 	layer_counter, layer_counter, 1
		j 	inner_loop1
done_inner1:
		print_str(newline_str)
	
		addi	i_counter, i_counter, 1
		j 	outer_loop1
done_outer1:

	
# Second outer for loop
		li 	i_counter, 0
		subi	$t6, h, 1
outer_loop2:	
		bge	i_counter, $t6, done_outer2

		add	layer_counter, $0, N
inner_loop2:
		bge 	$0, layer_counter, done_inner2
	
		sub	ast_counter, h, i_counter
		subi	ast_counter, ast_counter, 1
ast_loop2:
		bge	$0, ast_counter, done_ast2
	
		print_str(ast_str)
	
		subi 	ast_counter, ast_counter, 1
		j 	ast_loop2
done_ast2:
	
		li	space_counter, 0
		addi	$t5, i_counter, 1
space_loop2:
		bge	space_counter, $t5, done_space2
	
		print_str(space_str)
	
		addi 	space_counter, space_counter, 1
		j	space_loop2
done_space2:
	
		subi 	layer_counter, layer_counter, 1
		j 	inner_loop2
done_inner2:
		print_str(newline_str)
	
		addi	i_counter, i_counter, 1
		j 	outer_loop2
done_outer2:

		exit

.data
		allocate_str(base_prompt, "Enter Base: ")
		allocate_str(N_prompt, "Enter N: ")
		allocate_str(ast_str, " * ")
		allocate_str(space_str, "   ")
		allocate_str(newline_str, "\n")
