.data
msg: .asciiz "The factorial of 3 is: "
.text
main:   la $a0, msg
	li $v0, 4 # Load syscall print-string into $v0
	syscall # Make the syscall
	li $a0,3 # Put argument (3) in $a0
	jal fact # Call factorial function
	move $a0, $v0 # Move fact result in $a0
	li $v0, 1 # Load syscall print-int into $v0
	syscall # Make the syscall
	li $v0, 10 # Load syscall exit into $v0
	syscall # Make the syscall
	
fact:
	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 20($sp) # Save return address
	sw $fp, 16($sp) # Save frame pointer
	addiu $fp, $sp, 28 # Set up frame pointer
	sw $a0, 0($fp) # Save argument (n)
	lw $v0, 0($fp)
	 bgtz $v0, fact_recur # fact(n-1)
	 li $v0, 1
	 b return_fact
fact_recur:
	lw $v1, 0($fp) # Load n
 	subu $v0, $v1, 1 # Compute n - 1
 	move $a0, $v0 # Move value to $a0
 	jal fact

 	lw $v1, 0($fp) # Load n
 	mul $v0, $v0, $v1 # Compute fact(n-1) * n
return_fact:
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	jr $ra 