# Exercicio 1 alínea a)

# O programa lê uma string do teclado, conta o número de caracteres numéricos
# que ela contém e imprime esse resultado.

# Código em C

#define SIZE 20
#void main (void)
#{
#	static char str[SIZE];  // Reserva espaço para um array de
#				//"SIZE" carateres no segmento de
#				// dados
#	int num, i;
#	
#	read_string(str, SIZE); // "str" é o endereço inicial do
#				// espaço reservado para alojar a
#				// string (na memória externa)
#
#	num = 0;
#	i = 0;
#	while( str[i] != '\0' ) // Acede ao carater (byte) na
#				// posição "i" do array e compara-o
#				// com o carater terminador (i.e.
#				// '\0' = 0x00)
#	{
#		if( (str[i] >= '0') && (str[i] <= '9') )
#			num++;
#		i++;
#	}
#	print_int10(num);
#}

# Mapa de registos
# $t0 - num
# $t1 - i
# $t2 - endereço inicial da string (str)
# $t3 - endereço da posição "i" da string (str+i)
# $t4 - conteúdo de str[i]

	.data
	.eqv  SIZE, 20			# define SIZE 20
	.eqv read_string, 8
	.eqv print_int10, 1
str:	.space SIZE			# static char str[SIZE]
	.text
	.globl main

main:					# void main (void)
	la $a0, str			# $a0=&str[0] (endereço da posição
					# 0 do array, i.e., endereço
					# inicial do array)
	li $a1, SIZE			# $a1 = SIZE
	ori $v0, $0, read_string	# read_strring(str, SIZE)
	syscall
	
	li $t0, 0			# $t0 = num = 0
	li $t1, 0			# $t1 = i = 0
	
while:	
	la $t2, str
	addu $t3, $t2, $t1		# add unsigned -> str + i
	lb $t4,0($t3)			# load Byte lb Rdst, addr -> $t4 = str[i]
	
	beq  $t4, '\0', endw		# while( str[i] != '\0' 
	
if: 	blt $t4,'0',endif 		# if(str[i] >= '0' &&
	bgt $t4,'9',endif 		# str[i] <= '9');
	addi $t0, $t0, 1 		# num++;
	
endif:
	addi $t1, $t1, 1 		# i++;
	j    while			# }
	
endw: 
	ori $v0, $0, print_int10	# print_int10(num);
	or $a0, $0, $t0 
	syscall
	
	jr $ra 				# termina o programa 
