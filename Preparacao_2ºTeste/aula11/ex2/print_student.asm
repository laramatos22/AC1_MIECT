#void print_student(student *p)
#{
#	print_intu10(p->id_number);
#	print_str(p->first_name);
#	print_str(p->last_name);
#	print_float(p->grade);
#}

	.data
	
	# dados da estrutura
	.eqv id_number, 0
	.eqv first_name, 4
	.eqv last_name, 22
	.eqv grade, 40
	
	.eqv print_string, 4
	.eqv print_float, 2
	.eqv print_intu10, 36
	
str1:	.asciiz "\nID_Number: "
str2:	.asciiz "First Name: "
str3: 	.asciiz "Last Name: "
str4:	.asciiz "Grade: "
	
	.text
	.globl main

print_student:
	move $t0, $a0
	
	la $a0, str1
	li $v0, print_string
	syscall				# print_string("\nID_Number: ");
	lw $a0, id_number($t0)
	li $v0, print_intu10
	syscall				# print_intu10(p->id_number);
	
	la $a0, str2
	li $v0, print_string
	syscall				# print_string("First Name: ");
	addiu $a0, $t0, first_name
	li $v0, print_string
	syscall				# print_str(p->first_name);
	
	la $a0, str3
	li $v0, print_string
	syscall 			# print_string("Last Name: ");
	addiu $a0, $t0, last_name
	li $v0, print_string
	syscall				# print_str(p->last_name);
	
	la $a0, str4
	li $v0, print_string
	syscall				# print_string("Grade: ");
	l.s $f12, grade($t0)
	li $v0, print_float
	syscall				# print_float(p->grade);

	jr $ra				# termina a sub-rotina
