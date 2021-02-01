#void read_data(student *st, int ns)
#{
#	int i;
#
#	for(i=0; i < ns; i++)
#	{
#		print_str("N. Mec: ");
#		st[i].id_number = read_int();
#		print_str("Primeiro Nome: ");
#		read_str(st[i].first_name, 18);
#		print_str("Ultimo Nome: ");
#		read_str(st[i].last_name, 15);
#		print_str("Nota: ");
#		st[i].grade = read_float();
#	}
#}

	.data
	
	.eqv print_string, 4
	.eqv read_string, 8
	.eqv read_float, 6
	
	#dados da estrutura
	.eqv id_number, 0
	.eqv first_name, 4
	.eqv last_name, 22
	.eqv grade, 40
	
str1:	.asciiz "N. Mec: "
str2:	.asciiz "Primeiro Nome: "
str3:	.asciiz "Ultimo Nome: "
str4:	.asciiz "Nota: "

	.text
	.globl read_data

read_data:
	li $t0, 0			# int i=0;
	move $t4, $a1			# ns : $a1 -> $t4
	move $t1, $a0			# st : $a0 -> $t1
	
for:
	bge $t0, $t4, endFor		# for(i=0; i < ns; i++)
	
	la $a0, str1
	li $v0, print_string
	syscall				# print_str("N. Mec: ");
	li $v0, read_int
	syscall				# read_int()
	mul $t2, $t0, 44
	addu $t2, $t1, $t2		# $t2 = &st[i] = &(st + i)
	sw $v0, id_number($t2)		# st[i].id_number = read_int();
	
	la $a0, str2
	li $v0, print_string
	syscall				# print_str("Primeiro Nome: ");
	addiu $a0, $t2, first_name	# $a0 = st[i].first_name;
	li $a1, 18
	li $v0, read_string
	syscall				# read_str(st[i].first_name, 18);
	
	la $a0, str3	
	li $v0, print_string
	syscall				# print_str("Ultimo Nome: ");
	addiu $a0, $t2, last_name	# $a0 = st[i].last_name;
	li $a1, 15
	li $v0, read_string
	syscall				# read_str(st[i].last_name, 15);
	
	la $a0, str4
	li $v0, print_string
	syscall				# print_str("Nota: ");
	li $v0, read_float
	syscall				# read_float()
	addiu $t2, $t2, grade		# $t2 = st[i].grade
	s.s $f0, 0($t2)			# st[i].grade = read_float();
	
	addi $t0, $t0, 1		# i++
	j for
	
endFor:
	jr $ra				# termina o programa

