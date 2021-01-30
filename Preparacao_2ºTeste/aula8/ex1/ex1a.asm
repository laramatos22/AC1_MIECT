# EXERCICIO 1 a)

#unsigned int atoi(char *s)
#{
#	unsigned int digit, res = 0;
#	while( (*s >= '0') && (*s <= '9') )
#	{
#		digit = *s++ - '0';
#		res = 10 * res + digit;
#	}
#	return res;
#}

# Mapa de registos:
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1

### ATENÇÃO ###
# Sub-rotina terminal: não devem ser usados registos $sx

	.text
	.globl atoi

atoi:
	li $v0, 0		# unsigned int res = 0;
	
while:	
	lb $t0, 0($a0)		# *s = s[0]
	
	blt $t0, '0', endWhile	# while( (*s >= '0') && 
	bgt $t0, '9', endWhile	# 	 (*s <= '9') )  {
	addi $t1, $t0, -0x30	#	digit = *s++ - '0';
	addiu $a0, $a0, 1	# 	s++;
	mul $v0, $v0, 10	# 	res = 10 * res;
	add $v0, $v0, $t1	# 	res = 10 * res + digit;
	j while			# }

endWhile:
	jr $ra			# } termina o programa
