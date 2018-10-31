.data
msg: .asciiz "The fibonacci of 4 is: "
.text
main:   la $a0, msg
	li $v0, 4 # Load syscall print-string into $v0
	syscall # Make the syscall
	
	
	li $a0,3 # Put argument (4) in $a0
	jal fib
	
	move $a0, $v0 # Move fact result in $a0
	li $v0, 1 # Load syscall print-int into $v0
	syscall # Make the syscall
	li $v0, 10 # Load syscall exit into $v0
	syscall # Make the syscall

	
fib: 	bgt $a0, 2, fib_start
	li $v0,1
	jr $ra

fib_start:
	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 16($sp) # Save return address
	sw $fp, 12($sp) # Save frame pointer
	addiu $fp, $sp, 20 # Set up frame pointer
	sw $a0, 0($fp) # Save argument (n)
	
	subi $a0, $a0, 1
	jal fib
	
	sw $v0, 4($fp)
	lw $a0, 0($fp)
	subi $a0, $a0, 2
	jal fib
	
	lw $v1, 4($fp)
	addu $v0, $v1, $v0
	
return_fact:
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra 
	