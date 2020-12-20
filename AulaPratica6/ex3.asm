# EXERCICIO 3

#define SIZE 3
#void main(void)
#{
#	static char *array[SIZE]={"Array", "de", "ponteiros"};
#	int i, j;
#	for(i=0; i < SIZE; i++)
#	{
#		print_str( "\nString #" );
#		print_int10( i );
#		print_str( ": " );
#		j = 0;
#		while(array[i][j] != '\0')
#		{
#			print_char(array[i][j]);
#			print_char('-');
#			j++;
#		}
#	}
#}

# Mapa de registos:
# $t0 : i
# $t1 : i*4
# $t2 : j
# $t3 : array
# $t4 : array[i]

	.data
	.eqv SIZE, 3
	.eqv print_str, 4
	.eqv print_int10, 1
	.eqv print_char, 11
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "pronteiros"
point:	.asciiz ": "
	.align 2
array:	.word str1, str2, str3
	.text
	.globl main
	
main: 				# void main(void)
	li $t0, 0		# int i = 0;
	la $t3, array		# $t3 = array
	
for:
	bge $t0, SIZE, endFor	# whiel(i < SIZE) {
	
	la $a0, str
	li $v0, print_str
	syscall 		# print_str("\nString#");
	
	move $a0, $t0		# $a0 = i
	li $v0, print_int10
	syscall			# print_int10(i);
	
	la $a0, point		# $a0 = ": ";
	li $v0, print_str
	syscall			# print_str(": ");
	
	li $t2, 0		# j = 0;
	
while:
	sll $t1, $t0, 2		# $t1 = i*4
	addu $t4, $t3, $t1	# $t4 = &(array[i])
	lw $t4, 0($t4)		# $t4 = array[i]
	
	addu $t4, $t4, $t2	# $t4 = &(array[i][j])
	lb $t4, 0($t4)		# $t4 = array[i][j]
	
	beq $t4, '\0', endWhile	# while(array[i][j] != '\0') {
	
	move $a0, $t4		# $a0 = array[i][j]
	li $v0, print_char	
	syscall			# print_char(array[i][j]);
	
	li $a0, '-'
	li $v0, print_char
	syscall			# print_char('-');
	
	addi $t2, $t2, 1	# j++;
	
	j while
	
endWhile:
	addi $t0, $t0, 1	# i++;
	
	j for
	
endFor:
	jr $ra			# termina o programa
	
	