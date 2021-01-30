#// Converte o digito "v" para o respetivo código ASCII
#
#char toascii(char v)
#{
#	v += '0';			v -> $a0 -> $v0
#	if( v > '9' )
#		v += 7; // 'A' - '9' - 1
#	return v;
#}

	.text
	.globl toascii
	
toascii:
	addi $v0, $a0, '0'		# v += '0';
	
if:
	ble $v0, '9', endIf		# if( v > '9' )
	addi $v0, $v0, 7		# v += 7;
	
endIf:
	jr $ra				# termina o programa