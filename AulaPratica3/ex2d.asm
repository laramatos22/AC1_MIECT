#d)Sabendo que o código ASCII do 0 é 0x30 e do 1 é 0x31, o programa anterior pode ser
#simplificado, eliminando a estrutura condicional

#Ler um número introduzido pelo utilizador e apresentá-lo em binário
# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i
	.data
str1: 	.asciiz "Introduza um numero: "
str2: 	.asciiz "O valor em binário é: "
	.eqv print_string,4
	.eqv read_int,5
	.eqv print_char,11
	.text
	.globl main		#transforma os valores decimais em valores binários

main: 	la $a0,str1		#load address da str1
	li $v0,print_string 	# (instrução virtual)
	syscall 		# print_string(str1);
	
	li $v0,read_int 	# value=read_int();
	syscall
	
	or $t0,$0,$v0 		#$t0 = value = read_int();
	la $a0, str2
	li $v0,print_string 	# print_string("O valor em binário é: ");
	syscall
	
	li $t2,0 		# i = 0
	li $v0,print_char	# tranformação feita para binário
	
for: 	bge  $t2,32,endfor 	# while(i < 32) {
	rem  $t3,$t2,4		#em assembly do MIPS, o resto da divisão inteira pode ser obtido 
				#usando a instrução virtual "rem" (remainder), "rem Rdst,Rsrc,Src", 
				#em que Src pode ser um registo ou uma constante (Exemplo: rem $t0,$t1,4 
				#coloca em $t0 o resto da divisão inteira do valor de $t1 por 4.

if_espaco:	bne $t3,$0,end_espaco
		li $a0,' '
		syscall	
	
end_espaco:	andi $t1,$t0,0x80000000 # (instrução virtual)
		srl  $t1,$t1,31		# bit = (value & 0x80000000) >> 31;
		addi $t1,$t1,0x30	# 0x30 + bit
		move $a0,$t1

		li   $v0,'1'
		li   $v0,print_char 	# print_char('1');		
		syscall
		j endif 
	
endif:	sll $t0,$t0,1		# value = value << 1; shift left logical de 1 bit
	addi $t2,$t2,1		# i++;
	j for 			# }
	
endfor: 			#
	jr $ra 			# fim do programa
