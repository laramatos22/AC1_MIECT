#double xtoy(double x, int y);
#int abs(int val);
#
#int main(void) {
#    	double x;
#   	int y;
#    	double result;
#
#    	print_string("Valor de X: ");
#    	x = read_double();
#    	print_string("Valor de Y: ");
#    	y = read_int()
#
#    	result = xtoy(x, y);
#    	print_string("Resultado: ");
#    	print_double(result);
#
#    	return 0;
#}


	.data
	.eqv print_string, 4
	.eqv print_double, 3
	.eqv read_double, 7
	.eqv read_int, 5
	
str1:	.asciiz "Valor de X: "
str2:	.asciiz	"Valor de Y: "
str3:	.asciiz "Resultado: "

	.text
	.globl main
	
main:
	addiu $sp, $sp, -4		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguada o valor de $ra
	
	la $a0, str1			# $a0 = str1
	li $v0, print_string
	syscall				# print_string("Valor de X: ");
	li $v0, read_double
	syscall				# read_double();
	mov.d $f12, $v0			# $f12 = x = read_double();
	
	la $a0, str2			# $a0 = str2
	li $v0, print_string
	syscall				# print_string("Valor de Y: ");
	li $v0, read_int
	syscall				# read_int();
	move $a0, $v0			# $a0 = y = read_int();
	
	jal xtoy			# chamada à funcao xtoy(x, y);
	mov.d $f12, $f0			# result = return(xtoy(x, y));
	
	la $a0, str3			# $a0 = str3
	li $v0, print_string
	syscall				# print_string("Resultado: ");
	li $v0, print_double
	syscall				# print_double(result);
	
	li $v0, 0 			# return 0;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço na stack
	
	jr $ra				# termina o programa
	



