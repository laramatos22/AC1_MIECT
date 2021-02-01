#double sqrt(double val);
#
#int main(void) {
#    double val, result;
#
#    print_string("Valor de X: ");
#    val = read_double();
#    result = sqrt(val);
#    print_string("Resultado: ");
#    print_double(result);
#
#    return 0;
#}

	.data
	
	.eqv print_string, 4
	.eqv read_double, 7
	.eqv print_double, 3
	
str1:	.asciiz "Valor de X: "
str2:	.asciiz "Resultado: "
	
	.text
	.globl main

main:
	addiu $sp, $sp, 4
	sw $ra, 0($sp)
	
	la $a0, str1		
	li $v0, print_string
	syscall				# print_string("Valor de X: ");
	li $v0, read_double
	syscall				# read_double();
	mov.d $f12, $f0			# val = read_double();
	
	jal sqrt			# chamada à funcao sqrt(val)
	
	la $a0, str2
	li $v0, print_string
	syscall				# print_string("Resultado: ");
	mov.d $f12, $f0
	li $v0, print_double
	syscall				# print_double(return(sqrt(val)));
	
	li $v0, 0			# return 0;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço na stack
	
	jr $ra				# termina o programa	
	