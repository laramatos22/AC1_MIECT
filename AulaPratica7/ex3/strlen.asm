# sub-rotina strlen

#A fun��o strlen() determina e devolve a dimens�o de uma string (como j� visto
#anteriormente, em linguagem C uma string � terminada com o carater '\0'). O par�metro
#de entrada dessa fun��o � um ponteiro para o in�cio da string (i.e., o seu endere�o inicial) e
#o resultado � o n�mero de carateres dessa string (excluindo o terminador).

#int strlen(char *s)
#{
#	int len=0;
#	while(*s++ != '\0')
#		len++;
#	return len;
#}

# O argumento da fun��o � passado em $a0
# O resultado � devolvido em $v0
# Sub-rotina terminal: n�o devem ser usados registos $sx

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
	jr $ra 			# termina a fun��o