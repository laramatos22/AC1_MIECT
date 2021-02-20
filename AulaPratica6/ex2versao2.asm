# EXERCICIO 2 AGAIN
#
#define SIZE 3
#
#void main(void)
#{
# 	static char *array[SIZE]={"Array", "de", "ponteiros"};
# 	char **p;
# 	char **pultimo;
#
# 	p = array;
# 	pultimo = array + SIZE;
#
# 	for(; p < pultimo; p++)
#	{
#		print_str(*p);
#		print_char('\n');
#	}
#}
#
# Mapa de registos:
# $t0: p
# $t1: pUltimo
# $t2: *p
# $t5: aux

	.data
	
	
	.eqv SIZE, 3			# define SIZE 3
	.eqv print_string, 4
	.eqv print_char, 11
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
	.align 2
array: 	.word str1, str2, str3

	.text
	.globl main
	
main:
	la $t0, array			# p = &array
	li $t5, SIZE			# aux = SIZE
	sll $t5, $t5, 2			# aux = SIZE * 4
	addu $t1, $t0, $t5		# pultimo = array + SIZE;
	
while:
	bge $t0, $t1, endWhile		# for(; p < pultimo; p++) {
	
	lw $t2, 0($t0)			# $t2 = *p
	
	move $a0, $t2			# $a0 = $t2 = *p
	li $v0, print_string		# $v0 = print_string
	syscall				# print_str(*p);
	
	li $a0, '\n'			# $a0 = '\n'
	li $v0, print_char		# $v0 = print_char
	syscall				# print_char('\n');
	
	addiu $t0, $t0, 4		# p++;
	j while
	
endWhile:
	jr $ra				# termina o programa
