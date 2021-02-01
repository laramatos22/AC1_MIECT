# EXERCICIO 1
	
	.data
result:	.double 1.0
	
	.text
	.globl main

#int abs(int val)
#{
#	if(val < 0)
#		val = -val;
#	return val;
#}

# Mapa de registos:
# val: $a1 (argumento da função)

abs:				# int abs(int val)

absIf:
	bge $a0, 0, endIf	# if(val < 0)
	mul $t0, $a0, -1	# multiplicação de val com -1
	or $a0, $0, $t0		# or para $a1 ficar com o valor do registo temporário $t0
	
absEndIf:
	move $v0, $a0		# return val;
	jr $ra			# terminal a sub-rotina
	
# ------------------ função xtoy() -------------------#
#double xtoy(double x, int y)
#{
#	int i;
#	double result;
#	for(i=0, result=1.0; i < abs(y); i++)
#	{
#		if(y > 0)
#			result *= x;
#		else
#			result /= x;
#	}
#	return result;
#}

# xtoy é não terminal, logo stack $ra

# Mapa de registos:
# salvaguardar na pilha:
# i -> $s1
# x -> $f12, $f20
# y -> $a0, $s0
# result -> $f22

xtoy:
	addiu $sp, $sp, -32		# 2^5 registos = 32 bits -> reservar espaço na stack
	sw $ra, 0($sp)			# reserva o valor de $ra
	sw $s0, 4($sp)			# guarda valores dos registos
	sw $s1, 8($sp)			# $s0, $s1, $s2, $s3
	s.d $f20, 12($sp)
	sw $s2, 16($sp)
	sw $s3, 20($sp)
	s.d $f22, 24($sp)
	
	li $s1, 0			# i=0;
	
	la $t0, result
	l.d $f22, 0($t0)		# result = 1.0
	
for:
	jal abs				# abs(y)
	lw 				# load do resultado
	mtc1 				# mandar para o coprocessador
	blt $s0, $a0, endFor		# while(i < abs(y))
	
if:
	blez $a0, else			# if(y > 0)
	mul.d $f22, $f22, $f20		# result *= x;
else:
	div.d $f22, $f22, $f20		# result /= x;

endFor:
	move $v0, $f22			# return result;
	
	lw $ra, 0($sp)			# repõe endereço de retorno
	lw $s0, 4($sp)			# repõe os valores dos registos
	lw $s1, 8($sp)			# $s0, $s1, $s2, e $s3
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	
	addiu $sp, $sp, 32		# liberta espaço da stack
	
	jr $ra				# termina o programa
	
#---------------------- função main --------------------#

main:
	
	
	
	
	
