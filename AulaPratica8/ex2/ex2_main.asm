# EXERCICIO 2 - MAIN

# teste da sub-rotina itoa

# Mapa de registos:
# str : $s0
# val : $s1
# O main é, neste caso, uma sub-rotina intermédia

#define MAX_STR_SIZE 33
#int main(void)
#{
#	static char str[MAX_STR_SIZE];
#	int val;
#	do {
#		val = read_int();
#		print_string( itoa(val, 2, str) );
#		print_string( itoa(val, 8, str) );
#		print_string( itoa(val, 16, str) );
#	} while(val != 0);
#	return 0;
#}

	.data
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv MAX_STR_SIZE, 33		#define MAX_STR_SIZE 33
str:	.space 33			#static char str[MAX_STR_SIZE];
	.text
	.globl main

main:					#int main(void) {
	addiu $sp, $sp, -12		# reserva espaço na stack
	sw $ra, 0($sp)			# guarda $ra na stack
	sw $s0, 4($sp)			# guarda registos $sx na stack
	sw $s1, 8($sp)
	
do:					# do{
	li $v0, read_int		
	syscall
	move $s1, $v0			#val = read_int();
	
	move $a0, $s0
	li $a1, 2
	la $a2, str
	jal itoa			# itoa(val, 2, str)
	
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string( itoa(val, 2, str) );
	
	move $a0, $s0
	li $a1, 8
	la $a2, str
	jal itoa			# itoa(val, 8, str)
	
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string( itoa(val, 8, str) );
	
	move $a0, $s0
	li $a1, 12
	la $a2, str
	jal itoa			# itoa(val, 12, str)
	
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string( itoa(val, 12, str) );
	
	bne $s1, '0', do		# while(val != 0);
	
	lw $ra, 0($sp)			# repõe registo $ra
	lw $s0, 4($sp)			# repoe registos $sx
	lw $s1, 8($sp)
	addiu $sp, $sp, 12		# liberta espaço na stack
	
	li $v0, 0			# return 0;
	
	jr $ra				# termina programa
	
	
	