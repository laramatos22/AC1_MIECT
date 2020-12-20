# EXERCICIO 3 ALINEA C

	.data
	.eqv print_string, 4
	
stro:	.asciiz "Arquitetura de Computadores I"
strc:	.space 50

	.text
	.globl main

#char *strcpy(char *dst, char *src)
#{
#	char *p=dst;
#	do
#	{
#		*p++ = ...
#	} while(*src++ ...
#	return dst;
#}

# Mapa de registos:
# $t0 : dst
# $t1 : src
# $t2 : *src

strcpy:
	move $t0, $a0			# $t0 = dst;
	move $t1, $a1			# $t1 = src;
	
do:
	lb $t2, 0($t1)			# $t2 = *src;
	sb $t2, 0($t0)			# guardar o caracter em dst
	
	addi $t0, $t0, 1		# *p++;
	addi $t1, $t1, 1		# src++;
	
	bne $t2, '\0', do		# while(*src != '\0');
	
	move $v0, $a0			# return dst;
	
	jr $ra				# fim de sub-rotina
	
# Mapa de registos da main:
# $a0 : argumento da função
# $a1 : argumento da função
# $v0 : retorno da função

main:
	addiu $sp, $sp, -4		# reserva espaço na stack
	sw $ra, 0($sp)
	
	la $a0, strc
	la $a1, stro
	jal strcpy			# strcpy(strc, stro);
	
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string(strcpy(strc, stro));
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4		# liberta espaço na stack
	
	jr $ra				# termina o programa
	