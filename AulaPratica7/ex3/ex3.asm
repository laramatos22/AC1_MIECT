#EXERCICIO 3

#define STR_MAX_SIZE 30
#char *strcpy(char *dst, char *src);

#int main(void)
#{
#	static char str1[]="I serodatupmoC ed arutetiuqrA";
#	static char str2[STR_MAX_SIZE + 1];
#	int exit_value;
#	if(strlen(str1) <= STR_MAX_SIZE) {
#		strcpy(str2, str1);
#		print_string(str2);
#		print_string("\n");
#		print_string(strrev(str2));
#		exit_value = 0;
#	} else {
#		print_string("String too long: ");
#		print_int10(strlen(str1));
#		exit_value = -1;
#	}
#	return exit_value;
#}

	.data
	.eqv SIZE, 30
	.eqv MAX_SIZE, 31
	.eqv print_string, 4
	.eqv print_int10
	
str1:	.asciiz "I serodatupmoC ed arutetiuqrA"
str2:	.space 31
str3:	.asciiz "\n"
str4:	.asciiz "String too long: "

	.text
	.globl main

main:
	addiu $sp, $sp, -4		# reserva espaço
	sw $ra, 0($sp)			# guarda o valor de $ra
	
	la $a0, str1			# $a0 = str1
	jal strlen			# strlen(str1)
	
if:
	bgt $v0, SIZE, else		# if(strlen(str1) <= STR_MAX_SIZE) {
	
	la $a0, str2
	la $a1, str1
	jal strcpy			# strcpy(str2, str1)
	
	move $t1, $v0
	move $a0, $t1
	li $v0, print_string
	syscall				# print_string(strcpy(str2, str1));
	
	la $a0, str3
	li $v0, print_string
	syscall				# print_string("\n");
	
	move $a0, $t1
	jal strrev			# strrev(str2);
	
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string(strrev(str2));
	
	li $t0, 0			# exit_value = 0;
	j end
	
else:
	la $a0, str4
	li $v0, print_string
	syscall				# print_string(str4);
	
	la $a0, str1
	jal strlen			# strlen(str1);
	
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string(strlen(str1));
	
	li $t0, -1			# exit_value = -1;
	
end:
	lw $ra, 0($sp)
	addiu $sp, $sp, 4		# liberta espaço na stack
	
	move $v0, $t0			# return exit_value
	jr $ra				# termina o programa