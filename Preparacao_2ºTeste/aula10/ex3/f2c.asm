#double f2c (double ft) {
#    return (5.0 / 9.0 * (ft - 32.0));
#}

	.data
x0: 	.double 5.0
x1:	.double 9.0
x2:	.double 32.0

	.text
	.globl f2c
	
f2c:
	la $t0, x0		# $t0 = &x0
	l.d $f2, 0($t0)		# $f2 = 5.0
	
	la $t0, x1		# $t0 = &x1
	l.d $f4, 0($t0)		# $f4 = 9.0
	
	la $t0, x2		# $t0 = &x2
	l.d $f6, 0($t0)		# $f4 = 32.0
	
	sub.d $f12, $f12, $f6	# $f12 = ft = ft - 32
	div.d $f2, $f2, $f4	# $f2 = 5.0/9.0
	mul.d $f0, $f2, $f12	# return (5.0 / 9.0 * (ft - 32.0));
	
	jr $ra			# termina a subrotina