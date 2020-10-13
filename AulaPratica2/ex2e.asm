#ALÍNEA E) GRAY -> BINÁRIO
#$t0=gray; $t1=num; $t2=bin; $t3 = var temporaria

	.data
	.text
	.globl main
main: 	li $t0, val		#gray = valor
	move $t1, $t0		#num = gray
	srl $t3, $t1, 4		#var = num >> 4
	xor $t1, $t1, $t3	#num = num ^ var
	srl $t3, $t1, 2		#var = num >> 2
	xor $t1, $t1, $t3	#num = num ^ var
	srl $t3, $t1, 1		#var = num >> 1
	xor $t1, $t1, $t3	#num = num ^ var
	move $t2, $t1		#bin = num
	
	jr $ra			#fim do programa
	
