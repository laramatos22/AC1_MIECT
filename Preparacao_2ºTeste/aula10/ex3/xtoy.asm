#double xtoy(double x, int y)
#{
#	int i;
#	double result;
#
#	for(i=0, result=1.0; i < abs(y); i++)
#	{
#		if(y > 0)
#			result *= x;
#		else
#			result /= x;
#	}
#	return result;
#}

# Mapa de Registos
# $s0 - i
# $s1 - y
# $f20 - result
# $f22 - x
	
	.data

x:	.double 1.0

	.text
	.globl xtoy
	
xtoy:
	addiu $sp, $sp, -28		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	sw $s0, 4($sp)			# guarda o valor de $s0
	sw $s1, 8($sp)			# guarda o valor de $s1
	sw $f20, 12($sp)		# guarda o valor de $f20
	sw $f22, 20($sp)		# guarda o valor de $f22
	
	li $s0, 0			# i=0;
	
	la $t0, x			# $t0 = &x;
	l.d $f20, 0($t0)		# $f20 = res = 1.0;
	
	move $s1, $a0			# $s1 = y;
	mov.d $f22, $f12		# $f22 = x;
	
	move $a0, $a1
	jal absolute			# chamada à funcao abs(y)
	move $t1, $v0			# $t1 = return (abs(y))
	
for:
	bge $s0, $t1, endFor		# for(i=0, result=1.0; i < abs(y); i++)
	
if:
	ble $s1, 0, else		# 	if(y > 0)
	
	mul.d $f20, $f20, $f22		#		result *= x;
	j endIf

else:					#	else
	div.d $f20, $f20, $f22		#		result /= x;
	
endIf:
	addi $s0, $s0, 1		#	i++;
	j for

endFor:
	mov.d $f0, $f20			# return result;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	lw $s0, 4($sp)			# repõe o valor de $s0
	lw $s1, 8($sp)			# repõe o valor de $s1
	l.d $f20, 12($sp)		# repõe o valor de $f20
	l.d $f22, 20($sp)		# repõe o valor de $f22
	addiu $sp, $sp, 28		# liberta o espaço na stack
	
	jr $ra				# termina a sub-rotina