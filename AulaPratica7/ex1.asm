#EXERCICIO 1

#a) A função strlen() determina e devolve a dimensão de uma string (como já visto
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

	.data
	.eqv print_int10, 1
#	.eqv print_string, 4
str1:	.asciiz "Arquitetura"
str2:	.asciiz "de"
str3:	.asciiz "Computadores"
str4:	.asciiz "I"
str:	.word str1, str2, str3, str4	#static char str[]="Arquitetura de Computadores I";

	.text
	.globl main

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
	

#int strlen(char *s);

#int main(void)
#{
#	static char str[]="Arquitetura de Computadores I";
#	print_int10(strlen(str));
#	return 0;
#}

# Mapa de registos:
# $a0 : argumentos
# $v0 : resultado

main:	
	addiu $sp, $sp, -4	# reserva espaço
	sw $ra, 0($sp)		# guarda o valor de $a0
	
	la $a0, str		# $a0 = str
	jal strlen		# chamada da função: int strlen(char *s)
	
	move $s0, $v0
	li $v0, print_int10	
	syscall			# print_int10(strlen(str));
	
	lw $ra, 0($sp)		# atualiza o valor de $a0
	addiu $sp, $sp, 4	# liberta o espaço reservado
	
	jr $ra			# termina o programa
	
	