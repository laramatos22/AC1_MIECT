# MIX DE FUNÇÕES FEITAS DO GUIAO 7 

# ----------------------------------------------- FUNÇÃO ATOI ----------------------------------------------- #

#converte para um inteiro de 32 bits a quantidade representada por uma
#string numérica em que cada carater representa o código ASCII de
#um dígito decimal 

#unsigned int atoi(char *s){
#	unsigned int digit, res = 0;
#	while( (*s >= '0') && (*s <= '9') ) {
#		digit = *s++ - '0';
#		res = 10 * res + digit;
#	}
#	return res;
#}

# Mapa de registos:
# $v0 : res
# $a0 : s -> argumento da função
# $t0 : *s
# $t1 : digit

atoi:
	li $v0, 0			# res = 0;
	
atoi_while:
	lb $t0, 0($a0)			# load byte: instrução de leitura, cria o ponteiro *s
					# $t0 = *s
	blt $t0, '0', atoi_endWhile	# while( (*s >= '0') ...
	bgt $t0, '9', atoi_endWhile	# ... && (*s <= '9') )			
	
	sub $t1, $t0, '0'		# digit = *s - '0';
	addiu $a0, $a0, 1		# s++;
	
	mul $v0, $v0, 10		# res = res * 10;
	add $v0, $v0, $t1		# res = 10 * res + digit;
	
	j atoi_while
	
atoi_endWhile:
	jr $ra				# termina a sub-rotina e faz return de res
	
# ------------------------------------------ FUNÇÃO STRLEN ------------------------------------------------- #

#  determina e devolve a dimensão de uma string

#int strlen(char *s){
#	int len=0;
#	while(*s++ != '\0')
#		len++;
#	return len;
#}

# Mapa de registos:
# $a0 : str -> argumento da função
# $t0 : *s
# $t1 : len

strlen:
	li $t1, 0			# len = 0;
	
strlen_while:
	lb $t0, 0($a0) 			# $t0 = char[0] da str -> criação do ponteiro q aponta para str
	addiu $a0, $a0, 1		# s++
	beq $t0, '\0', strlen_endWhile	# while(*s++ != '\0')
	addi $t1, $t1, 1		# len++;
	j strlen_while			#
	
strlen_endWhile:
	move $v0, $t1			# return len;
	jr $ra				# termina a sub-rotina
	
# ----------------------------------------- FUNÇÃO EXCHANGE ------------------------------------------------ #

# troca a posição de dois registos

# void exchange (char *c1, char *c2)
# {
#	char aux = *c1;
#
#	*c1 = *c2;
#	*c2 = aux,
# }

# Mapa de registos:
# $a0 : *c1 (1º argumento da sub-rotina)
# $a1 : *c2 (2º argumento da sub-rotina)
# $t0 : aux
# $t1 : variavel temporária temp

exchange:
	lb $t0, 0($a0)			# char aux = *c1;
	lb $t1, 0($a1)			# temp = *c2;
	
	sb $t1, 0($a0)			# $t1 = $a0 -> *c1 = *c2;
	sb $t0, 0($a1)			# $t0 = $a1 -> *c2 = aux;
	
	jr $ra				# termina a sub-rotina
	
#---------------------------------------------- FUNÇÃO STRREV ------------------------------------------------- #

# inverte o conteúdo de uma string

#char *strrev(char *str){
#	char *p1 = str;
#	char *p2 = str;
#	while(*p2 != '\0')
#		p2++;
#	p2--;
#	while( p1 < p2 ) {
#		exchange(p1, p2);
#		p1++;
#		p2--;
#	}
#	return str;
#}

# Mapa de registos:
# $a0 -> $s0 : str (argumento da sub-rotina)
# $s1 : p1 (registo callee-saved)
# $s2 : p2 (registo callee_saved)

strrev:
	addiu $sp, $sp, -16			# reserva espaço na stack
	sw $ra, 0($sp)				# salvaguarda o endereço de retorno
	sw $s0, 4($sp)				# guarda os valores dos registos
	sw $s1, 8($sp)				# $s0, $s1 e $s2
	sw $s2, 12($sp)
	
	move $s0, $a0				# $s0 = $a0 = str
	move $s1, $a0				# p1 = str
	move $s2, $a0				# p2 = str
	
strrev_while1:
	lb $s3, 0($s2)				# criação do ponteiro *p2
	beq $s3, '\0', strrev_endWhile1		# while(*p2 != '\0') {
	addi $s2, $s2, 1			# p2++;
	j strrev_while1				# }
	
strrev_endWhile1:
	sub $s2, $s2, 1				# p2--;
	
strrev_while2:
	bge $s1, $s2, strrev_endWhile2		# while( p1 < p2 ) {
	
	move $a0, $s1				# $a0 : p1 -> 1º argumento de exchange
	move $a1, $s2				# $a1 : p2 -> 2º argumento de exchange
	jal exchange				# exchange(p1, p2);
	
	addi $s1, $s1, 1			# p1++;
	sub $s2, $s2, 1				# p2--;
	
	j strrev_while2
	
strrev_endWhile2:
	move $v0, $s0				# return str;
	
	lw $ra, 0($sp)				# repõe o endereço de retorno
	lw $s0, 4($sp)				# repõe os valore dos registos
	lw $s1, 8($sp)				# $s0, $s1 e $s2
	lw $s2, 12($sp)
	
	addiu $sp, $sp, 16			# liberta o espaço da stack
	
	jr $ra					# termina a sub-rotina

# -------------------------------------------- FUNÇÃO STRCPY ------------------------------------------------- #

# copia uma string

#char *strcpy(char *dst, char *src){
#	int i=0;
#	do {
#		dst[i] = src[i];
#	} while(src[i++] != '\0');
#	return dst;
#}

# Mapa de registos:
# $a0 -> $s0 : dst (1º argumento da função)
# $a1 -> $s1 : src (2º argumento da função)
# $t0 : i
# $t1 : dst + i
# $t2 : src + i
# $t3 : dst[i]
# $t4 : src[i]

strcpy:
	addiu $sp, $sp, -8		# reserva espaço na stack
	sw $s0, 0($sp)			# guarda valor do registo $s0
	sw $s1, 4($sp)			# guarda valor do registo $s1
	
	li $t0, 0			# i=0
	move $s0, $a0			# $s0 = $a0 = dst
	move $s1, $a1 			# $s1 = $s1 = src
	
strcpy_do:
	addu $t1, $s0, $t0		# $t1 = dst + i
	addu $t2, $s1, $t0		# $t2 = src + i
	lb $t3, 0($t2)			# $t3 = src[i] -> load byte
	sb $t3, 0($t1)			# $t3 = dst[i] = src[i] -> store byte
	addi $t0, $t0,1			# i++;
	bne $t3, '\0', strcpy_do	# while(src[i++] != '\0');
	
	move $v0, $s0			# return dst;
	
	lw $s0, 0($sp)			# repõe os valores de 
	lw $s1, 4($sp)			# $s0 e $s1
	addiu $sp, $sp, 8		# liberta o espaço na stack
	
	jr $ra				# termina a sub-rotina	
	
	

