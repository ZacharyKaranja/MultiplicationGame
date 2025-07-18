.data
computer_line: .asciiz "Computer Move! "
changed1: .asciiz "Changed first number to "
changed2: .asciiz "Changed second number to "

.text
.globl computer_move
computer_move:
	li $v0, 4
	la $a0, newline
	syscall
	la $a0, computer_line
	syscall
	
	li $v0, 42
	li $a0, 1
	li $a1, 9
	syscall
	add $t0, $a0, 1
	
	li $v0, 42
	li $a0, 0
	li $a1, 2
	syscall
	
	beq $a0, 1, case2
	add $s1, $t0, 0
	li $v0, 4
	la $a0, changed1
	syscall
	li $v0, 1
	la $a0, ($t0)
	syscall
	j end_move
	
	case2:
	add $s2, $t0, 0
	li $v0, 4
	la $a0, changed2
	syscall
	li $v0, 1
	la $a0, ($t0)
	syscall
	j end_move
	
	
	end_move:
	
	li $v0, 4
	la $a0, newline
	syscall
	li $s7, 0
	j mult_product