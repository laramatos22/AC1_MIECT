# Exercicio 2 alinea e

# Mapa de registos:
# $t0 - value
# $t1 - bit
# $t2 - i
# $t3 - resultado de i%4
# $t4 - flag

# Código em C
# void mains (void) {
#	unsigned int value, bit, i;
#	int flag;
#	print_string("Introduza um número: ");
#	value = read_int();
#	print_string("\nO valor em binário é: ");
#	for(i=0, flag=0; i<32; i++) {
#		bit = value >> 31;
#		if(flag == 1 || bit != 0) {
#			flag = 1;
#			if((i%4) == 0)
#				print_char(' ');
#			print_char(0x30 + bit);
#		}
#		value = value << 1; 			//shift left de 1 bit
#	}
#}

	.data
str1:	.asciiz "Introduza um número: "
str2: 	.asciiz "O número em binário é: "
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_char, 11
	.text
	.globl main
	
main:	li $t0, 0			# int value = 0
	li $t1, 0			# int bit = 0
	li $t2, 0			# int i = 0
	
	ori $v0, $0, print_string	# print_string("Introduza um número: ");
	la  $a0, str1
	syscall
	
	ori $v0, $0, read_int		# value = read_int();
	syscall
	or  $t0, $0, $v0
	
	ori $v0, $0, print_string 	# print_string("\nO valor em binário é: ");
	la  $a0, str2
	syscall
	
while: 				
	bge  $t2, 32, endWhile		# while(i < 32) {
					# bge = branch greater or equal
	
	srl $t1, $t0, 31		# bit = value >> 31;

ifFlag: 	
	bne $t4, $0, ifFlag		# if(flag == 1 || ...)
	beq $v0, $0, endifFlag		# (... || bit != 0) {
	
ifFlag:	
	ori $t4, $0, 1			# flag = 1;
	
	rem $t3, $t2, 4			# $t3 = i%4
	bne $t3, $0, endifChar		# if((i%4) == 0) endifChar
	ori $v0, $0, print_char		# print_char(' ');
	ori $a0, $0, 0x20		# espaço
	syscall

endifChar:	addi $a0, $t1, 0x30		# bit + 0x30
		ori  $v0, $0, print_char	# print_char (0x30 + bit);
		syscall				# }
		
endifFlag:	sll  $t0, $t0, 1		# value = value << 1;
		addi $t2, $t2, 1		# i++
		syscall				# }	
	  
endWhile:	
	jr $ra				#terminar o programa
