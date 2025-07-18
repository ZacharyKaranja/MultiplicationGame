.data
 question1: .asciiz "Which number would you like to move? 1 or 2?\n"
 question2: .asciiz "Which number would you like to change it to? (1-9)\n"

.text
.globl input
input:
	syscall
	li $v0, 4
	la $a0, question1
	syscall
	
	#input 1
	li $v0, 5
	syscall
	la $t0, ($v0)
	
	li $v0, 4
	la $a0, question2
	syscall
	
	#input 2
	li $v0, 5
	syscall
	
	
	li $s7, 1
	
	beq $t0, 1, change_number1
	la $s2, ($v0)
	j mult_product
	
	
	change_number1:
		la $s1, ($v0)
		j mult_product
