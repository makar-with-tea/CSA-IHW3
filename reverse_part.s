# функция для переворота подстроки
# a0 - сама строка, a1 - n1, a2 - n2; возвращает строку в регистре a0
reverse_part:
    mv t0 a1        # Счетчик
    add t2 a0 a1 # с начала интервала
    add t3 a0 a2 # с конца интервала
loop_reverse:
    bge t2 t3 end_reverse
    lb      t1 (t2)  
    lb      t4 (t3)
    # символы меняются местами
    sb t1(t3)
    sb t4(t2)
    addi    t0 t0 1		# Счетчик символов увеличивается на 1
    addi    t2 t2 1		# Берется следующий символ с начала подстроки
    addi    t3 t3 -1          # И, наоборот, предыдущий - с конца подстроки
    #li a7 4
    #ecall
    blt t2 t3 loop_reverse
end_reverse:
    ret
