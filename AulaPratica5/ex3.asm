#EXERCICIO 3

# Mapa de registos
# k: $t0
# temp_lista: $t1
# temp_lista[k]: $t2
# houve_troca: $t4
# p: $t5
# pUltimo: $t6
# lista + i: $t7

	.data
str1:	.asciiz "Introduza um número:"
str2:	.asciiz "\nConteúdo do array: "
str3:	.asciiz "; "
	.align 2
lista:	.space 40			# 4 * size
	.eqv FALSE,0
	.eqv TRUE,1
	.eqv SIZE,10
	.eqv print_int10,1
	.eqv print_string,4
	.eqv read_int,5
	.text
	.globl main
	
main: 	li $t0, 0			#k = 0

input:	bge $t0,SIZE,end		#while(k < SIZE)
	
	la $a0, str1			# código para leitura de valores
	li $v0, print_string
	syscall				#print("introduza um número");
	li $v0, read_int
	syscall				#read_int();
	
	la $t1, lista			#$t1 = temp_lista
	sll $t2, $t0,2
	addu $t2,$t2,$t1		#$t2 = &temp_lista[k]
	sw $v0, 0($t2)			#lista[k] = read_int();
	addi $t0,$t0,1			#k++;
	j input
		
end:	la $t6,lista 			# $t6 = lista (ou &lista[0])

do: 					# do {
	li $t4,FALSE 			# 	houve_troca = FALSE;
	li $t5,0 			# 	i = 0;
	
for: 	bge $t5, SIZE,endfor		# 	while(i < SIZE-1){

if: 	sll $t7,$t5,2 			# 		$t7 = i * 4
	addu $t7,$t7,$t6 		# 		$t7 = &lista[i]
	lw $t8,0($t7) 			# 		$t8 = lista[i]
	lw $t9,4($t7) 			# 		$t9 = lista[i+1]
	ble $t8,$t9,endif 		# 		if(lista[i] > lista[i+1]){
	sw $t8,4($t7) 			# 			lista[i+1] = $t8
	sw $t9,0($t7) 			# 			lista[i] = $t9
	li $t4,TRUE 			#
					# 		}
endif: 	addi $t5,$t5,1			# 		i++;
	j for
		 			# 	}
endfor:	beq $t4,TRUE, do		# } while(houve_troca == TRUE);
	la $a0,str2			# codigo de impressao do
	li $v0, print_string		# conteudo do array
	syscall
	li $t5,0
	
print:	bge $t5, SIZE, endw
	la $t6, lista
	sll $t2,$t5,2
	addu $t2,$t2,$t6
	lw $a0, 0($t2)
	li $v0, print_int10
	syscall
	la $a0, str3
	li $v0, print_string
	syscall
	addi $t5,$t5,1
	j print

endw:	jr $ra 				# termina o programa