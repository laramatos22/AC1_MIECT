# FUNÇÃO MAIN

#define MAX_STR_SIZE 33
#int main(void)
#{
#	static char str[MAX_STR_SIZE];
#	int val;
#
#	do {
#		val = read_int();
#		print_string( itoa(val, 2, str) );
#		print_string( itoa(val, 8, str) );
#		print_string( itoa(val, 16, str) );
#	} while(val != 0);
#	return 0;
#}

# Mapa de registos
# str: $s0
# val: $s1

### O main é, neste caso, uma sub-rotina intermédia ###

	.data
	.eqv MAX_STR_SIZE, 33		#define MAX_STR_SIZE 33
	.eqv read_int, 5
	.eqv print_string, 4
	
str:	.space 33
	
	.text
	.globl main
	
main:
	addiu $sp, $sp, -8		# reserva espaço na stack
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	
do:
	li $v0, read_int
	syscall				# read_int();
	move $s0, $v0			# val = read_int();
	
	move $a0, $s0			# $a0 = val é o primeiro argumento
	li $a1, 2			# $a1 = 2 é o segundo argumento
	la $a2, str			# $a2 0 str é o terceiro argumento
	jal itoa			# chamada à funcao itoa(val, 2, str)
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string( itoa(val, 2, str) );
	
	move $a0, $s0			# $a0 = val é o primeiro argumento
	li $a1, 8			# $a1 = 8 é o segundo argumento
	la $a2, str			# $a2 0 str é o terceiro argumento
	jal itoa			# chamada à funcao itoa(val, 8, str)
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string( itoa(val, 8, str) );
	
	move $a0, $s0			# $a0 = val é o primeiro argumento
	li $a1, 16			# $a1 = 16 é o segundo argumento
	la $a2, str			# $a2 0 str é o terceiro argumento
	jal itoa			# chamada à funcao itoa(val, 16, str)
	move $a0, $v0
	li $v0, print_string
	syscall				# print_string( itoa(val, 16, str) );
	
while:
	bne $s0, 0, do			# while (val != 0);
	
	li $v0, 0			# return 0;
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	addiu $sp, $sp, 8
	
	jr $ra
	
	
	
	