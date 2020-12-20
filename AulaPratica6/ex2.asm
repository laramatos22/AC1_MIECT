# EXERCICIO 2

#define SIZE 3

#void main(void)
#{
#	static char *array[SIZE]={"Array", "de", "ponteiros"};
#	char **p;
#	char **pultimo;
#	p = array;
#	pultimo = array + SIZE;
#	for(; p < pultimo; p++)
#	{
#		print_str(*p);
#		print_char('\n');
#	}
#}

# Mapa de registos:
# $t0 : p
# $t1 : pultimo

	.data
	.eqv SIZE, 3
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3: 	.asciiz "ponteiros"
array:	.word str1, str2, str3
	.text
	.globl main
	
main:
	la $t0, array		# p = array
	addiu $t1, $t0, 12	# pultimo = array + (SIZE * 4)
	
for:
	bge $t0, $t1, endFor	# while(p < ultimo)
	
	lw $a0, 0($t0)		# array[i]
	li $v0, print_string
	syscall			# print_string(array[i])
	
	li $a0, '\n'
	li $v0, print_char
	syscall			# print_char('\n')
	
	addiu $t0, $t0, 4	# p += 4
	
	j for

endFor:
	jr $ra			# termina o programa
	
