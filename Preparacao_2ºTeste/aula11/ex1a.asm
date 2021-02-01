#typedef struct
#{
#	unsigned int id_number;
#	char first_name[18];
#	char last_name[15];
#	float grade;
#} student;

#int main(void)
#{
#	// define e inicializa a estrutura "stg" no segmento de dados
#	static student stg = {72343, "Napoleao", "Bonaparte", 5.1};
#
#	print_str("\nN. Mec: ");
#	print_intu10(stg.id_number);
#
#	print_str("\nNome: ");
#	print_str(stg.last_name);
#	print_char(',');
#	print_str(stg.first_name);
#
#	print_str("\nNota: ");
#	print_float(stg.grade);
#	return 0;
#}

	.data
	
	.eqv print_string, 4
	.eqv print_intu10, 36
	.eqv print_char, 11
	.eqv print_float, 2
	
	.eqv id_number, 0
	.eqv first_name, 4
	.eqv last_name, 22
	.eqv grade, 40
	
nmec:	.asciiz "\nN. Mec: "
nome:	.asciiz "\nNome: "
nota:	.asciiz "\nNota: "

stg:	.word 72343 		# id_number
	.asciiz "Napoleao" 	# first_name
	.space 9		# espaço que fica vazio
	.asciiz "Bonaparte"	# last_name
	.space 5		# espaço que fica vazio
	.float 5.1
	
	.text
	globl main
	
# Mapa de registos:
# $t0 : stg 		-> variável do tipo student
# $t1 : id_number 	-> int
# $f0 : result		-> float
	
main:
	la $t0, stg			# $t0 = stg
	
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
	