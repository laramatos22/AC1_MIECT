	.data

	.text
	.globl main
main: 	ori $v0,$0,5 	# toma o valor 5
	syscall 	# chamada ao syscall "read_int()"
	or $t0,$0,$v0 	# $t0 = $v0 = valor lido do teclado
			# (valor de x pretendido)
			#
	ori $t2,$0,8 	# $t2 = 8
	add $t1,$t0,$t0 # $t1 = $t0 + $t0 = x + x = 2 * x
	sub $t1,$t1,$t2 # $t1 = $t1 + $t2 = y = 2 * x - 8
			# ($t1 tem o valor calculado de y)
			#
	or $a0,$0,$t1 	# $a0 = y
	ori $v0,$0,1 	#
	syscall 	# chamada ao syscall "print_int10()"
			#
			# alínea c)
			#
	li $a0, '\n'	# $a0 = \n
	li $v0, 11	#
	syscall		# chamada ao syscall "print_char()"
			#
	or $a0, $0, $t1	# $a0 = y
	ori $v0, $0, 34	#
	syscall		# chamada ao syscall "print_int16()"
			#
	li $a0, '\n'	# $a0 = \n
	li $v0, 11	#
	syscall		# chamada ao syscall "print_char()"
			#
			# alínea d)
			#
	or $a0, $0, $t1	# $a0 = y
	ori $v0, $0, 36	#
	syscall		# chamada syscall "print_intu10()"
			#
	jr $ra 		# fim do programa
