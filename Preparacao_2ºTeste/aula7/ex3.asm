#EXERCICIO 3 a) e b)

#int main(void)
#{
#	static char str1[]="I serodatupmoC ed arutetiuqrA";
#	static char str2[STR_MAX_SIZE + 1];
#	int exit_value;
#
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

#define STR_MAX_SIZE 30

	.data
	.eqv STR_MAX_SIZE, 30
	.eqv print_string, 4
	.eqv print_int10, 1
	
str1:	.asciiz "I serodatupmoC ed arutetiuqrA"
str2:	.asciiz STR_MAX_SIZE
str3:	.asciiz "\n"
str4:	.asciiz "String too long: "
	
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4		# reservar espaço na pilha
	sw $ra, 0($sp)			# guarda espaço na stack
	
	la $a0, str1
	jal strlen			# chamada à funçao strlen(str)
	
if:
	bgt $v0, STR_MAX_SIZE, else	# if(strlen(str1) <= STR_MAX_SIZE) {
	
	la $a0, str2			# $a0 -> 1º argumento da funçao strcpy
	la $a1, str1			# $a1 -> 2º argumento da funcao strcpy
	jal strcpy			#	chama a funcao strcpy(str2, str1);
	
	move $a0, $v0
	li $v0, print_string
	syscall				# 	print_string(strcpy(str2, str1));
	
	la $a0, str3
	li $v0, print_string
	syscall				#	print_string("\n");
	
	la $a0, str2
	jal strrev			# 	chamada a funcao strrev(str2)
	
	move $a0, $v0
	li $v0, print_string
	syscall				#	print_string(strrev(str2));
	
	li $s0, 0			#	exit_value = 0;
	
else:					# } else {
	la $a0, str4
	li $v0, print_string
	syscall				#	print_string("String too long: ");
	
	la $a0, str1
	jal strlen			#	chama a funcao strlen(str1)
	
	move $a0, $v0
	li $v0, print_int10
	syscall				# 	print_int10(strlen(str1));
	
	li $s0, -1			# 	exit_value = -1;
	
endIf:					# }
	move $v0, $s0			# return 0;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço da stack
			
	jr $ra				# termina o programa
	
# ---------------------------------------------- FUNÇAO STRCPY -------------------------------------- #

#char *strcpy(char *dst, char *src)
#{
#	int i=0;
#	do
#	{
#		dst[i] = src[i];
#	} while(src[i++] != '\0');
#	return dst;
#}

strcpy:
	li $t0, 0			# int i=0;
	move $t2, $a0			# dst -> $a0 -> $t2
	
do:
	addi $t0, $t0, 1		# i++
	addu $a0, $a0, $t0		# $a0 = &(dst[i])
	lb $t1, 0($a1)			# $t1 = src[i]
	sb $t1, 0($a0)			# dst[i] = src[i]
	
while:
	bne $t1, '\0', do		# while(src[i++] != '\0');
	
	move $v0, $t2			# return dst;	
	
	jr $ra				# termina a sub-rotina		

# ---------------------------------------------- FUNÇAO STRLEN --------------------------------------- #

strlen:
	li $t1, 0		# len = 0;

while:
	lb $t0, 0($a0)		# load byte - transfere um byte da memória para um registo externo, fazendo
				#             uma extensao de sinal do valor lido de 8 para 32 bits
				#	      $t0 -> registo destino do CPU
				#	      $a0 -> registo de endereçamento indireto
	addiu $a0, $a0, 1	# $a0 = *s++
	beq $t0, '\0', endWhile	# while(*s++ != '\0')
	addi $t1, $t1, 1	# len++;
	j while
	
endWhile:
	move $v0, $t1		# return len;
	jr $ra			# termina a subrotina

# ------------------------------------------- FUNÇÃO STRREV ------------------------------------------ #

strrev:
	addiu $sp, $sp, -16		# reserva espaço na stack
	sw $ra, 0($sp)			# guarda endereço de retorno
	sw $s0, 4($sp)			# guarda valores dos registos
	sw $s1, 8($sp)			# $s0, $s1 e $s2
	sw $s2, 12($sp)
	
	move $s0, $a0			# str: $a0 -> $s0 (argumento é passado em $a0)
	move $s1, $a0			# p1: $s1 (registo callee-saved) => p1 = str;
	move $s2, $a0			# p2: $s2 (registo callee-saved) => p2 = str;
	
while1:
	lb $t1, 0($s2)			# $t1 = *p2; -> fazer load byte para p2 passar a ponteiro
	beq $t1, '\0', endWhile1	# while( *p2 != '\0' ) {
	addiu $s2, $s2, 1		#	p2++;
	j while				# }
	
endWhile1:
	addiu $s2, $s2, -1		# p2--;
	
while2:
	bge $s1, $s2, endWhile2		# while(p1 < p2) {
	
	move $a0, $s1			# p1 é o 1º argumento da função exchange
	move $a1, $s2			# p2 é o 2º argumento da função exchange
	jal exchange			# 	exchange (p1, p2);
	
	addiu $s1, $s1, 1		# 	p1++;
	addiu $s2, $s2, -1		# 	p2--;
	
	j while2			# }
	
endWhile2:
	move $v0, $s0			# return str
	
	lw $ra, 0($sp)			# repõe o endereço de retorno
	lw $s0, 4($sp)			# repõe o valor dos registos
	lw $s1, 8($sp)			# $s0, $s1 e $s2
	lw $s2, 12($sp)
	addiu $sp, $sp, 16		# liberta o espaço na stack
	jr $ra				# termina a subrotina
	
# -------------------------------------------- FUNÇAO EXCHANGE ----------------------------------- #

exchange:
	lb $t0, 0($a0)		
	lb $t1, 0($a1)
	sb $t0, 0($a1)
	sb $t1, 0($a0)
	jr $ra

