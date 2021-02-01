#typedef struct
#{
#	unsigned int id_number;
#	char first_name[18];
#	char last_name[15];
#	float grade;
#} student;

#define MAX_STUDENTS 4

#void read_data(student *, int);
#student *max(student *, int, float *);
#void print_student(student *);

#int main(void)
#{
#	static student st_array[MAX_STUDENTS];
#	static float media;
#	student *pmax;
#
#	read_data( st_array, MAX_STUDENTS );
#	pmax = max( st_array, MAX_STUDENTS, &media );
#	print_str("\nMedia: ");
#	print_float( media );
#	print_student( pmax );
#	return 0;
#}

	.data
	
	.eqv print_string, 4
	.eqv print_float, 2
	
	#detalhes da estrutura student
	.eqv id_number, 0
	.eqv first_name, 4
	.eqv last_name, 44
	.eqv grade, 40
	
	.eqv MAX_STUDENTS, 4
	
st_array:.space 176

str1:	.asciiz "\nMedia: "
	
	.text
	.globl main

main:
	addiu $sp, $sp, -8		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	sw $s0, 4($sp)			# guarda o valor de $s0
	
	la $a0, st_array		# $a0 = st_array
	li $a1, MAX_STUDENTS		# $a1 = MAX_STUDENTS
	jal read_data			# chamada à funcao read_data( st_array, MAX_STUDENTS );
	
	la $a0, st_array		# $a0 = st_array
	li $a1, MAX_STUDENTS		# $a1 = MAX_STUDENTS
	la $a2, media			# $a2 = media
	jal media			# chamada à funcao max( st_array, MAX_STUDENTS, &media );
	move $s0, $v0			# $s0 = return(max);
	
	la $a0, str1
	li $v0, print_string
	syscall				# print_str("\nMedia: ");
	
	la $t0, media			# $t0 = &media
	l.s $f12, 0($t0)		# $f12 = media
	li $v0, print_float
	syscall				# print_float( media );
	
	move $a0, $s0
	jal print_student		# print_student( pmax );
	
	li $v0, 0			# return 0;
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	lw $s0, 4($sp)			# repõe o valor de $s0
	addiu $sp, $sp, 8		# liberta o espaço na stack
	
	jr $ra				# termina o programa
