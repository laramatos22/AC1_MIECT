# Exercicio 2 alínea a)

# utilizar um ponteiro para fazer um código assembly alternativo ao da questão 1
 
# Um ponteiro para uma dada posição do array é uma variável (que pode residir num
# registo interno do CPU) que contém o endereço dessa posição do array

# Código em C

#define SIZE 20
#void main (void)
#{
#	static char str[SIZE];	// Reserva espaço para um array de
#				// "SIZE" carateres no segmento de dados
#
#	int num = 0;
#
#	char *p; 		// Declara um ponteiro para carater
#				// (não há qualquer inicialização)
#
#	read_string(str, SIZE); // Le do teclado uma string com um
#				// máximo de 20 carateres
#
#	p = str; 		// Inicializa o ponteiro "p" com o
#		 		// endereço inicial da string
#
#				// (equivalente a fazer p = &(str[0]))
#	while( *p != '\0' ) 	// Acede ao byte apontado pelo ponteiro
#				// "p" (*p) e compara o valor lido com
#				// o carater terminador ('\0' = 0x00)
#	{
#		if( (*p >= '0') && (*p <= '9') )
#			num++;
#		p++; 		// Incrementa o ponteiro (o ponteiro
#				// passa a ter o endereço da posição
#				// seguinte do array)
#	}
#	print_int10(num);
#}

# Mapa de registos:
# num: $t0
# p:   $t1
# *p:  $t2

	.data
	.eqv SIZE, 20		#define SIZE 20
	.eqv read_string, 8	#read_int(str, SIZE)
	.eqv print_int10, 1	#print_int10(soma)
str:	.space SIZE

	.text
	.globl main
	
main:	
	li $t0, 0		# num = 0;
	la $a0, str
	li $a1, SIZE
	ori $v0, $0, read_string	 # read_string(str. SIZE);
	syscall
	
	la $t1, str
	
while: 				# while(*p != '\0')
	lb $t2,0($t1) 		#
	beq $t2,0,endw 		# {
	blt $t2,'0',endif 	# if(str[i] >='0' &&
	bgt $t2,'9',endif 	# str[i] <= '9')
	addi $t0, $t0, 1 	# num++;
	
endif:
	addiu $t1, $t1, 1	# p++;
	j while			# }

endw: 	ori $v0, $0, print_int10	# print_int10(num);
	or $a0, $0, $t0 
	syscall
	
	jr $ra 				# termina o programa
