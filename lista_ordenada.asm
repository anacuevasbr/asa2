#Lista ordenada

.text
	#Nodo inicial
	li $a0, 314
	li $a1, 0
	jal create
	
	move $s0, $v0 #lo dice el enunciado
	
	# pedir numero en Bucle hasta 0
bucle:	
	
	li $v0, 5
	syscall
	#insertar en lista
	beq $v0, 0, fin_bucle
	
	move $a0,  $s0
	move $a1, $v0
	
	jal insert_in_order
	
	#V0 CONTIENE 0 si no se añade a la cabeza
	# si v0!=0 hay que cambiar s0
	beq $v0, 0, bucle
	
	move $s0, $v0
	
	b bucle
	
fin_bucle:
	#imprimir lista
	move $a0, $s0
	jal print
	#terminar
fin:
	li $v0, 10
	syscall
	
create:
	#pila
	add $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	
	li $a0, 8
	li $v0, 9
	syscall #se guarda en $v0 
	
	#recuperar valores
	lw $a0, 0($fp)
	lw $a1, -4($fp)
	#Inicializar nodo
	
	sw $a0, 0($v0)
	sw $a1, 4($v0)
	
	#recuperamos y deshacemos pila
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	jr $ra

insert_in_order:

		#pila
	add $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	
	move $a0, $a1
	li $a1, 0
	jal create
	
	lw $a0, 0($fp)
	lw $a1, -4($fp)

	#comparar valores
	
	lw $t0, 0($a0)
	
	bgt $a1, $t0, caso1
	
caso1: 
	sw $a0, 4($v0)
	
	
	
	#recuperamos y deshacemos pila
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	
	jr $ra

	
print:
	bne $a0, 0, print_rec
	
	jr $ra

print_rec:

	#pila
	add $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	
	sw $a0, 0($fp)
	sw $a1, -4($fp)
	
	lw $a0, 4($a0)
	jal print

	lw $a0, 0($fp)
	lw $a0, 0($a0)
	li $v0, 1
	syscall
	
	lw $a0, 0($fp)
	lw $a1, -4($fp)
	#recuperamos y deshacemos pila
	
	
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	
	jr $ra
	