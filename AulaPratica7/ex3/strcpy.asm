# Sub-rotina strcpy

# copia uma string
#char *strcpy(char *dst, char *src)
#{
#	int i=0;
#	do
#	{
#		dst[i] = src[i];
#	} while(src[i++] != '\0');
#	return dst;
#}

# Mapa de registos:
# dst : $a0 -> $s0
# src : $a1 -> $s1
# i : $t0
# dst + i : $t1
# src + i : $t2
# dst[i] : $t3
# src[i] : $t4

strcpy:
	addiu $sp, $sp, -8		# reserva espaço na stack
	sw $s0, 0($sp)			# guarda valor do registo $s0
	sw $s1, 4($sp)			# guarda valor do registo $s1
	
	li $t0, 0			# int i =0;
	move $s0, $a0			# $s0 = dst
	move $s1, $a1			# $s1 = src
	
do: 	
	addu $t1, $s0, $t0		# $t1 = dst + i
	addu $t2, $s1, $t0		# $t2 = src + i
	
	lb $t3, 0($t2)			# $t4 = src[i]
	sb $t3, 0($t1)			# $t3 = dst[i]
	
	addi $t0, $t0, 1		# i++;
	
	bne $t3, '\0', do		# while(src[i++] != '\0');
	
	move $v0, $s0			# $v0 = dst
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	
	addiu $sp, $sp, 8		# liberta espaço na stack
	
	jr $ra				# termina a sub-rotina