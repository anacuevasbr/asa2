.data
	str: .asciiz "El resultado es"
	num1: .half 0
	num2: .half 0
.text
	
main:	
	li $v0, 5
	syscall
	sh $v0, num1
	li $v0, 5
	syscall
	sh $v0, num2
	
	
	lh $s0, num1
	lh $s1, num2
	la $a0, str
	li $v0, 4
	syscall
	add $a0, $s0, $s1
	li $v0, 1
	syscall
	li $v0, 10
 	syscall