# CS 21 WFR/FYZ -- S1 AY 2024-2025
# PILAPIL, Marcus Corso S. -- 09/13/2024
# myfirstprogram.asm -- a simple program where we learn the basics

.text

main:	add	$s0, $s1, $s2	#addc contents of $s4 to $s5, store in $t0
	
	li 	$v0, 10		#syscall code 10
	syscall			#syscall code 10

.data