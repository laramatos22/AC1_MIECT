	.text
	.globl strcat
	
#char *strcat(char *dst, char *src)
#{
#	char *p = dst;
#	while(*p != '\0')
#		p++;
#	strcpy(p, src);
#	return dst;
#}
	
strcat:
	addiu $sp, $sp, -8		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	sw $s0, 4($sp)			# guarda o valor de $s0
	
	move $s0, $a0			# $s0 = &(dst)
	
while:
	lb $t0, 0($a0)			# *p = dst[0]
	
	beq $t0, '\0', endWhile		# while(*p != '\0') {
	addiu $a0, $a0, 1		#	p++;
	j while				# }
	
endWhile:
	jal strcpy			# strcpy(p, src);
	
	move $v0, $s0			# return dst;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	lw $s0, 4($sp)			
	addiu $sp, $sp, 8		# liberta o espaço na stack
	
	jr $ra				# termina a subrotina
	
		