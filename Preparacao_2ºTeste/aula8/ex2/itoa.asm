#char *itoa(unsigned int n, unsigned int b, char *s)
#{
#	char *p = s;
#	char digit;
#
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

### Sub-rotina intermédia ###
	
	.text
	.globl itoa
	
itoa:
	addiu $sp, $sp, -20		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	sw $s0, 4($sp)			# guarda os registos
	sw $s1, 8($sp)			# $sx na pilha
	sw $s2, 12($sp)
	sw $s3, 16($sp)
			
					# passar n, b e s para callee-saved
	move $s0, $a0			# $s0 = n
	move $s1, $a1			# $s1 = b
	move $s2, $a2			# $s2 = s
	move $s3, $a2			# $s3 = *p = s
	
do:					# do {
	rem $t0, $s0, $s1		# 	digit = n % b;
	div $s0, $s1			# 	n / b;
	mflo $s0			# 	n = n / b;
	
	move $a0, $t0			# 	$a0 = digit
	jal toascii			# 	chamada à funcao toascii(digit)	
	
	sb $v0, 0($s3)			# 	*p++ = toascii( digit );
	
	addiu $s3, $s3, 1		# 	p++;
	
while:
	bgt $s0, 0, do			# } while( n > 0 );
	
	sb $0, 0($s3)			# *p = '\0';
	
	move $a0, $s2			# $a0 = s
	jal strrev			# strrev( s );
	move $v0, $s2			# return s;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	lw $s0, 4($sp)			# repõe os valores dos registos
	lw $s1, 8($sp)			# $s0, $s1, $s2 e $s3
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addiu $sp, $sp, 20		# liberta o espaço na stack
	
	jr $ra				# termina a sub-rotina

