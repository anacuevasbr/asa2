
.text
	li $a0, 1
	li $v0, 1
	syscall
	
startprime:
	addi $a0, $a0, 1
	beq $a0, 101, exit
	jal test_prime
	beq $v0, 1, imprimir
	b startprime

imprimir:
	la $v0, 1
	syscall
	b startprime

exit: 	li $v0, 10
	syscall	

test_prime:
	li $a1, 1
	li $v0, 0
	
calc:	addi $a1, $a1, 1
	beq $a0, $a1, prime
	
	div $a2, $a0, $a1
	mfhi $a2
	bnez $a2, calc
	jr $ra
	
	
prime: li $v0, 1
	jr $ra	


	



	