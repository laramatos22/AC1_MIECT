# EXERCICIO 1
	
	.data
str:	.asciiz "2016 e 2020 sao anos bissextos"
	.eqv print_int10, 1
	
	.text
	.globl main	
		
		#array to integer
#unsigned int atoi(char *s)
#{
#	unsigned int digit, res = 0;
#	while( (*s >= '0') && (*s <= '9') )
#	{
#		digit = *s++ - '0';  -> digit = *s - '0';
#					s++;
#		res = 10 * res + digit;
#	}
#return res;
#}

# Mapa de registos
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1
# Sub-rotina terminal: não devem ser usados registos $sx

atoi: 					#unsigned int atoi(char *s)
	li $v0,0 			# res = 0;
	
while: 	lb $t0,0($a0) 			# while( (*s >= '0') && (*s <= '9') )
	blt $t0, '0', endWhile 		#*s >= '0'
	bgt $t0, '9', endWhile		#*s <= '9'
					# {
	sub $t1, $t0, '0' 		# digit = *s – '0'
	addiu $a0, $a0, 1		# s++;
	mul $v0, $v0, 10 		# res = 10 * res;
	add $v0, $v0, $t1		# res = 10 * res + digit;
	j while 			# }
	
endWhile:
	#move $v0, $t0			# return de $v0
	jr $ra 				# termina sub-rotina
					
			
#int main(void)
#{
#	static char str[]="2016 e 2020 sao anos bissextos";
#	print_int10( atoi(str) );
#	return 0;
#}		

main:
	addiu $sp, $sp, -4		#reserva espaço na stack
	sw $ra, 0($sp)			#guarda o valor de $ra
	
	la $a0, str			# $a0 = str
	jal atoi			# atoi(str)
	
	move $a0, $v0
	li $v0, print_int10		# print_int10( atoi(str) );
	syscall
	
	lw $ra, 0($sp)			
	addiu $sp, $sp, 4		#liberta espaço na stack
	
	li $v0, 0			# return 0
	jr $ra				# termina o programa
	

