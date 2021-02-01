	.text
	.globl max
	
#double max(double *array, unsigned int n);

max:
	move $t0, $a0			# $t0 = &(p)
	move $t1, $a1			# $t1 = n
	addi $t1, $t1, -1		# n = n-1
	sll $t1, $t1, 3			# n = (n-1)*8
	addu $t2, $t0, $t1		# k = &(p[n-1])
	l.d $f0, 0($t0)			# max = *p
	addiu $t0, $t0, 8		# p++
	
for:	
	bgt $t0, $t2, endFor		# for(; p>=k; p++)
	l.d $f2, 0($t0)			# $f2 = *p
	
if:
	c.le.d $f2, $f0			# *p <= max
	bc1t endIf			# if(*p <= max)	-> branch if true
	mov.d $f0, $f2			#	max = *p
	
endIf:
	addiu $t0, $t0, 8		# p++
	j for
			
endFor:
	jr $ra				# fim da subrotina
							
