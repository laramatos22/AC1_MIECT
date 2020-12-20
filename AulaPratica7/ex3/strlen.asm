# sub-rotina strlen

#A função strlen() determina e devolve a dimensão de uma string (como já visto
#anteriormente, em linguagem C uma string é terminada com o carater '\0'). O parâmetro
#de entrada dessa função é um ponteiro para o início da string (i.e., o seu endereço inicial) e
#o resultado é o número de carateres dessa string (excluindo o terminador).

#int strlen(char *s)
#{
#	int len=0;
#	while(*s++ != '\0')
#		len++;
#	return len;
#}

# O argumento da função é passado em $a0
# O resultado é devolvido em $v0
# Sub-rotina terminal: não devem ser usados registos $sx

# Mapa de registos:
# $t0 : *s
# %$t1 : len

strlen: li $t1,0 		# len = 0;

while: 				# 
	lb $t0,	0($a0)	  	# $t0 = char[0] da str
	addiu $a0,$a0,1 	# s++;
	beq $t0,'\0',endw 	# while(*s++ != '\0') {
	addi $t1,$t1,1		# len++;
	j while			# }
	
endw: 	move $v0,$t1 		# return len;
	jr $ra 			# termina a função