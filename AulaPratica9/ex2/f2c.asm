# EXERCICIO 2

	.data
	.globl f2c

# A conversão de uma temperatura expressa em graus Fahrenheit para graus Celsius é
# efectuada de acordo com a seguinte fórmula:

# °C = 5 / 9 * (°F - 32)


f2c:
	li $t0, 5		# $t0 = 5
	li $t1, 9		# $t1 = 9
	li $t2, 32		# $t2 = 32
	
	mtc1 $t0, $f0		# mandar $t0 para o coprocessador
	mtc1 $t1, $f2		# mandar $t1 para o coprocessador
	mtc1 $t2, $f4		# mandar $t2 para o coprocessador
	
	cvt.d.w $f0, $f0	# passar o inteiro $f0 para o formato double
	cvt.d.w $f2, $f2	# passar o inteiro $f2 para o formato double
	cvt.d.w $f4, $f4	# passar o inteiro $f4 para o formato double
	
	# Função: °C = 5 / 9 * (°F - 32)
	
	sub.d $f6, $f12, $f4	# $f6 = ft - 32
				# ft está como argumento, por isso usamos diretamente $f12 ou $f14
	
	div.d $f8, $f0, $f2	# $f8 = 5 / 9
	mul.d $f10, $f8, $f6	# $f10 = $f8 * $f6
				# °C = 5 / 9 * (°F - 32)
	
	jr $ra			# termina a sub-rotina
	
	
	
	
	
