# EXERCICIO 1 b)

#int main(void)
#{
#	static char str[]="2016 e 2020 sao anos bissextos";
#
#	print_int10( atoi(str) );
#	return 0;
#}

	.data
	.eqv print_int10, 1

str: 	.asciiz "2016 e 2020 sao anos bissextos"

	.text
	.globl main
	
main:
	addiu $sp, $sp, -4		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguada o valor de $ra
	
	la $a0, str
	jal atoi			# chamada à funcao atoi(str)
	move $a0, $v0			# $a0 = return(atoi(str))
	li $v0, print_int10
	syscall				# print_int10( atoi(str) );
	
	li $v0, 0			# return 0;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço na stack
	
	jr $ra				# termina o programa



	