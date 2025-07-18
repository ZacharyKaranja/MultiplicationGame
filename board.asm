.data
.globl board, player_spots
 board: .word 1,2,3,4,5,6,7,8,9,10,12,14,15,16,18,20,21,24,25,27,28,30,32,35,36,40,42,45,48,49,54,56,63,64,72,81
 player_spots: .word 0:36
 dash1: .asciiz " - "
 dash: .asciiz " - "
 space: .asciiz " | "
 newline: .asciiz "\n"
  
.text
.globl board_setup
board_setup:
	#load baords
	la $a2, board 
	la $a3, player_spots
	#counters
	li $t1, 0 
	li $t2, 0
	j print_board
	
	
print_board:
	li $v0, 1
	lw $a0, ($a2)
	syscall
	li $v0, 4
	la $a0, dash
	syscall
	li $v0, 1
	lw $a0, ($a3)
	syscall
	
	addi $a2, $a2, 4
	addi $a3, $a3, 4
	addi $t1, $t1, 1
	addi $t2, $t2, 1
	
	li $v0, 4
	la $a0, space
	
	bne $t1, 6, space_
	la $a0, newline
	li $t1, 0
	
	space_:
	syscall
	lw $a0, ($a2)
	blt $t2, 36, print_board
	
	li $v0, 1
	la $a0, ($s1)
	syscall
	li $v0, 4
	la $a0, mult_sign
	syscall
	li $v0, 1
	la $a0, ($s2)
	syscall
	li $v0, 4
	la $a0, equals
	syscall
	li $v0, 1
	la $a0, ($s0)
	syscall
	li $v0, 4
	la $a0, newline
	
	j check_winner

check_winner:
	la $a3, player_spots
	sub $a3, $a3, 4 
	li $t0, 0
	loop:
		add $a3, $a3, 4
		add $t0, $t0, 1
		lw $t1, ($a3)
		beq $t1, 0, loop
		bge $t0, 36, end_loop
		div $t0, $6
		mfhi $t8
		
		check_right:
		
		bge $t8, 2, check_down
		
		lw $t1, 0($a3)
		lw $t2, 4($a3)
		lw $t3, 8($a3)
		lw $t4, 12($a3)
		seq $t5, $t1, $t2
		seq $t6, $t1, $t3
		seq $t7, $t1, $t4
		beq $t5, 0, check_down
		beq $t6, 0, check_down
		beq $t7, 0, check_down
		
		beq $t1, 1, exit1
		beq $t1, 2, exit2
		
		check_down:
		
		
		bgt $t0, 18, check_down_right
		
		
		lw $t1, 0($a3)
		lw $t2, 24($a3)
		lw $t3, 48($a3)
		lw $t4, 72($a3)
		seq $t5, $t1, $t2
		seq $t6, $t1, $t3
		seq $t7, $t1, $t4
		beq $t5, 0, check_down_right
		beq $t6, 0, check_down_right
		beq $t7, 0, check_down_right
		
		beq $t1, 1, exit1
		beq $t1, 2, exit2
		
		check_down_right:
		
		bge $t8, 2, check_down_left
		bgt $t0, 18, check_down_left

		lw $t1, 0($a3)
		lw $t2, 28($a3)
		lw $t3, 56($a3)
		lw $t4, 84($a3)
		seq $t5, $t1, $t2
		seq $t6, $t1, $t3
		seq $t7, $t1, $t4
		beq $t5, 0, check_down_left
		beq $t6, 0, check_down_left
		beq $t7, 0, check_down_left
		
		beq $t1, 1, exit1
		beq $t1, 2, exit2
		
		check_down_left:
		
		ble $t8, 2, loop
		bgt $t0, 18, loop
		
		lw $t1, 0($a3)
		lw $t2, 20($a3)
		lw $t3, 40($a3)
		lw $t4, 60($a3)
		seq $t5, $t1, $t2
		seq $t6, $t1, $t3
		seq $t7, $t1, $t4
		beq $t5, 0, loop
		beq $t6, 0, loop
		beq $t7, 0, loop
		
		beq $t1, 1, exit1
		beq $t1, 2, exit2
	end_loop:
		beq $s7, 0, input
		beq $s7, 1, computer_move
