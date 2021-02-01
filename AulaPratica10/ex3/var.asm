#double var(double *array, int nval) -> calcula a variancia
#{
#	int i;
#	double media, soma, res;
#
#	media = average(array, nval);
#
#	for(i=0, soma=0.0; i < nval; i++)
#		soma += xtoy(array[i] - media, 2);
#
#	res = soma / nval;
#	return res;
#}

# Mapa de registos
# $t0 - i
# $t1 - &array
# $t2 - i*8
# $t3 - &(array[i])
# $f2 - soma
# $f4 - media
# $f12 - array[i] - media
# $f0 - res

	.data
x0:	.double 0.0

	.text
	.globl var

var:
	addiu $sp, $sp, -4		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	
	la $t0, x0			# $t0 = 0.0
	l.d $f2, 0($t0)			# $f2 = soma = 0.0
	
	li $t0, 0			# int i=0;
	jal average			# average(array, nval)
	mov.d $f4, $f0			# media = average(array, nval)
	move $t1, $a0			# $t1 = &array
	
for:
	bge $t0, $a1, endFor		# for(i=0, soma=0.0; i < nval; i++)
	sll $t2, $t0, 3			# i = i*8
	addu $t3, $t1, $t2		# $t3 = &(array[i]) = array + i
	l.d $f12, 0($t3)		# $f12 = array[i]
	sub.d $f12, $f12, $f4		# $f12 - array[i] - media
	li $a0, 2
	jal xtoy			# chamada à funcao xtoy(array[i] - media, 2)
	add.d $f2, $f2, $f0		# soma += xtoy(array[i] - media, 2);
	addi $t0, $t0, 1		# i++
	j for
	
endFor:
	div.d $f0, $f2, $a1		# res = soma / nval;
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço na stack
	
	jr $ra				# termina o programa
	

