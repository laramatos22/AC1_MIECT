#char *strcpy(char *dst, char *src)
#{
#	int i=0;
#	do
#	{
#		dst[i] = src[i];
#	} while(src[i++] != '\0');
#	return dst;
#}
	
	.text
	.globl strcpy

strcpy:
	li $t0, 0			# int i=0;
	move $t2, $a0			# dst -> $a0 -> $t2
	
do:
	addi $t0, $t0, 1		# i++
	addu $a0, $a0, $t0		# $a0 = &(dst[i])
	lb $t1, 0($a1)			# $t1 = src[i]
	sb $t1, 0($a0)			# dst[i] = src[i]
	
while:
	bne $t1, '\0', do		# while(src[i++] != '\0');
	
	move $v0, $t2			# return dst;	
	
	jr $ra				# termina a sub-rotina