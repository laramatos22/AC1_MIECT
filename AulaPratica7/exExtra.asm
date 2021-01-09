#EXERCICIO EXTRA 1 e 2

	.data
	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv read_int, 5
	
array:	.space 50	# int array[50];
str0:	.asciiz ", "
str1:	.asciiz "Size of array: "
str2:	.asciiz "array["
str3:	.asciiz "] = "
str4:	.asciiz "Enter the value to be inserted: "
str5:	.asciiz "Enter the position: "
str6:	.asciiz "\nOriginal array: "
str7:	.asciiz "\nModified array: "
	
	.text
	.globl main

#----------------------------------- FUNÇÃO INSERT ---------------------------------------#

# A função insert() insere o valor "value" na posição "pos" do "array" de inteiros de
# dimensão "size".

#int insert(int *array, int value, int pos, int size)
#{
#	int i;
#	if(pos > size)
#		return 1;
#	else
#	{
#		for(i = size-1; i >= pos; i--)
#			array[i+1] = array[i];
#		array[pos] = value;
#		return 0;
#	}
#}

# Mapa de Registos -> função insert
# $a0 : array
# $a1 : value
# $a2 : pos
# $a3 : size
# $t0 : i
# $t1 : array+i
# $t2 : array[i]
# $t3 : array+pos
# $t4 : array[pos]

insert:
	addiu $sp, $sp, -24		# reservar espaço na stack
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	
	move $s5, $a0			# $s5 = array
	
insert_if:
	ble $a2, $a3, insert_else	# if(pos > size)
	li $v0, 1			# return 1;
	j insert_if
	
insert_else:
	sll $s0, $a3, 2			# shift left logical -> $s0 = size * 4
	sub $s0, $s0, 4			# $s0 = size - 1
	sll $s3, $a2, 2			# shift left logical -> $s3 = pos * 4
	
insert_for:
	blt $s0, $s3 insert_endFor	# while(i >= pos), caso constrario insert_endIf
	
	sll $s1, $s0, 2			# shift left logical -> $s1 = i * 4
	addu $s1, $s5, $s1		# $s1 = array + i OU &(array[i])
	lw $s2, 0($s1)			# array[i] -> load word
	sw $s2, 4($s1)			# array[i+1] = array[i]
	
	sub $s0, $s0, 4			# i--;
	
insert_endFor:
	sll $s3, $a2, 2			# shift left logical -> $s3 = pos`* 4
	add $s3, $s5, $s3		# $s3 = array + pos OU &(array[pos])
	sw $a1, 0($s3)			# arrays[pos] = value;
	li $v0, 0			# return 0;
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	addiu $sp, $sp, -24		# liberta o espaço da stack
	
insert_end:
	jr $ra				# termina a sub-rotina
 
  
#--------------------------- FUNÇÃO PRINT_ARRAY -------------------------------------#
    
# A função print_array() imprime os valores de um array "a" de
# "n" elementos inteiros.

#void print_array(int *a, int n)
#{
#	int *p = a + n;
#	for(; a < p; a++)
#	{
#		print_int10( *a );
#		print_string(", ");
#	}
#}

# Mapa de registos:
# $a0 -> $t7 : a
# $a1 : n
# $t8 : p
# $t9 : *a

print_array:
	move $t7, $a0			# $t7 = a
	sll $a1, $a1, 2			# shift left logical -> n = n*4
	add $t8, $t7, $a1		# p = a+n;

prtarr_for:
	bge $t7, $t8, prtarr_end	# while(a < p)
	
	lw $t9, 0($t7)			# load word -> *a = $t9	
					# copia para o registo interno do CPU $t9 a word que estava armazenada na memória em $t7
	
	move $a0, $t9
	li $v0, print_int10
	syscall				# print_int10(*a);
	
	la $a0, str0
	li $v0, print_string
	syscall				# print_string(", ");
	
	addi $t7, $t7, 4		# a++;
	j prtarr_for
	
prtarr_end:
	jr $ra				# termina a sub-rotina

#----------------------------- FUNÇÃO MAIN ------------------------------------#

