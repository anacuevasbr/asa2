.data
	cad: .space 1024
	caderror: .asciiz "Letra\n"

.text
	li $v0, 8
	li $a1, 1024
	la $a0, cad
	syscall
	
	la $s0, cad
	lb $t0, 0($s0)
	li $s3, '0'
	li $s4, '9'
	
	
	#comprobando numero
	bgt $t0, $s4, end
	bgt $s3, $t0, end 
	# inicializo $s1
	li $s1, 0
	
op:	#comprobando numero
	bgt $t0, $s4, end
	bgt $s3, $t0, end
	li $t9, 10 # t9 va a tener siempre un 10
	mult $s1, $t9
	mflo $s1
	sub $t0, $t0, '0'
	add $s1, $s1, $t0 
	
	addi $s0, $s0, 1
	lb $t0, 0($s0)
	
	
	li $t1, '\n'
	beq $t0, $t1, end
	b op
	


end: 	
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 10
	syscall

