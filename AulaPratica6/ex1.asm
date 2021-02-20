# EXERCICIO 1
#O programa seguinte define 3 strings, organizadas na estrutura de dados descrita
#anteriormente, e imprime-as.

#define SIZE 3
#void main(void)
#{
#	static char *array[SIZE]={"Array", "de", "ponteiros"};
#	int i;
#	for(i=0; i < SIZE; i++)
#	{
#		print_str(array[i]);
#		print_char('\n');
#	}
#}

# Mapa de registos:
# i: $t0
# SIZE: $t1
# array: $t2
# array temporário temp: $t3

	.data
	.eqv SIZE, 3
	.eqv print_str, 4
	.eqv print_char, 11
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
array:	.word str1, str2, str3
	.text
	.globl main
	
main:	
	li $t1, SIZE		# $t1=SIZE
	la $t2, array		# $t2 = &(array[0])
	li $t0, 0		# i=0;

for:	
	bge $t0, $t1, endFor	# for(i=0; i < SIZE; i++) {
	sll $t3, $t0, 2		# temp = i*4; OU multi $t3, $t0, 4
	addu $t3, $t2, $t3	# temp = &array[i]
	
	lw $a0, 0($t3)		# load word -> temp = $a0 = array[i]
	li $v0, print_str	# $v0, print_string
	syscall			# print_str(array[i]);
	
	li $a0, '\n'
	li $v0, print_char	# $v0 = print_char
	syscall			# print_char('\n')
	
	addi $t0, $t0, 1	# i++	
	
	j for			# jump de retorno para o for }
	
endFor:	
	jr $ra			# terminar programa
	
