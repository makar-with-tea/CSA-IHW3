# подпрограмма для сравнения двух символов
# a0 - первый символ, a1 - второй символ
compare_char:
	lb t0(a0)
	lb t1(a1)
	beq t0 t1 true
	false:
	li a0 0
	ret
	true:
	li a0 1
	ret
