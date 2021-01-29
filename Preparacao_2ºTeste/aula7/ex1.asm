# EXERCICIO 1

# O argumento da fun��o � passado em $a0
# O resultado � devolvido em $v0
# Sub-rotina terminal: n�o devem ser usados registos $sx 

#int main(void)
#{
#static char str[]="Arquitetura de Computadores I";
#print_int10(strlen(str));
#return 0;
#}

	.data
	.eqv print_int10, 1
str:	.asciiz "Arquitetura de Computadores I"
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4	# reserva espa�o na stack
	sw $ra, 0($sp)		# guarda o valor de $ra
	
	la $a0, str		# $a0 � o argumento de strlen 
	jal strlen		# chamada da fun��o strlen(str)
	
	move $a0, $v0		# $av0 = return de strlen(str)
	
	li $v0, print_int10	
	syscall			# print_int10(strlen(str))
	
	li $v0, 0		# return 0;
	
	lw $ra, 0($sp)		# liberta o espa�o da stack
	addiu $sp, $sp, 4	# rep�e o valor de $ra
	
	jr $ra			# termina o programa


#int strlen(char *s)			*s -> $a0 -> $t0
#{
#	int len=0;			len -> $t1
#	while(*s++ != '\0')
#		len++;
#	return len;
#}

strlen:
	li $t1, 0		# len = 0;

while:
	lb $t0, 0($a0)		# load byte - transfere um byte da mem�ria para um registo externo, fazendo
				#             uma extensao de sinal do valor lido de 8 para 32 bits
				#	      $t0 -> registo destino do CPU
				#	      $a0 -> registo de endere�amento indireto
	addiu $a0, $a0, 1	# $a0 = *s++
	beq $t0, '\0', endWhile	# while(*s++ != '\0')
	addi $t1, $t1, 1	# len++;
	j while
	
endWhile:
	move $v0, $t1		# return len;
	jr $ra			# termina a subrotina
	
	