#Lista LIFO

.text
#primer nodo
	li $v0, 5
	syscall
	move $a0, $v0
	li $a1, 0
	
	jal create
	move $s0, $v0
#bucle

bucle:
	li $v0, 5
	syscall
	#insertar en lista
	beq $v0, 0, fin_bucle
	move $a1, $v0
	move $a0, $s0
	jal push
	move $s0, $v0
	
	b bucle

fin_bucle:
	li $v0, 5
	syscall
	lw $t1, 0($s0)
	beq $t1, $v0, fin #comprobar que no se intentar quitar la cabeza
	move $a1, $v0
	move $a0, $s0
	jal remove
	
	move $a0, $s0
	jal print
	
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

push:
	#pila
	add $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	
	sw $a0, 0($fp) #cima de pila
	sw $a1, -4($fp) #valor
	
	move $t0, $a0 # hay que invertir los valores ya que el enunciado especifica el orden de los
	move $a0, $a1 # arametros a la entrada de las funciones
	move $a1, $t0
	
	jal create
	
	
	#recuperamos y deshacemos pila
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	jr $ra
	
	
remove:	
	lw $t0, 4($a0)
	bnez $t0, remove_recur
	jr $ra
	
remove_recur: 
	#pila
	add $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	
	sw $a0, 0($fp) #cima de pila
	sw $a1, -4($fp) #valor
	
	#miramos si el valor que hay que cambiar es el del nodo siguiente
	lw $a0, 4($a0) #cargamos el siguiente nodo
	lw $t1, 0($a0) #sacamos el valor del siguiente nodo
	
	bne $t1, $a1, remove
	
	#recuperamos valor de la pila
	lw $t2, 0($fp)
	
	# eliminamos
	lw $t0, 4($a0)
	sw $t0, 4($t2)
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
	
	#imprimir /n
	li $v0,11
	li $a0,'\n'
	syscall
	
	lw $a0, 0($fp)
	lw $a1, -4($fp)
	#recuperamos y deshacemos pila
	
	
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addiu $sp, $sp, 32
	
	
	jr $ra