#double stdev(double *array, int nval)
#{
#	return sqrt( var(array, nval) );
#}

	.text
	.lglobl stdev
	
stdev:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal var			# chamada à funcao var(array, nval)
	mov.d $f12, $f0
	
	jal sqrt		# chamada à funcao sqrt( var(array, nval) );
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra