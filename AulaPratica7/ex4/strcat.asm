#Sub-rotina strcat

#char *strcat(char *dst, char *src)
#{
#	char *p = dst;
#	while(*p != '\0')
#		p++;
#	strcpy(p, src);
#	return dst;
#}


strcat:
	addiu $sp, $sp, -16		# reserva espaço na stack
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	move $s0, $a0			# p = dst
	move $s1, $a1			# $s1 = src
	
while:
	lb $s2, 0($sp)			# *p = dst[0]
	beq $s2, '\0', endWhile		# while(*p != '\0')
	addi $s0, $s0, 1		# p++;
	j while
	
endWhile:
	move $a0, $s0
	move $a1, $s2
	
	jal strcpy			# strcpy(p, src)
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addiu $sp, $sp, 16
	
	jr $ra				# termina a sub-rotina