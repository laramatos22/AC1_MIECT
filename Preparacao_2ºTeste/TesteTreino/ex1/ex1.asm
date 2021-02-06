# EXERCICIO 1

# float (4 bytes) -> single precision
# double (8 bytes) -> double precision

					# comentarios segundo o que � pedido nos exercicios
	.data				# 0x10010000
X1:	.asciiz "TSTEX2-2021"		# a) ocupa 12 posi��es de memoria 
X2:	.space 26			# b) 0x10010000 + C (12 em hexadecimal) = 0x1001000C
					# c) X2 � o endere�o inicial de um arrays de "floats"
					#    R.: dimensao maxima do array: 26/4 = 6 floats
					#				   cada float ocupa 4 posi��es
	
	# d) Se "X2" for o endere�o inicial de um array de "floats", qual o endere�o de mem�ria da posi��o X2[4] desse
	# array?
	# 	X2[4]-> 12 posi��es + 16 (4 x 4 bytes) = 28 (em decimal)
	#		= C + 10 = 1C (em hexadecimal)
	# 	Logo, &(X2[4]) = 0x10010000 + 1C = 0x1001001C
	
X3:	.byte 0xFF			# X3 = 1 byte

	# e) Qual o n�mero total de bytes de mem�ria usado pelo segmento de dados do programa?
	# X1 = 12 bytes
	# X2 = 26 bytes
	# X3 = 1 byte
	# TOTAL: 39 bytes

	.text				# 0x00400000
	.globl main
	
	# f) Considerando que a primeira instru��o do trecho de c�digo fornecido est� armazenada a partir do endere�o
	# 0x00400000, quais os endere�os a que correspondem os labels "L1" e "L2"? (tenha em aten��o as instru��es
	# virtuais do programa).
	# L1: 0x0040001C 
	# L2: 0x00400038
	# nota: cada isntru��o nativa vale 4 e cada instru��o virtual vale 8
	
main:
	ori $t0, $t0, 0x39		# $t0 = 0x39 = '9'
	la $t4, X1			# $t4 = X1
	la $t5, X2			# $t5 = X2
	move $t6, $t5			# $t6 = $t5 = X2

L1:
	bge $t4, $t5, L3		# while ($t4 < $t5) {
	lb $a0, 0($t4)			# 	$a0 = load Byte -> faz load de uma letra/caracter
	bgt $a0, $t0, L2		# 	if ($a0 <= 0x39) {
	sb $a0, 0($t6)			# 	$a0 = Memory[$t6 + 0] -> store byte, guarda o caracter
	addiu $t6, $t6, 1		# 	X2++;
	
L2:
	addiu $t4, $t4, 1		#   	} X1++;
	j L1
	
L3:
	lw $v0, 0($t5)			# } $v0 = X2[0] -> load word
					# h) $t5 : 0x1001000C (fim do array)
					# i) $v0 : \0 -> return 0
	jr $ra				# termina o programa
