# Sub-rotina strrev

#void exchange(char *c1, char *c2) -> troca a posição de dois registos
#{
#	char aux = *c1;
#
#	*c1 = *c2;
#	*c2 = aux;
#}

exchange:
	lb $t0, 0($a0)		# $t0 = $a0 // char aux = *c1;
	lb $t1, 0($a1)
	
	sb $t1, 0($a0)		# $t1 = $a0 // *c1 = *c2;
	sb $t0, 0($a1)		# $t0 = $a1 // *c2 = aux;
	
	jr $ra			# termina o programa


#A função strrev() (string reverse) inverte o conteúdo de uma string. 

#char *strrev(char *str)
#{
#	char *p1 = str;
#	char *p2 = str;
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

#Mapa de registos:
# str : $a0 -> $s0 (argumento é passado em $a0)
# p1 : $s1 (registo callee-saved)
# p2 : $s2 (registo callee-saved)

strrev:
	addiu $sp, $sp, -16		# reserva espaço na stack
	sw $ra 0($sp)			# guarda o endereço de retorno $ra
	
	sw $s0, 4($sp)			# guardar valor de registos
	sw $s1, 8($sp)			# $s0, $s1, $s2
	sw $s2, 12($sp)
	
	move $s0, $a0			# registo "calle - saved"
	move $s1, $a0			# p1 = str
	move $s2, $a0			# p2 = str
	
while1:
	lb $s3, 0($s2)
	beq $s3, '\0', endWhile1	# while(*p2 != '\0') {
	addi $s2, $s2, 1		# p2++;
	
	j while1			# }
	
endWhile1:
	sub $s2, $s2, 1			# p2--;
	
while2:
	bge $s1, $s2, endWhile2		# while(p1 < p2) {
	
	move $a0, $s1			# $a0 - 1º argumento de exchange
	move $a1, $s2			# $a1 - 2º argumento de exchange
	
	jal exchange			# chamada da função exchange
	
	addi $s1, $s1, 1		# p1++;
	sub $s2, $s2, 1			# p2--;
	
	j while2			# }
	
endWhiile2:
	move $v0, $s0			# return str
	
	lw $ra, 0($sp)			# repôe endereço de retorno
	lw $s0, 4($sp)			# repôe os valores dos registos
	lw $s1, 8($sp)			# $s0, $s1 e $s2
	lw $s2, 0($sp)
	
	addiu $sp, $sp, 16		# liberta o espaço que estava a ser utilizado
	
	jr $ra				# termina a sub-rotina