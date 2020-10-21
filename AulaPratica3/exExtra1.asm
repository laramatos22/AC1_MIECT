#Mapa de registos
# $t0 - gray
# $t1 - bin
# $t2 - variável temporária temp

	.data
str1:	.asciiz "Introduza um número: "
str2:	.asciiz "\nO valor em código gray é: "
str3:	.asciiz "\nO valor em código binário é: "

	.eqv print_string,4
	.eqv print_int,1
	.eqv read_int,5
	.text
	.globl main
	
main:	la $a0,str1
	li $v0,print_string	#print_string
	syscall
	
	li $v0,read_int		#read_int
	syscall
	or $t0,$t0,$v0		#gray = input
	
	srl $t2, $t0, 1		#temp = gray >> 1
	move $t1,$t0
	j while

while:	beqz $t2,end_while	#if(temp != 0)
	xor $t1,$t1,$t2		#~(bin || temp)
	srl $t2,$t2,1		#temp >> 1
	j while
	
end_while:
	la $a0,str2
	li $v0,print_string	#print_string
	syscall
	
	move $a0,$t1
	li $v0,print_int	#print_int(gray)
	syscall
	
	la $a0,str3
	li $v0,print_string	#print_string
	syscall
	
	move $a0,$t0
	li $v0,print_int	#print_int(binário)
	syscall
	
	jr $ra