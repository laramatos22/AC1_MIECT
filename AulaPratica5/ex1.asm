# Exercicio 1 (FEITO COM AJUDA DO PROFESSOR NA AULA)

	.data
	.eqv SIZE, 5 	#define SIZE 5
	.eqv print_str, 4
	.eqv read_int, 5
	.text
	.globl main
main:			#void main(void) //void da esquerda: NAO recebe parametros e void da direita nao devolve valores
			#{
	.data		# informação que diz respeito ao segmento de dados
str:	.asciiz "\nIntroduza um numero: "
	.align 2	# 2^2 = 4 
lista: 	.space 20 	#	static int lista[SIZE]; // declara um array de inteiros
			#				// residente no segmento de dados
			#size (elementos do array) * 4 (numero de bytes de cada elementos)
	.text
#	$t0 -> i	#	int i;
	li $t0, 0	#	i = 0;

for:				
	bge $t0, SIZE, endFor	#	while(i<SIZE)
				#	{
				
	la $a0, str		
	li $v0, print_str
	syscall			#	print_string("\nIntroduza um numero: ");
	
	li $v0, read_int	
	syscall			# 	int temp = read_int();
	sll $t1, $t0, 2		# 	int temp1 = i * 4;
	la $t2, lista
	addu $t2, $t2, $t1	# 	int *temp2 = temp1 + &(lista[0]);
				# 	soma unsigned
				
	sw $v0, 0($t2)		#	lista[i] = temp;
				
	addi $t0, $t0, 1	# 	i++;

	j for			# 	}

endFor:
	jr $ra			# }



#	}
#}
