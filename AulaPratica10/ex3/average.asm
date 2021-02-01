#função para calcular o valor médio de um array de reais
#codificados em formato vírgula flutuante, precisão dupla. O protótipo da função deverá ser
#o que se apresenta de seguida, em que "n" é o número de elementos do array:

#double average(double *array, unsigned int n);

#Mapa de registos:
# $t1 : i = n
# $t2 : &(array[i-1]*8)
# $t3 : aux (operaçoes para i)

	.data
x0:	.double 0.0

	.text
	.globl average	

average:
	la $t0, x0		# $t0 = &x0
	l.d $f0, 0($t0)		# sum = (double)x0;
	
	move $t0, $a0		# $t0 = &(array)
	move $t1, $a1		# i = n
	
for:
	ble $t1, $0, endFor	
	addi $t3, $t1, -1	# aux = i-1
	sll $t3, $t3, 3		# aux = (i-1)*8
	addu $t2, $t0, $t3	# $t2 = &(array[i-1])
	l.d $f2, 0($t2)		# $f2 = (double)array[i-1]
	add.d $f0, $f0, $f2	# sum += array[i-1]
	addi $t1, $t1, -1	# i--
	j for
	
endFor:
	mtc1 $a1, $f4		# mandar para o coprocessador
	cvt.d.w $f4, $f4	# conversao de inteiro para double -> $f4 = (double) $f4
	div.d $f0, $f0, $f4
	jr $ra			# termina a sub-rotina