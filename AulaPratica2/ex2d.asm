#ALÍNEA D) CÓDIGO DE GRAY
#$t0 = bin; $t1 = gray
	
	.data
	.text
	.globl main
main:	li $t0, val		#$t0 = valor em binário		
	srl $t2, $t0, 1		#(bin >> valor)
	xor $t1, $t0, $t2	#bin ^ (bin >> 1)
	jr $ra			#fim do programa
