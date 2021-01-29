# EXERCICIO 2

#int main(void)
#{
#	static char str[]="ITED - orievA ed edadisrevinU";
#	print_string( strrev(str) );
#	return 0;
#}

	.data 
	.eqv print_string, 4
str:	.asciiz "ITED - orievA ed edadisrevinU"
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4		# reserva espaço na stack
	sw $ra, 0($sp)			# guarda o valor de $ra
	
	la $a0, str
	jal strrev			# strrev(str)
	
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string(strrev(str))
	
	li $v0, 0			# return 0;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço na stack
	
	jr $ra				# termina o programa
	

# Mapa de registos:
# str: $a0 -> $s0 (argumento é passado em $a0)
# p1: $s1 (registo callee-saved)
# p2: $s2 (registo callee-saved)

#char *strrev(char *str)
#{
#	char *p1 = str;
#	char *p2 = str;
#
#	while(*p2 != '\0')
#		p2++;
#	p2--;
#	while( p1 < p2 )
#	{
#		exchange(p1, p2);
#		p1++;
#		p2--;
#	}
#	return str;
#}

strrev:
	addiu $sp, $sp, -16		# reserva espaço na stack
	sw $ra, 0($sp)			# guarda endereço de retorno
	sw $s0, 4($sp)			# guarda valores dos registos
	sw $s1, 8($sp)			# $s0, $s1 e $s2
	sw $s2, 12($sp)
	
	move $s0, $a0			# str: $a0 -> $s0 (argumento é passado em $a0)
	move $s1, $a0			# p1: $s1 (registo callee-saved) => p1 = str;
	move $s2, $a0			# p2: $s2 (registo callee-saved) => p2 = str;
	
while1:
	lb $t1, 0($s2)			# $t1 = *p2; -> fazer load byte para p2 passar a ponteiro
	beq $t1, '\0', endWhile1	# while( *p2 != '\0' ) {
	addiu $s2, $s2, 1		#	p2++;
	j while				# }
	
endWhile1:
	addiu $s2, $s2, -1		# p2--;
	
while2:
	bge $s1, $s2, endWhile2		# while(p1 < p2) {
	
	move $a0, $s1			# p1 é o 1º argumento da função exchange
	move $a1, $s2			# p2 é o 2º argumento da função exchange
	jal exchange			# 	exchange (p1, p2);
	
	addiu $s1, $s1, 1		# 	p1++;
	addiu $s2, $s2, -1		# 	p2--;
	
	j while2			# }
	
endWhile2:
	move $v0, $s0			# return str
	
	lw $ra, 0($sp)			# repõe o endereço de retorno
	lw $s0, 4($sp)			# repõe o valor dos registos
	lw $s1, 8($sp)			# $s0, $s1 e $s2
	lw $s2, 12($sp)
	addiu $sp, $sp, 16		# liberta o espaço na stack
	jr $ra				# termina a subrotina
	
#void exchange(char *c1, char *c2)
#{
#	char aux = *c1;		#	*c1 -> $a0 -> $t0 -> $t1
#	*c1 = *c2;		#	*c2 -> $a1 -> $t1 -> $t0
#	*c2 = aux;
#}

exchange:
	lb $t0, 0($a0)		
	lb $t1, 0($a1)
	sb $t0, 0($a1)
	sb $t1, 0($a0)
	jr $ra
