#student *max(student *st, int ns, float *media)
#{
#	student *p;
#	student *pmax;
#	float max_grade = -20.0;
#	float sum = 0.0;
#
#	for(p = st; p < (st + ns); p++)
#	{
#		sum += p->grade;
#		if(p->grade > max_grade)
#		{
#			max_grade = p->grade;
#			pmax = p;
#		}
#		}
#	*media = sum / (float)ns;
#	return pmax;
#}

	.data

	.eqv id_number, 0
	.eqv first_name, 4
	.eqv last_name, 22
	.eqv grade, 40
	
max_grade: .float -20.0
sum:	.float 0.0

	.text
	.globl max
	
max:
	la $t0, sum			# $t0 = &sum
	l.s $f4, 0($t0)			# sum = 0.0
	
	la $t0, max_grade		# $t0 = max_grade
	l.s $f6, 0($t0)			# max_grade = -20.0
	
	move $t2, $a2			# $t2 = &media;
	move $t0, $a0			# $t0 = &st = *p;
	move $t4, $a1			# $t4 = ns;
	
	mul $a1, $a1, 44		# ns = ns * 44;
	addu $t1, $t0, $a1		# $t1 = &(st[ns])
	li $t3, 0			# pmax = 0;
	
for:
	bge $t0, $t1, endFor		# for(p = st; p < (st + ns); p++)
	l.s $f8, grade($t0)		# $f8 = p.grade
	add.s $f4, $f4, $f8		# sum += p->grade;
	
if:
	c.lt.s $f8, $f6			# if(p->grade > max_grade)
	bc1t endIf			# branch if true
	mov.s $f6, $f8			# max_grade = p->grade;
	move $t3, $t0			# pmax = p;
	
endIf:
	addi $t0, $t0, 44		# p++;
	j for
	
endFor:
	mtc1 $t4, $f10
	cvt.s.w $f10, $f10
	div.s $f10, $f4, $f10		# $f10 = sum / (float)ns;
	s.s $f10, 0($t2)		# *media = sum / (float)ns;
	move $v0, $t3			# return max;
	
	jr $ra				# termina a sub-rotina	

