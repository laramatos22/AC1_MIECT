# EXERCICIO 4

#define SIZE 10
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

#Mapa de registos:
#$t0 : i
#$t1 : p
#$t2 : pUltimo
#$t3 : p+1
#$t4 : *p
#$t5 : *(p+1)
#$t6 : houve_troca
#$t7 : aux

	.data
lista:  .space 40
str1:   .asciiz "Introduza um número: "
str2: 	.asciiz "; "
str3:	.asciiz "\nConteúdo do array:\n"
	.text
	.eqv print_int10, 1
	.eqv print_string,4
	.eqv read_int, 5
	.eqv FALSE, 0
	.eqv TRUE,1
	.eqv SIZE,10
	.globl main

main:	
	ori $t0,$0,0     		#i=0
	la $t1,lista      		#p=lista[0]
	addi $t2,$t1,39			#pUltimo = lista[size-1]
	
input:
	bge $t0,SIZE,do			#while(i < SIZE)
	la $a0,str1
	li $v0,print_string
	syscall				#print_str(str)
	li $v0,read_int
	syscall				#read_int()
	sw $v0,0($t1)
	addi $t1,$t1,4 			#p+=4
	addi $t0,$t0,1 			#i++
	j input

do:	li $t6,FALSE  			# houve_troca = FALSE;
	la $t1,lista   			#p=lista[0]
	
for:	bge $t1,$t2,endw
	addi $t3,$t1,4        		#p + 1 = p + 4
	lw $t4,0($t1) 	      		#*p
	lw $t5,0($t3) 	      		#*(p+1)
	ble $t4,$t5,endfor
	or $t7,$t4,$0
	sw $t5,0($t1)
	sw $t7,0($t3) 
	li $t6,TRUE	     		# houve_troca = TRUE;
	
endfor:	addi $t1,$t1,4  		#p+=4
	j for
	
endw:	beq $t6,TRUE,do
	la $t1,lista      		#p=lista[0]
	la $a0,str3
	li $v0,print_string
	syscall				#print_str()

print:
	bge $t1,$t2,end
	lw $a0,0($t1)
	li $v0,print_int10		#print_int10()
	syscall
	la $a0,str2
	li $v0,print_string
	syscall				#print_str("; ")
	addi $t1,$t1,4  		#p+=4
	j print
end:
	jr $ra

