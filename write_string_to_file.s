# Подпрограмма для записи строки в файл
# a0 - адрес буфера записываемого файла, a1 - размер записываемой порции из регистра, a2 - адрес названия файла
write_string_to_file:
    mv t3 a0
    mv t6 a1
    open_from_reg(a2, WRITE_ONLY)
    li		t1 -1			# Проверка на корректное открытие
    beq		a0 t1 er_name_write	# Ошибка открытия файла
    mv   	t0 a0       	# Сохранение дескриптора файла
    # Запись информации в открытый файл
    li   a7, 64       		# Системный вызов для записи в файл
    mv   a0, t0 			# Дескриптор файла
    mv   a1, t3  			# Адрес буфера записываемого текста
    mv   a2, t6    			# Размер записываемой порции из регистра
    ecall             		# Запись в файл
    close(t0)
    ret
 
er_name_write:
    # Сообщение об ошибочном имени файла
    la		a0 er_name_mes
    li		a7 4
    ecall
    exit
