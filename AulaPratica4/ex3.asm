# EXERCICIO 3

# Código em C

#define SIZE 4
#int array[4] = {7692, 23, 5, 234}; 	// Declara um array global de 4
#					// posições e inicializa-o
#void main (void)
#{
#	int *p; 			// Declara um ponteiro para inteiro
#					// (não há qualquer inicialização)
#	int *pultimo; 			// Declara um ponteiro para inteiro
#	int soma = 0;
#	p = array; 			// "p" é preenchido com o endereço
#					// inicial do array
#	pultimo=array+SIZE-1; 		// "pultimo" é inicializado com o
#					// endereço do último elemento do
#					// array, i.e., &array[SIZE-1]
#	while( p <= pultimo )
#	{
#		soma = soma + (*p);
#		p++; 			// Incrementa o ponteiro (não esquecer
#					// que incrementar um ponteiro para um
#					// inteiro de 32 bits significa somar a
#					// quantidade 4 ao valor do endereço)
#	}
#	print_int10(soma);
#}

# Mapa de registos:
# $t0 - p
# $t1 - pultimo
# $t2 - *p
# $t3 - soma

	.data
	.eqv SIZE, 4
array:	.word 7692, 23, 5, 234
	.eqv print_int10, 1
	.text
	.globl main
	
main:	
	li $t3, 0			# soma = 0;
	li $t4, SIZE			#
	sub $t4, $t4, 1			# $t4 = 3
	sll $t4, $t4, 2			# ou "mul $t4, $t4, 4"		
					#mul = multiply
	la $t0, array			# p = array;
	addu $t1, $t0, $t4		# pultimo = array + SIZE - 1;	

while:					# while(p <= pultimo)
	bgtu $t0, $t0, endWhile		# {
	lw $t2, 0($t0)			# $t2 = *p;
	add $t3, $t3, $t2		# soma = soma + (*p);
	addiu $t0, $t0, 4		# p++;
	j while				# }
	
endWhile:	
	move $a0, $t3
	li $v0, print_int10		# print_int10 (soma);
	syscall
	
	jr $ra				# terminar programa


