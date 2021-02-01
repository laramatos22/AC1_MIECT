	.data
	
	.eqv print_string, 4
	.eqv print_intu10, 36
	.eqv print_char, 11
	.eqv print_float, 2
	.eqv read_string, 8
	.eqv read_int, 5
	
	.eqv id_number, 0
	.eqv first_name, 4
	.eqv last_name, 22
	.eqv grade, 40
	
nmec:	.asciiz "\nN. Mec: "
nome:	.asciiz "\nNome: "
nota:	.asciiz "\nNota: "
1ststr:	.asciiz "\nPrimeiro Nome: "

stg:	.space 22
	.asciiz "Napoleao" 		# first_name
	.space 5			# espaço que fica vazio
	.float 5.1
	
	.text
	globl main
	
main:
	la $t0, stg			# $t0 = stg
	
	la $a0, nmec
	li $v0, print_string
	syscall				# print_string("\nN. Mec: ");
	li $v0, read_int
	syscall				# read_int()
	sw $v0, id_number($t0)		# stg.id_number = read_int() 
	
	la $a0, fname
	li $v0, print_string
	syscall				# print_string("\nPrimeiro Nome: ");
	addiu $a0, $t0, first_name	# buf = stg + offset
	li $a1, 18			# $a1 = length = 18
	li $v0, read_string
	syscall				# read_string(stg.first_name, 18)
	
	
	#--------------- alinea a)------------------#
	la $a0, nmec
	li $v0, print_string
	syscall				# print_str("\nN. Mec: ")
	lw $a0, id_number($t0)		# stg.id_number
	li $v0, print_intu10
	syscall				# print_intu10(stg.id_number);
	
	la $a0, nome
	li $v0, print_string
	syscall				# print_str("\nNome: ");
	addi $a0, $t0, last_name	# stg.last_name
	li $v0, print_tring
	syscall				# print_str(stg.last_name);
	li $a0, ','
	li $v0, print_char
	syscall				# print_char(',');
	addiu $a0, $t0, first_name	# stg.first_name
	li $v0, print_string
	syscall				# print_str(stg.first_name);
	
	la $a0, nota
	li $v0, print_string
	syscall				# print_str("\nNota: ");
	l.s $f12, grade($t0)		# stg.grade
	li $v0, print_float
	syscall				# print_float(stg.grade);
	
	li $v0, 0			# return 0
	
	jr $ra				# termina o programa