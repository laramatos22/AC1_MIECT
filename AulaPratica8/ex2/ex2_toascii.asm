# sub rotina toascii

#// Converte o digito "v" para o respetivo código ASCII
#char toascii(char v)
#{
#	v += '0';
#	if( v > '9' )
#		v += 7; 	// 'A' - '9' - 1
#return v;
#}

toascii:			# char toascii(char v)
	addi $a0, $a0, 0	# v += '0';
if:
	ble $a0, '9', endif	# if( v > '9' )
	addi $a0, $a0, 7	# v += 7;
endif:
	move $v0, $a0		# return v;
	jr $ra			# termina o programa