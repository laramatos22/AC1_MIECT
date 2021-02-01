#int abs(int val)
#{
#	if(val < 0)
#		val = -val;
#	return val;
#}

	.text
	.globl absolute
	
absolute:
	move $v0, $a0		# $v0 = val = $a0
	
if:
	bge $v0, 0, endIf	# if(val < 0)
	mul $v0, $v0, -1	#	val = -val;
	
endIf:
	jr $ra			# termina o programa