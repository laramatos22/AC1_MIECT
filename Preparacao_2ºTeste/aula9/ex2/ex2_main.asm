#double f2c(double ft);
#
#int main(void) {
#    	double f, c;
#
#    	print_string("Indicar temperatura em Fahrenheit: ");
#    	f = read_double();
#    	c = f2c(f);
#    	print_string("\nTemperatura em Celsius: ");
#	print_double(c);
#    	return 0;
#}

	.data
	.eqv print_string, 4
	.eqv read_double, 7
	.eqv print_double, 3
	
str1:	.asciiz "Indicar temperatura em Fahrenheit: "
str2:	.asciiz "Temperatura em Celcius: "

	.text
	.globl main
	
main:
	addiu $sp, $sp, -4		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	
	la $a0, str1		
	li $v0, print_string
	syscall				# print_string("Indicar temperatura em Fahrenheit: ");
	
	li $v0, read_double
	syscall				# read_double();
	mov.d $f12, $f0			# $f12 = $f0 = f = read_double();
	jal f2c				# chamada à funcao f2c(f);
	
	la $a0, str2
	li $v0, print_string		# print_string("\nTemperatura em Celsius: ");
	
	mov.d $f12, $f0			# $f12 = return(f2c(f)); // c = f2c(f);
	li $v0, print_double
	syscall				# print_double(c);
	
	li $v0, 0			# return 0;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, -4		# liberta o espaço na stack
	
	jr $ra				# termina o programa
	
