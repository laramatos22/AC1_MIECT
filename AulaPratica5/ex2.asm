#EXERCICIO 2

# Mapa de registos:
# $t0 : p
# $t1 :*p
# $t2: lista + Size 

	.data
	
str1:	.asciiz "\nConteudo do array:\n"
str2:	.asciiz "; "
	#.align 2 não é necessário neste exercicio
lista:	.word 8,-4,3,5,124,-15,87,9,27,15	#static int lista[]={8, -4, 3, 5, 124, -15, 87, 9, 27, 15};
						# a diretiva ".word" alinha num endereço
						# múltiplo de 4
	.eqv SIZE, 10				#define SIZE 10
	.eqv print_int10, 1
	.eqv print_string, 4
	.text
	.globl main
main:						#void main(void)
						#{
	la $a0, str1				# 	$a0 = str1
	li $v0, print_string			#	$v0 = print_string
	syscall					#	print_string("\nConteudo do array:\n");
	
	la $t0,lista				# 	p = lista
	li $t2,SIZE				#	$t2 = SIZE
	sll $t2, $t2, 2				#	$t2 = $t2 * 4
	addu $t2,$t0,$t2 			# 	$t2 = lista + SIZE;
	
while:	
	bgeu $t0, $t2, endWhile			# 	while(p < lista + SIZE) {
	lw $t1, 0($t0)				# 	$t1 = *p;
						#	endereçamento indireto do registo
	or $a0, $0, $t1				# 	OU move $a0, $t1
	li $v0, print_int10		
	syscall					#	print_int10( *p ); 	// Imprime o conteúdo da posição do
						#				// array cujo endereço é "p"
	
	la $a0, str2
	li $v0, print_string	
	syscall					#	print_string("; ");

	addiu $t0, $t0, 4			# 	p++;
	
	j while
	
endWhile:
	jr $ra					# 	termina programa

