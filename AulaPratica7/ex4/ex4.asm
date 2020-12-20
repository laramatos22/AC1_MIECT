# EXERCICIO 4	

#char *strcpy(char *dst, char *src);
#char *strcat(char *dst, char *src);
#
#int main(void)
#{
#	static char str1[]="Arquitetura de ";
#	static char str2[50];
#
#	strcpy(str2, str1);
#	print_string(str2);
#	print_string("\n");
#	print_string( strcat(str2, "Computadores I") );
#	return 0;
#}

# Mapa de registos:
# $t0 : str1
# $t1 : str2

	.data
	.eqv print_string, 4

str1:	.asciiz "Arquitetura de"
str2:	.space 50
str3:	.asciiz "\n"
str4:	.asciiz "Computadores I"

	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, str2
	la $a1, str1
	jal strcpy			# strcpy(str2, str1);
	
	la $a0, str2
	li $v0, print_string
	syscall				# print_string(str2);
	
	la $a0, str3
	li $v0, print_string
	syscall				# print_string("\n");
	
	la $a0, str2
	la $a1, str4
	jal strcat			# strcat(str2, str4);
	
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string(strcat(str2, str4));
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4		# liberta espaço na stack
	
	jr $ra				# termina o programa
