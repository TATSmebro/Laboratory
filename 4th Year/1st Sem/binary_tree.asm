# CS 21 WFR/FYZ -- S1 AY 2024-2025
# PILAPIL, Marcus Corso S. -- 10/16/2024
# binary_tree.asm -- binary tree construction and functions

.data
# Constants
NULL_PTR:    	.word 	0       # NULL pointer (0x0)
NEG_INF:     	.word 	0x80000000  # Negative infinity (0x80000000)
height_prompt: 	.asciiz	"Height: "
even_max_prompt: .asciiz	"Even Level Max Value: "
new_line: 	.ascii	"\n"

.text
# Main section for testing (optional)
main:
    # Create nodes as per Code Block 6 example
    li $a0, 5
    jal new_node               # Node *a = new_node(5)
    move $s0, $v0              # Save node 'a' in $s0

    li $a0, 10
    jal new_node               # Node *b = new_node(10)
    move $s1, $v0              # Save node 'b' in $s1

    li $a0, 17
    jal new_node               # Node *c = new_node(17)
    move $s2, $v0              # Save node 'c' in $s2

    li $a0, 1
    jal new_node               # Node *d = new_node(1)
    move $s3, $v0              # Save node 'd' in $s3

    li $a0, 0
    jal new_node               # Node *e = new_node(0)
    move $s4, $v0              # Save node 'e' in $s4
    
    li $a0, 10
    jal new_node               # Node *e = new_node(10)
    move $s5, $v0              # Save node 'e' in $s5
    
    li $a0, 12
    jal new_node               # Node *e = new_node(12)
    move $s6, $v0              # Save node 'e' in $s6
    
    li $a0, 1
    jal new_node               # Node *e = new_node(1)
    move $s7, $v0              # Save node 'e' in $s7
    
    li $a0, 2
    jal new_node               # Node *e = new_node(2)
    move $t8, $v0              # Save node 'e' in $t8
    
    li $a0, 15
    jal new_node               # Node *e = new_node(15)
    move $t9, $v0              # Save node 'e' in $t4

    # Link the nodes
    move $a0, $s0              # a as parent
    move $a1, $s1              # b as left child
    move $a2, $s2              # c as right child
    jal link                   # link(a, b, c)

    move $a0, $s1              # b as parent
    move $a1, $s3              # d as left child
    move $a2, $s4              # e as right child
    jal link                   # link(b, d, e)
    
    move $a0, $s2              # c as parent
    move $a1, $s5              # f as left child
    move $a2, $s6              # g as right child
    jal link                   # link(c, f, g)
    
    move $a0, $s3              # d as parent
    la $a1, NULL_PTR         # NULL as left child
    la $a2, NULL_PTR         # NULL as right child
    jal link                   # link(d, NULL, NULL)
	
    move $a0, $s4              # e as parent
    la $a1, NULL_PTR         # NULL as left child
    la $a2, NULL_PTR         # NULL as right child
    jal link                   # link(e, NULL, NULL)

    move $a0, $s5              # f as parent
    move $a1, $s7              # h as left child
    move $a2, $t8              # i as right child
    jal link                   # link(f, h, i)
    
    move $a0, $s6              # g as parent
    move $a1, $t9              # j as left child
    la $a2, NULL_PTR         # NULL as right child
    jal link                   # link(g, j, NULL)
    
    move $a0, $s7              # h as parent
    la $a1, NULL_PTR         # NULL as left child
    la $a2, NULL_PTR         # NULL as right child
    jal link                   # link(h, NULL, NULL)
    
    move $a0, $t8              # i as parent
    la $a1, NULL_PTR         # NULL as left child
    la $a2, NULL_PTR         # NULL as right child
    jal link                   # link(i, NULL, NULL)
    
    move $a0, $t9              # j as parent
    la $a1, NULL_PTR         # NULL as left child
    la $a2, NULL_PTR         # NULL as right child
    jal link                   # link(j, NULL, NULL)

    # Calculate depth of the tree rooted at 'a'
    move $a0, $s0              # root = a
    jal depth                  # depth(a)
    move $a1, $v0              # Save the depth result
    
    li $v0, 4			# Print string syscall
    la $a0, height_prompt	# Load height_prompt
    syscall			
    
    # Print the depth (just for testing)
    li $v0, 1                  # Print integer syscall
    move $a0, $a1
    syscall
    
    li $v0, 4			# Print string syscall
    la $a0, new_line	# Load new_line
    syscall

    # Calculate even level max for tree rooted at 'a'
    move $a0, $s0              # root = a
    li $a1, 0                  # level = 0 (root level is even)
    jal even_level_max         # even_level_max(a, 0)
    move $a1, $v0              # Save the even level max result
    
    li $v0, 4			# Print string syscall
    la $a0, even_max_prompt	# Load even_max_prompt
    syscall
    
    # Print the even level max result (just for testing)
    li $v0, 1                  # Print integer syscall
    move $a0, $a1
    syscall

    # Exit program
    li $v0, 10                 # Exit syscall
    syscall

# Function: Node *new_node(int data)
# Input: $a0 = data
# Output: $v0 = pointer to the new node
new_node:
    # Allocate memory for the new node (3 words for data, left, right)
    move $t2, $a0	       # $a0 -> $t2 = data
    
    li $a0, 12                 # 12 bytes (3 words)
    li $v0, 9                  # syscall 9 = sbrk
    syscall                    # Allocate memory
    move $t0, $v0              # Save node pointer in $t0

    # Store data at node->data
    sw $t2, 0($t0)             # Store data at first word (data)

    # Set left and right to NULL
    la $t1, NULL_PTR
    sw $t1, 4($t0)             # Store NULL in node->left
    sw $t1, 8($t0)             # Store NULL in node->right

    # Return node pointer
    move $v0, $t0
    jr $ra

