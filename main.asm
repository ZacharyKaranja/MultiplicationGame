.data
.globl mult_sign, equals, newline
 mult_sign: .asciiz " * "
 equals: .asciiz " = "
 newline: .asciiz "\n"
 
 
 Win1: .asciiz "Player 1 has won!"
 Win2: .asciiz "Player 2 has won!"
 invalid_move: .asciiz "Invalid move, please try again.\n"
 

.text
main: 
#The player turn
	li $s0,0
	li $s1,0
	li $s2,0
	li $s7, 0
	
	li $v0, 42
	li $a0, 1
	li $a1, 9
	syscall
	add $s1, $a0, 1
	j board_setup
	
.globl mult_product
mult_product:
	mult $s1, $s2
	mflo $s0
	
	li $t0, 0
	la $a2, board 
	la $a3, player_spots
	
	
add_to_board:
	lw $t1, ($a2)
	beq $t1, $s0, move_validation
	
	add $a2, $a2, 4
	add $a3, $a3, 4
	
	j add_to_board

move_validation:
	lw $t9, ($a3)
	bne $t9, 0, invalid
	
	
	add $t6, $s7, 1
	sw $t6, ($a3)
	
	j board_setup
	
	invalid:
	li $v0, 4
	la $a0, invalid_move
	
	beq $s7, 0, computer_move
	
	j input
	
	

exit:
	li $v0, 10
	syscall

.globl exit1	
exit1:
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 4
	la $a0, Win1
	syscall
	j exit
	
.globl exit2
exit2:
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 4
	la $a0, Win2
	syscall
	
	j exit

