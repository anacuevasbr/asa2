.data
	cad: .space 1024
	palstr: .asciiz "\nEs palindromo\n"
	nopalstr: .asciiz "\nNo es palindromo\n"
.text
	li $v0, 8
	li $a1, 1024
	la $a0, cad
	syscall

	#Puntero que apunta a la direccion del primer caracter
	la $s0, cad

last:	lb $t0, 0($s0)
	#imprimir caracter
	addi $s0, $s0, 1
	li $t1, '\n'
	beq $t0, $t1, found
	b last
	
	#imprimir cadena
	#li $v0, 4
	#syscall
	
found:  addi $s0, $s0, -2
	lb $t0, 0($s0)
	li $v0, 11
	move $a0, $t0
	syscall

segpunt: #segundo puntero inicializado	
	la $s1, cad
	lb $t1, 0($s1)
	li $v0, 11
	move $a0, $t1
	syscall
	
comp:	beq $t0, $t1, next
	b end

next:	addi $s0, $s0, -1
	addi $s1, $s1, 1
	lb $t0, 0($s0)
	lb $t1, 0($s1)
	
	#trazas
	li $v0, 11
	move $a0, $t0
	syscall
	li $v0, 11
	move $a0, $t1
	syscall
	
	#comparar puntero para ver si has llegado a la mitad de la palabra
	bge $s0, $s1, comp
	b pal

pal: 	la $a0, palstr
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	
	


end: 	la $a0, nopalstr
	li $v0, 4
	syscall
	li $v0, 10
	syscall
