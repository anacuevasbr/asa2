.text

	#creamos nodo original
	#reservamos meoria para nodo 0
	li $s1, 5
	li $s2, 0
	jal tree_node_create
	move $s0, $v0  #guarda la raiz del arbol en s0
	move $a0, $s0
	
	#leer num
read:	
	li $v0, 5
	syscall
	move $s1, $v0
	move $a0, $s0
	beqz $s1, fin_bucle
	move $a0, $s0
	jal tree_insert
	b read

fin_bucle:
	move $a0, $s0
	jal print

fin:
	li $v0, 10
	syscall


tree_node_create:

	li $v0, 9
	li $a0, 12
	syscall
	
	beqz $v0, fin

	sw $s1, 0($v0)
	sw $s2, 4($v0)
	sw $s2, 8($v0)
	
	jr $ra


tree_insert:

	#pila
	add $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	
	sw $a0, 0($fp)
	
	jal tree_node_create
	
	lw $a0, 0($fp)
	
	move $t0, $a0
	
	#comparar valores
bucle_insert:	

	lw $t1, 0($t0)
	beq $s1, $t1, fin_insert #iguales
	
	bgt $t1, $s1, menor
	bgt $s1, $t1, mayor
	
menor:
	lw $t2, 4($t0)
	la $t3, 4($t0)
	beqz $t2, vacio
	move $t0, $t2
	b bucle_insert

mayor:
	lw $t2, 8($t0)
	la $t3, 8($t0)
	beqz $t2, vacio
	move $t0, $t2
	b bucle_insert
		
vacio:
	sw $v0, 0($t3)	
fin_insert:	
	#recuperamos y deshacemos pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32

	jr $ra

print:
	bne $a0, 0, tree_print
	
	jr $ra

tree_print:

	#pila
	add $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	
	sw $a0, 0($fp) #guardamos en la pila

	
	lw $a0, 4($a0) #miramos por la izquierda
	jal print
	
	lw $a0, 0($fp) #recuperamos original
	lw $a0, 0($a0) #numero para imprimir
	li $v0, 1
	syscall
	
	#imprimir /n
	li $v0,11
	li $a0,'\n'
	syscall
	
	#miramos por la derecha
	lw $a0, 0($fp) #recuperamos original
	lw $a0, 8($a0)
	jal print

	#recuperamos y deshacemos pila
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32

	jr $ra