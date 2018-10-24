	.data
		
	.text
	
	main:
		
		li $v0, 5
		syscall
		move $s0, $v0
		li $v0, 5
		syscall
		move $s1, $v0
		bgt $s0,$s1, mayor
		b else
		
		mayor: move $a0, $s0
		li $v0, 1
		syscall
		
		else: move $a0, $s1
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall