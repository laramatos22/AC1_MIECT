	.data
	.eqv SIZE, 11
	.eqv read_int, 5
	.eqv print_double, 3
	.eqv print_string, 4

array:	.space 80

	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $t1, array			# $t1 = &array
	li $t0, 0			# i=0
	
for:
	bge $t0, SIZE, endFor		# for(i=0; i<SIZE; i++)
	sll $t2, $t0, 3			# aux = i*8
	addu $t3, $t1, $t2		# $t3 = &(array[i])
	
	li $v0, read_int
	syscall				#read_int
	mtc1 $v0, $f2			# mandar para o coprocessador
					# 	$v0 -> CPUsrc / registo do CPU
					# 	$f2 -> FPdst / registo da FPU
					
	cvt.d.w $f2, $f2		# $f2 = (double)$v0
	
	s.d $f2, 0($t3)			# store double into memory
					# $t3 = array[i] = (double)$f2
					
	addi $t0, $t0, 1		# i++
	j for
	
endFor:
	la $a0, array
	li $a1, SIZE
	jal average			# chamada à funcao average (a, SIZE)
	li $v0, print_double
	syscall				# print_double
	
	li $v0, 0			# return 0
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço na stack
	
	jr $ra				# termina a sub-rotina