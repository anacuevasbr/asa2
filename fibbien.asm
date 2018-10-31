.data
msg: .asciiz "The factorial of 10 is: "
.text
main:   la $a0, msg
	li $v0, 4 # Load syscall print-string into $v0
	syscall # Make the syscall
	li $a0,10 # Put argument (3) in $a0
	jal fibo # Call factorial function
	
	move $a0, $v0 # Move fact result in $a0
	li $v0, 1 # Load syscall print-int into $v0
	syscall # Make the syscall
	li $v0, 10 # Load syscall exit into $v0
	syscall # Make the syscall
	
fibo: 	bgt $a0, 2, fibo_recur

	li $v0, 1
	jr $ra

fibo_recur:
	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 20($sp) # Save return address
	sw $fp, 16($sp) # Save frame pointer
	addiu $fp, $sp, 24
	
	
	sw $a0, 0($fp)
	
	subi $a0, $a0, 1
	jal fibo
	sw $v0, 4($fp)
	
	lw $a0, 0($fp)
	subi $a0, $a0, 2
	jal fibo
	
	lw $v1, 4($fp)
	add $v0, $v0, $v1
	

	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra 