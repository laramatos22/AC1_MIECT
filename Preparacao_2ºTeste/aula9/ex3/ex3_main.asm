	.data
	.eqv print_double, 3
	.eqv read_int, 5
	.eqv SIZE, 10
a:	.space 80
	.text
	.globl main
	
# Mapa de registos
# $t0 - i
# $t1 - &a;
# $t2 - aux;
# $t3 = &(a[i]);

main:
	addiu $sp, $sp, -4		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	la $t1, a			# $t1 = &a
	li $t0, 0			# i=0
	
for:
	bge $t0, SIZE, endFor		# for(i=0; i<SIZE; i++)
	sll $t2, $t0, 3			# aux = i*8
	addu $t3, $t1, $t2		# $t3 &(a[i])
	
	li $v0, read_int	
	syscall				# read_int()
	mtc1 $v0, $f2			# $f2 = $v0
	cvt.d.w $f2, $f2		# $f2 = (double)$v0
	s.d $f2, 0($t3)			# a[i] = (double)$v0
	
	addi $t0, $t0, 1		# i++
	j for
	
endFor:
	la $a0, a			# $a0 = a
	li $a1, SIZE			# $a1 = SIZE
	jal average			# chamada à funcao average(a, SIZE)
	mov.d $f12, $f0			# $f12 = $f0
	li $v0 print_double
	syscall				# print_double(average(a, SIZE))
	
	li $v0, 0			# return 0
	
	lw $ra 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço na stack
				
	jr $ra				# termina o programa
	
