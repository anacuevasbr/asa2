	.data
		str: .asciiz "El resultado es:"
	.text
	
	main:
		
		li $v0, 5
		syscall
		move $s0, $v0
		li $v0, 5
		syscall
		move $s1, $v0
		la $a0, str
		li $v0, 4
		syscall
		add $a0, $s0, $s1
		li $v0, 1
		syscall
		li $v0, 10
		syscall
		