	.data
		cad: .ascii "\n"
		
	.text
	
	main:
		
		li $v0, 5
		syscall
		move $s0, $v0
		li $v0, 5
		syscall
		move $s1, $v0
		li $t1, 0
		
		beqz $s1, fin
		blt $t1, $s1, bucle
		b fin
		bucle:
		addi $t1, $t1, 1
		mul $t0, $s0, $t1
		move $a0, $t0
		li $v0,1
		syscall
		li $v0, 4
		la $a0, cad
		syscall
		blt $t1, $s1, bucle
		fin: li $v0, 10
		syscall