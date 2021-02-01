# EXERCICIO 1

# O argumento da função é passado em $a0
# O resultado é devolvido em $v0
# Sub-rotina terminal: não devem ser usados registos $sx 

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
	addiu $sp, $sp, -4	# reserva espaço na stack 
	sw $ra, 0($sp)		# guarda o valor de $ra
	
				# Antes de chamar, a sub-rotina chamadora:
				#			-> passa os argumentos; oa 4 primeiros sao passados nos registos $a0...$a3 e os restantes na stack
				#			-> executa a instrução jal
	la $a0, str		# $a0 é o argumento de strlen 
	jal strlen		# chamada da função strlen(str)
				# o valor de retorno situa-se em $v0 e depois é transferido para $a0
	move $a0, $v0		# $a0 = return de strlen(str)
	li $v0, print_int10	
	syscall			# print_int10(strlen(str))
	
	li $v0, 0		# return 0;
	
	lw $ra, 0($sp)		# liberta o espaço da stack
	addiu $sp, $sp, 4	# repõe o valor de $ra
	
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
	lb $t0, 0($a0)		# load byte - transfere um byte da memória para um registo externo, fazendo
				#             uma extensao de sinal do valor lido de 8 para 32 bits
				#	      $t0 -> registo destino do CPU
				#	      $a0 -> registo de endereçamento indireto
	addiu $a0, $a0, 1	# $a0 = *s++
	beq $t0, '\0', endWhile	# while(*s++ != '\0')
	addi $t1, $t1, 1	# len++;
	j while
	
endWhile:
	move $v0, $t1		# return len; -> o valor de retorno é colocado no registo $v0
	jr $ra			# termina a subrotina
	
	
