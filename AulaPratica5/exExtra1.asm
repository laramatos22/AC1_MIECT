#EXERCICIO EXTRA 1

#Programa de ordenação sequential-sort

#define SIZE 10
#
#void main(void)
#{
#	static int lista[SIZE];
#	int i, j, aux;
#
#	// inserir aqui o código para leitura de valores e
#	// preenchimento do array
#
#	for(i=0; i < SIZE-1; i++)
#	{
#		for(j = i+1; j < SIZE; j++)
#		{
#			if(lista[i] > lista[j])
#			{
#				aux = lista[i];
#				lista[i] = lista[j];
#				lista[j] = aux;
#			}
#		}
#	}
#	// inserir aqui o código de impressão do conteúdo do array
#}

#Mapa de registos:
# $t0 - i
# $t1 - j
# $t2 - aux
# $t3 - lista[0]
# $t4 - lista[i]
# $t5 - lista[j]
# $t6 - index de lista i -> &lista[i]
# $t7 - index de lista j

	.data
	.eqv SIZE, 10
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_int10, 1
	
lista:	.space 40			# 10*4
str1:	.asciiz "Introduza um número: "
str2:	.asciiz "; "
str3:	.asciiz "Conteudo do array: \n"

	.text
	.globl main
	
main:
	li $t0, 0			# i=0
	la $t3, lista			# $t3 = lista[0]
	la $t6, lista			# $t6 = index de list i
		
input:					# leitura de dados e preenchimento do array
	bge $t0, SIZE, code		# qdo i for igual a SIZE vai para code
					# caso contrário continua em input até preencher o SIZE
	la $a0, str1
	li $v0, print_string
	syscall				# print_string("Introduza um número: ");
	
	li $v0, read_int
	syscall				# read_int()
	
	sll $t6, $t0, 2			# shift left logical -> $t6 = i * 4
	add $t6, $t6, $t3		# $t6 = &(lista[i])
	sw $v0, 0($t6)			# store word - copia a word armazenada em $v0 para o registo $t6 da memória 
	addi $t0, $t0, 1		# i++
	j input
	
code:
	li $v0, 0			# i=0
					# código que prepara i para o primeiro for
					
for1:
	bge, $t0, 9, print		# while(i < SIZE-1)
					# SIZE - 1 = 9
	addi $t1, $t0, 1		# j = i+1
					# código que prepara para o segundo for
					
for2:
	bge $t1, 10, endFor1		# se j for maior ou igual a SIZE passa para endFor1
	sll $t6, $t0, 2			# shift left logical -> $t6 = i*4
	add $t6, $t6, $t3		# $t6 = &(lista[i])
	sll $t7, $t1, 2			# $t7 = j*4
	add $t7, $t7, $t3		# $t7 = &(lista[j])
	lw $t4, 0($t6)			# load word - transferência de $t4 da memória para o registo interno $t6 do CPU
	lw $t5, 0($t7)			# transferência de $t5 da memória para o registo interno $t7 do CPU
	ble $t4, $t5, endFor2		# if(lista[i] > lista[j])
	or $t2, $t4, $0			# aux = lista[i] or 0 = lista[i]
	sw $t5, 0($t6)			# store word - transferência do registo do CPU $t5 para o registo de memória $t6
					# lista[i] = lista[j];
	sw $t2, 0($t7)			# store word - transferência do registo do CPU $t2 para o registo de memória $t7
					# lista[j] = aux;
	
endFor2:
	addi $t1, $t1, 1		# j++
	j for2				# jump for2
	
endFor1:
	addi $t0, $t0, 1		# i++
	j for1				# jump for1
	
#--------código de impressão de resultados: ------------------#
print:
	la $t6, lista			# $t6 = lista
	li $t0, 0			# i=0
	
	la $a0, str3
	li $v0, print_string
	syscall				# print_string("Conteudo do array: \n");
	
forPrint:				# for para a impressão dos resultados/conteúdo do array
	bge $t0, 10, end		# qdo i for maior ou igual a 10, passa para end e termina o programa
	sll $t6, $t0, 2			# $t6 = i*4
	add $t6, $t6, $t3		# $t6 = &(lista[i])
	
	lw $a0, 0($t6)			# load word - copia para o registo $a0 a word armazenada no registo interno do CPU $t6
	li $v0, print_int10
	syscall				# print_int10();
	
	la $s0, str2
	li $v0, print_string
	syscall				# print_string("; ");
	
	addi $t0, $t0, 1		# i++
	j forPrint
	
end:
	jr $ra				# termina o programa		
				