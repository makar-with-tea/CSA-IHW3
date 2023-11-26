# a0 - строчка источник, a1 - n1, a2 - n2; возвр. строку в a0
reverse_part:
    mv t0 a1        # Счетчик
    add t2 a0 a1 # с начала интервала
    add t3 a0 a2 # с конца интервала
loop_reverse:
    bge t2 t3 end_reverse
    lb      t1 (t2)   # Загрузка символа для сравнения
    lb      t4 (t3)
    sb t1(t3)
    sb t4(t2)
    addi    t0 t0 1		# Счетчик символов увеличивается на 1
    addi    t2 t2 1		# Берется следующий символ
    addi    t3 t3 -1          # а тут наоборот предыдущий
    #li a7 4
    #ecall
    blt t2 t3 loop_reverse
end_reverse:
    ret