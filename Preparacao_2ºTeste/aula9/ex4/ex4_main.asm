	.data
	.eqv SIZE, 10
	.eqv print_string, 4
	.eqv print_double, 3
	.eqv read_double, 7
	
array:	.space 80
str1:	.asciiz "Introduzir um numero: "
str2:	.asciiz "valor maximo: "

	.text
	.globl main
	
# Mapa de Registos
# $t0 - i
# $t1 - &arr
	
main:
	addiu $sp, $sp, -4		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	li $t0, 0			# i=0
	la $t1, array			# $t1 = &array
	
for:
	bge $t0, SIZE, endFor		# for(i=0; i<SIZE; i++)
	la $a0, str1
	li $v0, print_string
	syscall				# print_string("Introduzir um numero: ")
	li $v0, read_double
	syscall				# read_double()
	
	sll $t3, $t0, 3			# n = i*8
	addu $t2, $t1, $t3		# $t2 = &(array[n])
	s.d $f0, 0($t2)			# array[n] = read_double()
	addi $t0, $t0, 1		# i++
	j for
	
endFor:
	move $a0, $t1			
	li $a1, SIZE
	jal max				# chamada à funcao max(array, SIZE)
	
	la $a0, str2
	li $v0, print_string
	syscall				# print_string("valor maximo: ")
	mov.d $f12, $f0			# $f12 = return (max(array, SIZE))
	li $v0, print_double
	syscall				# print_double($f12)
	
	li $v0, 0			# return 0
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço na stack
	
	jr $ra				# termina o programa
	