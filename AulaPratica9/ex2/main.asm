# EXERCICIO 2

	.data
	.eqv print_double, 3
	.eqv read_double, 7
	.text
	.globl main
	
# Mapa de registos:
# $a0: argumentos
# $v0: resultados
	
main:
	addiu $sp, $sp, -4		# reservar espaço na stack
	sw $ra, 0($sp)			# guardar valor de $ra
	
	li $v0, read_double
	syscall				# ft = read_double();
	
	jal f2c				# f2c(ft)
	
	move $a0, $v0			# Mover o resultado de $v0 para $a0
	li $v0, print_double
	syscall				# print_double( f2c(double ft) );
	
	lw $ra, 0($sp)			# atualiza o valor de $a0
	addiu $sp, $sp, 4		# liberta o espaço utilizado
	
	jr $ra				# termina o programa
	
	

