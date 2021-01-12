# EXERCICIO 1 - alinea b)

	.data
	.eqv print_str, 4
	.eqv print_intu10, 36
	.eqv print_char, 11
	.eqv print_float, 2
	.eqv read_int, 5
	.eqv read_str, 8
	.eqv read_float, 6
	
	.eqv id_number, 0 #offset
	.eqv last_name, 22
	.eqv first_name, 4
	.eqv grade, 40
	
	
nmec:	.asciiz "\nN. Mec: "
nome:	.asciiz "\nNome: "
nota:	.asciiz "\nNota: "

stg:	.space 44
	
	.text
	.globl main


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
#	stg.id_number = read_int();
#	print_intu10(stg.id_number);
#
#	print_str("\nNome: ");
#	read_str(stg.last_name, 15);
#	print_str(stg.last_name);
#	print_char(',');
#	read_str(stg.first_name, 18);
#	print_str(stg.first_name);
#
#	print_str("\nNota: ");
#	read_float(stg.grade)
#	print_float(stg.grade);
#	return 0;
#}

# Mapa de registos:
# $t0 : stg
# $t1 : id_number
# $f0 : result

main:
	la $t0, stg			# $t0 = stg
	
	la $a0, nmec
	li $v0, print_str
	syscall				# print_str("\nN. Mec: ");
	li $v0, read_int
	syscall				
	sw $v0, id_number($t0)		# stg.id_number = read_int();
	li $v0, print_intu10	
	syscall				# print_intu10(stg.id_number);
	
	la $a0, nome
	li $v0, print_str
	syscall				# print_str("\nNome: ");
	addiu $a0, $t0, last_name	# endereço
	li $a1, 15			# comprimento total do last_name
	li $v0, read_str	
	syscall				# read_str(stg.last_name, 15);
	li $v0, print_str	
	syscall				# print_str(stg.last_name);
	li $a0, ','
	li $v0, print_char
	syscall				# print_char(',');
	addiu $a0, $t0, first_name	# endereço
	li $a1, 18			# comprimento total do first_name
	li $v0, read_str	
	syscall				# read_str(stg.first_name, 18);
	li $v0, print_str	
	syscall				# print_str(stg.first_name);
	
	la $a0, nota			
	li $v0, print_str
	syscall				# print_str("\nNota: ");
	l.s $f12, grade($t0)
	li $v0, read_float
	syscall				# read_float(stg.grade)
	li $v0, print_float
	syscall				# print_float(stg.grade);
	
	li $v0, 0			# return 0
	
	jr $ra				# termina o programa
	
