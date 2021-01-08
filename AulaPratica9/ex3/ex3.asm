# EXERCICIO 3

	.data
	.eqv SIZE, 10
	.eqv read_int, 5
	.eqv print_double, 3
	.eqv print_string, 4
	
zero:	.double 0.0
a:	.space 80

	.text
	.globl main	

#função average() -> calcula o valor médio de um array de reais
# codificados em formato vírgula flutuante, precisão dupla

average:			# double average(double *array, unsigned int n)
	la $t0, zero		# $t0 = 0.0
	l.d $f0, 0($t0)		# precisão dupla
	move $t0, $a0		# $t0 = array
	move $t1, $a1		# $t1 = n
	
avgFor:
	ble $t1, $0, avgEnd
	addi $t3, $t1, -1	# [i-1]
	sll $t3, $t3, 3		# [i-1]*8
	addu $t2, $t0, $t3	# $t2 = &(array[i-1])
	l.d $f2, 0($t2)		# $f2 = (double)array[i-1]
	add.d $f0, $f0, $f2	# sum += array[i-1]
	addi $t1, $t1, -1	# i--
	j avgFor
	
avgEnd:
	mtc1 $a1, $f4		# mandar para o coprocessador
	cvt.d.w $f4, $f4	# conversao de word para double
	div.d $f12, $f0, $f4	# return soma / (double)n;
	jr $ra			# fim da subrotina	
	
#----------------main-------------------#
	
main:
	addiu $sp, $sp, -20		# reserva espaço na stack
	sw $ra, 0($sp)			# guarda o valor de $ra
	la $t1, a			# $t1 = &a
	li $t0, 0			# i=0
	
for:
	bge $t0, SIZE, endFor		# for(i=0; i<SIZE; i++)
	sll $t2, $t0, 3			# aux = i*8
	addu $t3, $t1, $t2		# $t3 = &(a[i])
	
	li $v0, read_int
	syscall
	
	mtc1 $v0, $f2			# $f2 = $v0 -> mandar para o coprocessador
	cvt.d.w $f2, $f2		# $f2 = (double)$v0 -> conversao de word para double
	s.d $f2, 0($t3)			# a[i] = (double)$v0
	
	addi $t0, $t0, -1		# i++;
	j for
	
endFor:
	la $a0, a			# $a0 = a
	li $a1, SIZE 			# $a1 = SIZE
	jal average			# chamada à função average(a, SIZE)
	li $v0, print_double
	syscall				# print_double();
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 20		# liberta o espaço da stack
	li $v0, 0			# return 0
	jr $ra				# termina o programa
