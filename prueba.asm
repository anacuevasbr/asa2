.data
	cad: .space 1024
.text
	li $v0, 8
	li $a1, 1024
	la $a0, cad
	syscall

	#Puntero que apunta a la direccion del primer caracter
	la $s0, cad

next:	lb $t0, 0($s0)
	#imprimir caracter
	addi $s0, $s0, 1
	li $t1, '\n'
	beq $t0, $t1, found
	b next
	
	#imprimir cadena
	#li $v0, 4
	#syscall
	
found:	
