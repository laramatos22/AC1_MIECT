# EXERCICIO 1

	.data
	.eqv read_int, 5
	.eqv print_float, 2
x:	.float 2.59375
x1:	.float 0.0
	.text
	.globl main

#Considere o seguinte programa que lê um valor inteiro, multiplica-o por uma constante real
#e apresenta o resultado.

#int main(void)
#{
#	float res;
#	int val;
#	do
#	{
#		val = read_int();
#		res = (float)val * 2.59375;
#		print_float( res );
#	} while(res != 0.0);
#	return 0;
#}

# Mapa de registos:
# $f0 -> res
# $t0 -> val

# Para passagem de argumentos usa-se os registos $f12 e $f14

main:
	
do:
	li $v0, read_int		
	syscall			# val = read_int();
	
	mtc1 $v0, $f4		# mandar para o coprocessador
	cvt.s.w $f4, $f4	# conversao -> f4 = (float) f4 
	
	l.s $f2, x		# $f2 = x
	mul.s $f0, $f4, $f2	# res = (float)val * 2.59375;
	
	li $v0, print_float
	mov.s $f12, $f0		# mover o resultado para o registo $f12
	syscall			# print_float( res );
	
	l.s $f6, x1		# $f6 = x1
	
	c.eq.s $f0, $f6		# while(res != 0.0);
	
	bc1f do			# jump para do
	
endDo:
	li $v0, 0		# return 0;
	
	jr $ra			# termina o programa
	