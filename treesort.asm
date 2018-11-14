
.text

	#creamos nodo original
	#reservamos meoria para nodo 0
	li $v0, 9
	li $a0, 12
	syscall
	
	beqz $v0, exit
	move $s0, $v0
	move $a0, $v0
	li $s1, 5
	li $s2, 0
	jal tree_node_create
	
	#leer num
read:	
	li $v0, 5
	syscall
	move $s1, $v0
	beqz $s1, exit
	jal tree_insert
	b read
	
	
tree_node_create:
	
	sw $s1, 0($a0)
	sw $s2, 4($a0)
	sw $s2, 8($a0)
	
	jr $ra
	
tree_insert:
	
	
	#pila
	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 20($sp) # Save return address
	sw $fp, 16($sp) # Save frame pointer
	addiu $fp, $sp, 28
	sw $a0, 0($fp)
	
	#reserva memoria para el nuevo nodo
	li $v0, 9
	li $a0, 12
	syscall

	beqz $v0, exit
	
	move $a0, $v0
	jal tree_node_create
	
	
	
	#ver en que rama va
	
	lw $ra, 20($sp)
	jr $ra
	
	
 exit: li $v0, 10
 	syscall  
	
	
	