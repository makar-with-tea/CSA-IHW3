.include "macro-syscalls.m"

# Чтение текста из файла, задаваемого в диалоге, в буфер фиксированного размера
.eqv    NAME_SIZE 256	# Размер буфера для имени файла
.eqv    TEXT_SIZE 512	# Размер буфера для текста

.data
prompt:         .asciz "Input file path: "     # Путь до читаемого файла
er_name_mes:    .asciz "Incorrect file name\n"
er_read_mes:    .asciz "Incorrect read operation\n"
empty: .asciz ""
yes: .asciz "Y"
answer: .space 2
file_name:      .space	NAME_SIZE		# Имя читаемого файла
strbuf:	.space TEXT_SIZE			# Буфер для читаемого текста


.text

print_str("Show results in the console? Y/N \n")
str_get(answer, 2)
la a0 yes
la a1 answer
jal compare_char
mv s1 a0 # булевое значение: надо ли выводить результат в консоль
newline


print_str ("Input path to file for reading: ") # Вывод подсказки
# Ввод имени файла с консоли эмулятора
str_get(file_name, NAME_SIZE)
load_file_macro(file_name, TEXT_SIZE)
mv s3 a0
mv s6 a1  
beqz s1 input_n1 # при флаге 0 пропускаем вывод строки на экран

print_str("Original string: ")
mv a0 s3
li a7 4
ecall
newline

# Получаем от пользователя индексы начала и конца поворачивоемой строки
input_n1:
print_str("Input first index (n1). It should satisfy the inequality: 0 <= n1 < length of file info \n")
read_int(s1)
bltz s1 incorrect_n1
bge s1 s6 incorrect_n1
input_n2:
print_str("Input second index (n2). It should satisfy the inequality: n1 <= n2 < length of file info \n")
read_int(s2)
bltz s2 incorrect_n2
blt s2 s1 incorrect_n2
b end_input_n

# n1 не удовлетворяет ограничениям
incorrect_n1:
print_str("Incorrect number! Try again!\n")
b input_n1

# n2 не удовлетворяет ограничениям
incorrect_n2:
print_str("Incorrect number! Try again!\n")
b input_n2

end_input_n:
# после ввода индексов применяем подпрограмму переворота подстроки
reverse_part_macro(s3, s1, s2)
mv s3 a0


# Сохранение прочитанного файла в другом файле
print_str ("Input path to file for writing: ")
str_get(file_name, NAME_SIZE) # Ввод имени файла с консоли эмулятора
write_string_to_file_macro(s3, s6, file_name)  

beqz s1 final # при флаге 0 пропускаем вывод строки на экран
print_str("Final string: ")
mv a0 s3
li a7 4
ecall

final:
# Завершение программы
exit
   
.include "reverse_part.s"
.include "write_string_to_file.s"
.include "load_file.s"
.include "compare_char.s" 
