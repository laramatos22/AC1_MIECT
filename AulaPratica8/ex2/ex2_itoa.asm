# Exercicio 2

#char *itoa(unsigned int n, unsigned int b, char *s)
#{
#	char *p = s;
#	char digit;
#	do
#	{
#		digit = n % b;
#		n = n / b;
#		*p++ = toascii( digit );
#	} while( n > 0 );
#	*p = '\0';
#	strrev( s );
#	return s;
#}

# Mapa de registos
# n: $a0 -> $s0
# b: $a1 -> $s1
# s: $a2 -> $s2
# p: $s3
# digit: $t0
# Sub-rotina intermédia
itoa: 				# char *itoa(unsigned int n, unsigned int b, char *s)
	addiu $sp, $sp, -20	# reserva espaço na stack
	sw $ra, 0($sp)		# guarda $ra
	sw $s0, 4($sp) 		# guarda $s0
	sw $s1, 8($sp)		# guarda $s1
	sw $s2, 12($sp)		# guarda $s2
	sw $s3, 16($sp)		# guarda $s3
			
		 		# copia n, b e s para registos
				# "callee-saved"
	move $s0, $a0		# n: $a0 -> $s0
	move $s1, $a1		# b: $a1 -> $s1
	move $s2, $a2		# s: $a2 -> $s2
	move $s3,$a2 		# p = s;
	
do: 				# do {
	
	rem $t0, $s0, $s1	# digit = n % b;
	div $s0, $s0, $s1	# n = n / b;
	
	move $a0, $t0		#
	jal toascii		# toascii(digit)
	
	sb $v0, 0($s3)		# *p = toascii( digit );
	addiu $s3, $s3, 1	# p++;
		
while:	
	bgt $s0, 0, do		# } while(n > 0);

	sb $0, 0($s3)		# *p = '\0';
	
	move $a0, $s2		# $a0 = s		
	jal strrev 		# strrev( s );
	
	move $v0, $s2		# return s;
	lw $ra, 0($sp)		# repõe registos $sx e $ra
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
				# (...)
	addiu $sp, $sp, 20	# liberta espaço na stack
	jr $ra 			# termina o programa