#int insert(int *, int, int, int);
#void print_array(int *, int);
#
#int main(void)
#{
#	int array[50];
#	int i, array_size, insert_value, insert_pos;
#
#	print_string("Size of array : ");
#	array_size = read_int();
#
#	for(i=0; i < array_size; i++)
#	{
#		print_string("array[");
#		print_int10(i);
#		print_string("] = ");
#		array[i] = read_int();
#	}
#
#	print_string("Enter the value to be inserted: ");
#	insert_value = read_int();
#	print_string("Enter the position: ");
#	insert_pos = read_int();
#
#	print_string("\nOriginal array: ");
#	print_array(array, array_size);
#
#	insert(array, insert_value, insert_pos, array_size);
#
#	print_string("\nModified array: ");
#	print_array(array, array_size + 1);
#	return 0;
#}

# Mapa de registos:
# $t0 : i
# $t1 : array_size
# $t2 : insert_value
# $t3 : insert_pos
# $t4 : array
# $t5 : i*4

main:
	addiu $sp, $sp, -4		# reserva espaço na stack
	sw $ra, 0($sp)			# salvaguarda o valor de $ra
	
	la $a0, str1
	li $v0, print_string
	syscall				# print_string("Size of array: ");

	li $v0, read_int
	syscall				# array_size = read_int();
	move $t1, $v0			# mover o valor de $v0 para $t1 -> $t1 = array_size
	
	li $t0, 0			# i=0;
	
main_for:
	bge $t0, $t1, main_endFor	# while(i < array_size)
	
	la $a0, str2
	li $v0, print_string
	syscall				# print_string("array[");
	
	move $a0, $t0			
	li $v0, print_int10
	syscall				# print_int10(i);
	
	la $a0, str3
	li $v0, print_string
	syscall				# print_string("] = ");
	
	sll $t5, $t0, 2			# $t5 = i*4
	la $t4, array			# $t4 = array
	add $t4, $t4, $t5		# $t4 = array+i OU &array[i]
	li $v0, read_int
	syscall				# read_int();
	sw $v0, 0($t4)			# store word -> $v0 = array[i]
	
	addi $t0, $t0, 1		# i++;
	j main_for
	
main_endFor:
	la $a0, str4
	li $v0, print_string
	syscall				# print_string("Enter the value to be inserted: ");

	li $v0, read_int
	syscall				# read_int();
	move $t2, $v0			# $t2 = insert_value = read_int();
	
	la $a0, str5
	li $v0, print_string
	syscall				# print_string("Enter the position: ");
	
	li $v0, read_int
	syscall				# read_int();
	move $t3, $v0			# $t3 = insert_pos = read_int();
	
	la $a0, str6
	li $v0, print_string
	syscall				# print_string("\nOriginal array: ");
	
	la $a0, array			# 1º argumento da função print_array -> $a0 = array
	move $a1, $t1			# 2º argumento da função print_array -> $a1 = array_size
	jal print_array			# chamada à sub-rotina print_array(array, array_size);
	
	la $a0, array			# 1º argumento da função insert -> $a0 = array
	move $a1, $t2			# 2º argumento da função insert -> $a1 = insert_value
	move $a2, $t3			# 3º argumento da função insert -> $a2 = insert_pos
	move $a3, $t1			# 4º argumento da função insert -> $a3 = array_size
	jal insert			# insert(array, insert_value, insert_pos, array_size);
	
	la $a0, str7
	li $v0, print_string
	syscall				# print_string("\nModified array: ");
	
	la $a0, array			# 1º argumento da função print_array -> $a0 = array
	addi $t1, $t1, 1		# $t1 = array_size + 1
	move $a1, $t1			# 2º argumento da função print_array -> $a1 = array_size
	jal print_array			# chamada à sub-rotina print_array(array, array_size);
	
	lw $ra, 0($sp)			# repõe o valor de $ra
	addiu $sp, $sp, 4		# liberta o espaço na stack
	li $v0, 0			# return 0;
	
	jr $ra				# termina o programa


	
