#int fun1(double *a, int N, double *b)
#{
#	int k = 0;
#	double *p;
#
#	for( p = a; p < (a + N); p++)
#	{
#		if ( (*p / 2.0) != 0.0 )
#		{
#			*b++ = *p;
#		}
#		else
#			k++;
#	}
#	return (N - k);
#}
#
# Mapa de registos:
# a: $a0
# N: $a1 -> $t0
# b: $a2 -> $t1
# k: $t2
# p: $t3

	.data
x0:	.double 0.0
x1:	.double 2.0
	.text
	.globl fun1

fun1:
	la $t5, x0		# $t5 = &x0 = 0.0
	la $t6, x1		# $t6 = &x1 = 2.0
	mtc1.d $t5, $f6		# mandar para o coprocessador para ficar $f6 = x0 = 0.0
	mtc1.d $t6, $f8		# mandar para o coprocessador para ficar $f8 = x1 = 2.0
	
	move $t0, $a1		# $t0 = N
	move $t1, $a2		# $t1 = b
	li $t2, 0		# int k = 0;
	move $t3, $a0		# p = &(a)
	
	sll $t3, $t0, 3		# shift left logical -> N << 3
	add $t4, $a0, $t5	# $t4 = &(a) + N
	
for:
	bge $t3, $t4, endFor	# while(p < (a + N))
	l.d $f2, 0($t3)		# $f2 = *p
	div.d $f4, $f2, $f8	# $f4 = *p / 2.0
	
if:
	c.eq.d $f4, $f6		# if ( (*p / 2.0) != 0.0 )
	bc1t else		# senao go to else
	s.d $f2, 0($t1)		# *b = *p;
	addi $t1, $t1, 8	# *b++;
	j endif
	
else:
	addi $t2, $t2, 1	# k++;
	
endif:
	addi $t3, $t3, 8	# p++;
	j for
	
endFor:
	sub $v0, $t0, $t2	# $v0 = N-k -> return (N - k);
	
	jr $ra			# termina a sub-rotina
