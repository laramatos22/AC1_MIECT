	.data
	.text
	.globl main
main: 	li $t0,0x12345678 	# instru��o virtual (decomposta
				# em duas instru��es nativas)
	sll $t2,$t0,1 		# Shift Left Logical 
	srl $t3,$t0,1 		# Shift Right Logical
	sra $t4,$t0,1 		# Shift Right Arithmetic
	
	jr $ra 			# fim do programa
	
	
	
	
