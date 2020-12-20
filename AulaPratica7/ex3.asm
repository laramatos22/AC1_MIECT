# EXERCICIO 3

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
	
strlen: li $t1,0 		# len = 0;

w: 				# 
	lb $t0,	0($a0)	  	# $t0 = char[0] da str
	addiu $a0,$a0,1 	# s++;
	beq $t0,'\0',endw 	# while(*s++ != '\0') {
	addi $t1,$t1,1		# len++;
	j while			# }
	
endw: 	
	move $v0,$t1 		# return len;
	jr $ra 			# termina a função

# copia uma string
#char *strcpy(char *dst, char *src)
#{
#	int i=0;
#	do
#	{
#		dst[i] = src[i];
#	} while(src[i++] != '\0');
#	return dst;
#}

# Mapa de registos:
# dst : $a0 -> $s0
# src : $a1 -> $s1
# i : $t0
# dst + i : $t1
# src + i : $t2
# dst[i] : $t3
# src[i] : $t4

strcpy:
	addiu $sp, $sp, -8		# reserva espaço na stack
	sw $s0, 0($sp)			# guarda valor do registo $s0
	sw $s1, 4($sp)			# guarda valor do registo $s1
	
	li $t0, 0			# int i =0;
	move $s0, $a0			# $s0 = dst
	move $s1, $a1			# $s1 = src
	
do: 	
	addu $t1, $s0, $t0		# $t1 = dst + i
	addu $t2, $s1, $t0		# $t2 = src + i
	
	lb $t3, 0($t2)			# $t4 = src[i]
	sb $t3, 0($t1)			# $t3 = dst[i]
	
	addi $t0, $t0, 1		# i++;
	
	bne $t3, '\0', do		# while(src[i++] != '\0');
	
	move $v0, $s0			# $v0 = dst
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	
	addiu $sp, $sp, 8		# liberta espaço na stack
	
	jr $ra				# termina a sub-rotina
	
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

