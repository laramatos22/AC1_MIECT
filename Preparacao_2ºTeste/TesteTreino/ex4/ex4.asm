#typedef struct
#{
#	char name[50];
#	int num;
#	float grade;
#	char type;
#} student;
#
#
#float fun3(student *std, int n)
#{
#	int i;
#	float sum=0.0;
#
#	for(i=0; i < n; i++)
#	{
#		print_string(std[i].name);
#		print_float(std[i].grade);
#		sum += std[i].grade;
#	}
#	return sum / 2.0;
#}
#
#
#int main(void)
#{
#	static student std[2] = {{ "Rei Eusebio", 12345, 17.2, 'F' },
#				 { "Rainha Amalia", 23450, 12.5, 'C' }};
#	print_float(fun3(std, 2));
#	return -1;
#}
#
#
# Mapa de registos:
# std : $a0 -> $t2
# n : $a1
# i : $t0
# sum :	$f2

	.data
	
sum:	.float 0.0
dois:	.float 2.0
	
	.eqv print_string, 4
	.eqv print_float, 2
	
	#dados da estrutura:
	#.eqv Name, offset
	.eqv name, 0	
	.eqv num, 52
	.eqv grade 56
	.eqv type, 60
	
std:
	.asciiz "Rei Eusebio"	# name = 12 espaços
	.space 38		# 50 - 12 = 38 espaços que ficam vazios
	.align 2		# alinhar
	.word 12345		# word alinha automaticamente
	.float 17.2
	.byte 'F'
	.asciiz "Rainha Amalia"	# name = 14 espaços
	.space 36		# 50 - 14 = 36 espaços que ficam vazios
	.align 2
	.word 23450		# word alinha automaticamente
	.float 12.5
	.byte 'C'
	
	.text
	.globl main
	
main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, std		# 1º argumento da função -> $a0 = std
	li $a1, 2		# 2º argumento da função -> $a1 = 2
	jal fun3		# chamada à função fun3(std, 2)
	
	mov.s $f12, $f0
	li $v0, print_float
	syscall			# print_float(fun3(std, 2));
	
	li $v0, -1		# return -1;
	
	lw $ra, 0($sp)		# repõe o valor de $ra
	addiu $sp, $sp, -4	# liberta o espaço na stack
		
	jr $ra			# termina o programa
	
# ------------------------------- FUNCAO FUN3 ---------------------------------- #

fun3:
	la $t0, sum		# $t0 = &sum
	l.s $f2, 0($t0)		# sum = $f2 = 0.0
	
	la $t0, dois		# $t0 = &dois
	l.s $f6, 0($t0)		# dois = $f6 = 2.0
	
	li $t0, 0		# int i=0;
	
	mul $t1, $t1, 64	# n = n * 64 (tamanho da estrutura student -> std)
	
	move $t2, $a0		# $t2 = &std
	
for:
	bge $t0, $t1, endFor	# for(i=0; i < n; i++)
	
	addu $t3, $t0, $t2	# $t3 = &std[i]
	
	lw $a0, name($t3)	# $a0 = std[i].name
	li $v0, print_string
	syscall			# print_string(std[i].name);
	
	l.s $f12, grade($t3)	# $f12 = std[i].grade
	li $v0, print_float
	syscall			# print_float(std[i].grade);
	
	add.s $f4, $f4, $f12	# sum += std[i].grade;
	
	addi $t0, $t0, 64	# i++;
	
	j for
	
endFor:
	div.s $f0, $f4, $f6	# return sum / 2.0;
	
	jr $ra