# Function: void link(Node *parent, Node *left, Node *right)
# Input: $a0 = parent, $a1 = left, $a2 = right
link:
    # Set parent->left
    sw $a1, 4($a0)             # parent->left = left

    # Set parent->right
    sw $a2, 8($a0)             # parent->right = right

    jr $ra

# Function: int depth(Node *root)
# Input: $a0 = root
# Output: $v0 = depth of the tree
depth:
    # Base case: if root is NULL, return -1
    la	$t0, NULL_PTR
    beq $a0, $t0, depth_null

    # Save $ra, $s0, $s1 on the stack before recursion
    addi $sp, $sp, -20          # Allocate space on the stack
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0 (to store left depth)
    sw $s1, 8($sp)		# Save $s1 (to store right depth)
    sw $s2, 12($sp)		# Save left sub-tree
    sw $s3, 16($sp)		# Save right sub-tree

    # Recursive case
    lw $s2, 4($a0)              # Load left subtree (root->left)
    lw $s3, 8($a0)              # Load right subtree (root->right)

    # Recursively calculate the depth of the left subtree
    move $a0, $s2               # Move left subtree into $a0
    jal depth                   # Call depth(left)
    move $s0, $v0               # Save left depth in $s0

    # Recursively calculate the depth of the right subtree
    move $a0, $s3               # Move right subtree into $a0
    jal depth                   # Call depth(right)
    move $s1, $v0               # Save right depth in $t1

    # Compute max(left depth, right depth) + 1
    bge $s0, $s1, depth_left_greater
    move $s0, $s1               # s0 = max(left depth, right depth)
depth_left_greater:
    addi $v0, $s0, 1            # v0 = 1 + max(left depth, right depth)

    # Restore $ra, $s0, $s1 from the stack
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    addi $sp, $sp, 20           # Deallocate stack space

    jr $ra                      # Return from function

depth_null:
    li $v0, -1                  # Return -1 for NULL node
    jr $ra

# Function: int even_level_max(Node *root, int level)
# Input: $a0 = root, $a1 = level
# Output: $v0 = max value on even levels
even_level_max:
    # Base case: if root is NULL, return negative infinity (0x80000000)
    la $t0, NULL_PTR
    beq $a0, $t0, even_level_max_null

    # Save $ra, $s0, $s1, $s2 on the stack before recursion
    addi $sp, $sp, -40          # Allocate space for 4 registers
    sw $ra, 0($sp)              # Save return address
    sw $s0, 4($sp)              # Save $s0 (left result)
    sw $s1, 8($sp)              # Save $s1 (right result)
    sw $s2, 12($sp)             # Save $s2 (max result)
    sw $t0, 16($sp)		# Save $t0 (left subtree)
    sw $t1, 20($sp)		# Save $t1 (right subtree)
    sw $t2, 24($sp)		# Save $t2 (level % 2)
    sw $t3, 28($sp)		# Save $t3 (root->data)
    sw $t4, 32($sp)		# Save $t4 (level + 1)
    sw $t5, 36($sp)		# Save $t5 (level)
    
    lw $t0, 4($a0)              # Load left subtree (root->left)
    lw $t1, 8($a0)              # Load right subtree (root->right)

    # Increment level for recursive calls
    move $t5, $a1		# $t5 = level
    addi $t4, $a1, 1            # $t4 = level + 1
    lw $t3, 0($a0)              # Load root->data

    # Recursively calculate even_level_max for the left subtree
    move $a0, $t0               # Move left subtree into $a0
    move $a1, $t4               # Pass incremented level
    jal even_level_max          # Call even_level_max(left, level + 1)
    move $s0, $v0               # Save left result in $s0

    # Recursively calculate even_level_max for the right subtree
    move $a0, $t1               # Move right subtree into $a0
    move $a1, $t4               # Pass incremented level
    jal even_level_max          # Call even_level_max(right, level + 1)
    move $s1, $v0               # Save right result in $s1

    # Calculate max(left result, right result)
    bge $s0, $s1, even_level_max_left_greater
    move $s0, $s1               # s0 = max(left result, right result)
    
even_level_max_left_greater:
    # If level is even, check if root->data is greater
    andi $t2, $t5, 1            # Check if level is even (level % 2 == 0)
    bnez $t2, even_level_max_return

    bge $s0, $t3, even_level_max_return
    move $s0, $t3               # s0 = max(root->data, s0)
    
even_level_max_return:
    move $v0, $s0               # Set return value to max on even levels

    # Restore $ra, $s0, $s1, $s2 from the stack
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $t0, 16($sp)
    lw $t1, 20($sp)
    lw $t2, 24($sp)
    lw $t3, 28($sp)
    lw $t4, 32($sp)
    lw $t5, 36($sp)
    addi $sp, $sp, 40           # Deallocate stack space

    jr $ra                      # Return from function

even_level_max_null:
    la $v0, NEG_INF             # Return negative infinity if root is NULL
    lw $v0, 0($v0)              # Load the negative infinity constant
    
    jr $ra                     # Return from function