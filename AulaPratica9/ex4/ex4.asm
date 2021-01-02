# EXERCICIO 4

	.data
	.eqv print_string, 4
	.eqv print_double, 3
	.eqv read_double, 7
	
array:	.space 80
str1:	.asciiz "Introduzir um número: "
str2:	.asciiz "\nValor máximo: "
	
	.text
	.globl main

# uma função para calcular o valor máximo de um array de "n"
# elementos em formato vírgula flutuante, precisão dupla

max:				# double max(double *array, unsigned int n);
	move $t1, $a0		# &(p)
	move $t1, $a1		# n
	addi $t1, $t1, -1	# n--
	
	sll $t1, $t1, -1
	addu $t2, $t0, $t1	# k = &(p[n-1])
	l.d $f0, 0($t0)		# max = *p
	addiu $t0, $t0, 8	# p++
	
maxFor:
	bgt $t0, $t2, maxEndFor	# while(p <= k)
	l.s $f2, 0($t0)		# $f2 = *p
	
maxIf:
	c.le.d $f2, $f0		# *p <= max
	bc1t maxEndif		# if(*p > max)
	mov.d $f0, $f2		# max = *p
	
maxEndif:
	addiu $t0, $t0, 8	# p++
	j maxFor

maxEndFor:
	jr $ra			# termina a sub rotina
	
#----------------------- função main -----------------------------#

# Mapa de registos:
# $t0 : i
# $t1 : &array

main:
	addiu $sp, $sp, -4	# reserva espaço na stack
	sw $ra, 0($sp)		# guarda o valor de $ra
	li $t0, 0		# i = 0
	la $t1, array		# $t1 = array
	
for:
	bge $t0, SIZE, endFor	# while(i < SIZE)
	la $a0, str1
	li $v0, print_string
	syscall			# print_string(str1)
	
	li $v0, read_double
	syscall			# read_double()
	
	sll $t3, $t3, 3		# n = i*8
	addu $t2, $t1, $t3	# $t2 = &(array[n])
	s.d $f0, 0($t2)		# array[n] = read_double()
	addi $t0, $t0, 1	# i++
	j for
	
endFor:
	move $a0, $t1
	li $a1, SIZE
	jal max			# chamada à função max(array, SIZE)
	
	la $a0, str2
	li $v0, print_string
	syscall			# print_string(str2)
	
	mov.d $f12, $f0		# move (double) de $f0 para $f12 (registo que guarda um resultado)
	li $v0, print_double
	syscall			# print_double(resultado)
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4	# liberta o espaço da stack
	
	li $v0, 0		# return 0
	
	jr $ra			# termina o programa


	