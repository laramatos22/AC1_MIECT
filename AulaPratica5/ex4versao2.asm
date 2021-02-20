# EXERCICIO 4 AGAIN
#
#define SIZE 10
#
#void main(void)
#{
#	static int lista[SIZE];
#	int houveTroca;
#	int aux;
#	int *p, *pUltimo;
#	// inserir aqui o código para leitura de valores e
#	// preenchimento do array
#
#	pUltimo = lista + (SIZE - 1);
#	do
#	{
#		houveTroca = FALSE;
#		for (p = lista; p < pUltimo; p++)
#		{
#			if (*p > *(p+1))
#			{
#				aux = *p;
#				*p = *(p+1);
#				*(p+1) = aux;
#				houveTroca = TRUE;
#			}
#		}
#	} while (houveTroca==TRUE);
#	// inserir aqui o código de impressão do conteúdo do array
#}
#
# Mapa de registos:
# *p: $t0
# *(p+1): $t1
# aux: $t2
# i: $t3
# houveTroca: $t4
# p: $t5
# pUltimo: $t6

	.data
	
	.eqv FALSE, 0
	.eqv TRUE, 1
	.eqv read_int, 5
	.eqv print_string, 4
	.eqv print_int10, 1
	
str1:	.asciiz "Introduza um número: "
str2:	.asciiz "Conteudo do array: "
str3:	.asciiz "; "
	.align 2
lista:	.space 40

	.text
	.globl main

main:						# void main(void) {
	li $t3, 0				# int i=0
	
while:
	bge $t3, SIZE, endWhile			# while(i < SIZE) {
			
	la $a0, str1				# $a0 = str1
	li $v0, print_string			# $v0 = print_string
	syscall					# print_string("Introduza um número: ");
	
	li $v0, read_int			
	syscall					# $v0 = read_int();
	
	sll $t2, $t3, 2				# int aux = i*4
	la $t0, lista				# int *p = &(lista[0])
	addu $t0, $t0, $t2			# p = p + aux
	sw $v0, 0($t0)				# lista[i] = read_int();
	addi $t3, $t3, 1			# i++;
	j while					# }
	
endWhile:
	la $t5, lista				# $t5 = &(lista[0])
	li $t6, SIZE				# $t6 = SIZE
	subu $t6, $t6, 1			# $t6 = SIZE - 1
	sll $t6, $t6, 2				# $t6 = (SIZE - 1) * 4
	addu $t6, $t6, $t5			# pUltimo = lista + (SIZE - 1);
	
do:						# do {
	la $t5, lista				# $t5 = &(lista[0])
	li $t4, FALSE				# houveTroca == FALSE

while2:
	bge $t5, $t6, endWhile2			# for (p = lista; p < pUltimo; p++) {
	
	lw $t0, 0($t5)				# $t0 = *p; -> criação de ponteiro
	lw $t1, 4($t5)				# $t1 = *(p+1); -> criação de ponteiro
	
if:
	ble $t0, $t1, endif			# if (*p > *(p+1)) {
	
	move $t2, $t0				# aux = *p;
	sw $t1, 0($t5)				# *p = *(p+1);
	sw $t0, 4($t5)				# *(p+1) = aux;
	
	li $t4, TRUE				# houveTroca = TRUE;
	
endif:
	addiu $t5, $t5, 4			# p++;
	j while2
	
endWhile2:
	beq $t4, TRUE, do			# while (houveTroca==TRUE);
	
endWhile:
	li $t3, 0				# i=0;
	
while3:
	bge $t3, SIZE, endWhile3		# while(i < SIZE) {
	
	la $t0, lista				# $t0 = int *p = &(lista[0])
	sll $t2, $t3, 2				# int aux = i*4
	addu $t2, $t0, $t2			# aux = lista + i OU &(lista[i])
	
	li $v0, print_int10			# $v0 = print_int10
	lw $a0, 0($t2)				# $a0 = lista[i]
	syscall					# print_int10(lista[i]);
	
	li $v0, print_string			# $v0, print_string
	la $a0, str3				# $a3 = str3
	syscall					# print_string(";");

	addi $t3, $t3, 1			# i++;
	j while3
	
endWhile3:
	jr $ra					# termina o programa
	
	