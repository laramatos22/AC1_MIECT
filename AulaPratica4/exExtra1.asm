# EXERCICIO ADICIONAL 1

# Código em C

#define SIZE 20
#void main(void)
#{
#	static char str[SIZE];
#	char *p;
#	print_string("Introduza uma string: ");
#	read_string(str, SIZE);
#	p = str;
#	while (*p != '\0')
#	{
#	*p = *p – 'a' + 'A'; 	// 'a'=0x61, 'A'=0x41, 'a'-'A'=0x20
#	p++;
#	}
#	print_string(str);
#}

# Mapa de Registos:
# $t0 - p
# $t1 - *P

	.data
	.eqv SIZE, 20
str:	.space 20
str1:	.asciiz "Introduza uma string: "
	.eqv print_string, 4
	.eqv read_string, 8
	.text
	.globl main
	
main: 	
	la $a0, str1			# $a0 = str1
	ori $v0, $0, print_string	# $v0 = print_string
	syscall				# print_string("Introduza um número:");
	
	la $a0, str			# $a0 = str -> 1º argumento para read_string
	li $a1, SIZE			# $a1 = SIZE -> 2º argumento para read_string
	li $v0, read_string		# read_string(str, SIZE);
	syscall
	
	la $t0, str			$ p = str;
	
while:	
	lb $t1, 0($t0)			# *p = str (criação do ponteiro *p)
	beqz $t1, endWhile		# while (*p != '\0') {
	blt $t1, 0x61, else		# Verificação da letra de A (0x61)
	bgt $t1, 0x7a, else		# a Z (0x7a)
	
	sub $t1, $t1, 0x20		# *p = *p – 'a' + 'A'; 	// 'a'=0x61, 'A'=0x41, 'a'-'A'=0x20
	sb $t1, 0($t0)			# renova o registo com os novos caracteres -> store byte
	
else: 	
	addi $t0, $t0, 1		# 	p++
	j while				# }
	
endWhile:	la $a0, str			
		li $v0, print_string	# print_string(str);
		syscall
		
		jr $ra			# terminar programa

