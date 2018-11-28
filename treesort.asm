
.text

	#creamos nodo original
	#reservamos meoria para nodo 0
	li $s1, 5
	li $s2, 0
	jal tree_node_create
	move $s0, $v0 #guarda la raiz del arbol en s0
	move $a0, $s0
	
	#leer num
read:	
	li $v0, 5
	syscall
	move $s1, $v0
	move $a0, $s0
	beqz $s1, tree_print
	move $a0, $s0
	jal tree_insert
	b read

#exitread:
#	jal tree_print
#	li $v0, 10
# 	syscall  

tree_print:

	#pila
	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 20($sp) # Save return address
	sw $fp, 16($sp) # Save frame pointer
	addiu $fp, $sp, 28
	sw $a0, 0($fp) #save actual node
	
	lw $t1, 0($a0)
	lw $t2, 4($a0)
	lw $t3, 8($a0)
	
	move $a0, $t2
	bnez $t2, next #check left
	move $a0, $t1 #print node
	li $v0, 1
	syscall
	
	move $a0, $t3
	bnez $t3, next #check right
	move $a0, $t1 #print node
	
	
	addiu $sp, $sp, 32 # deshacer pila
	lw $ra, 20($sp)
	jr $ra
	
next:	
	jal tree_print	
	
	
	
	
	
tree_node_create:

	li $v0, 9
	li $a0, 12
	syscall
	
	beqz $v0, exit

	sw $s1, 0($v0)
	sw $s2, 4($v0)
	sw $s2, 8($v0)
	
	jr $ra
	
tree_insert:
	
	
	#pila
	subu $sp, $sp, 32 # Stack frame is 32 bytes long
	sw $ra, 20($sp) # Save return address
	sw $fp, 16($sp) # Save frame pointer
	addiu $fp, $sp, 28
	sw $a0, 0($fp)
	
	

comparar:
	lw $t1, 0($a0)
	beq $s1, $t1, exitinsert
	#ver en que rama va
	blt $s1, $t1, izquierda
	blt $t1, $s1, derecha	
	
izquierda:
	
	lw $t2, 4($a0)
	beqz $t2, nuevoiz
	move $a0, $t2
	jal tree_insert
	addiu $sp, $sp, 32 # deshacer pila
	lw $ra, 20($sp)
	jr $ra

derecha:
	
	lw $t2, 8($a0)
	beqz $t2, nuevoder
	move $a0, $t2
	jal tree_insert
	addiu $sp, $sp, 32 # deshacer pila
	lw $ra, 20($sp)
	jr $ra

nuevoiz:  jal tree_node_create
	lw $a0, 0($fp)
	sw $v0, 4($a0) 
	
	lw $ra, 20($sp)
	jr $ra

nuevoder:  jal tree_node_create
	lw $a0, 0($fp)
	sw $v0, 8($a0) 
	
	lw $ra, 20($sp)
	jr $ra
	
exitinsert:
	lw $ra, 20($sp)
	jr $ra

		
	
 exit: li $v0, 10
 	syscall  
	
	
	
