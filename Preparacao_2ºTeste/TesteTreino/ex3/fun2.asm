#int funk( int, int );
#
#int fun2(int *p, int k)
#{
#	int n=0;
#	while ( *p != k )
#	{
#		n = n + funk(*p, k);
#		p++;
#	}
#	return n;
#}
#
# Mapa de registos:
# p : $a0 -> $t0 -> $s0 ($s0 quando for para criar o ponteiro)
# k : $a1 -> $s1
# n : $t1

	.text
	.globl fun2
	
fun2:
	move $t0, $a0			# $t0 = p
	addiu $sp, $sp, -12		# reserva espa�o na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	sw $s0, 4($sp)			# guarda o valor dos registos $s0 e $s1
	sw $s1, 8($sp)
	
	lw $s0, 0($t0)			# cria��o do ponteiro -> $s0 = *p
	move $s1, $a1			# $s1 = k
	
	li $t1, 0			# int n=0;
	
while:
	beq $s0, $s1, endWhile		# while ( *p != k )
	
	move $a0, $s0			# 1� argumento da fun��o funk -> $a0 = *p
	move $a1, $s1			# 2� argumento da fun��o funk -> $a1 = k
	jal funk			# chamada � fun��o funk(*p, k)
	
	add $t1, $t1, $v0		# n = n + funk(*p, k);
	
	addi $t0, $t0, 4		# p++;
	
	j while
	
endWhile:
	move $v0, $t1			# return n;
	
	lw $ra, 0($sp)			# rep�e o valor de $ra
	lw $s0, 4($sp)			# rep�e os valores de $s0 e $s1
	lw $s1, 8($sp)	
	addiu $sp, $sp, 12		# liberta o espa�o na stack
	
	je $ra				# termina a sub-rotina