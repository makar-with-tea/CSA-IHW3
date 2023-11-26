.include "macro-syscalls.m"

.eqv    NAME_SIZE 256	# Размер буфера для имени файла
.eqv    TEXT_SIZE 512	# Размер буфера для текста


.data
er_name_mes:    .asciz "Incorrect file name\n"
er_read_mes:    .asciz "Incorrect read operation\n"
empty: .asciz
a:    .asciz "data/a.txt"
_b: .asciz "data/b.txt"
c: .asciz "data/c.txt"
d: .asciz "data/d.txt"
file_name:      .space	NAME_SIZE		# Имя читаемого файла
strbuf:	.space TEXT_SIZE			# Буфер для читаемого текста


# на момент начала исполнения программы в каталоге хранятся файлы a.txt, b.txt, c.txt
.text
la a0 a
li a1 10 # длина текста в файле a.txt
jal load_file
mv s1 a0
print_str("File a.txt: ")
# текущая строка - в регистре a0
li a7 4
ecall
li a1 1 # n1 = 1
li a2 3 # n2 = 3
jal reverse_part
print_str("\nString after reversing: ")
li a7 4
ecall

li a1 10
la a2 d
jal write_string_to_file

la a0 d
li a1 10 # длина текста в файле a.txt
jal load_file
mv s1 a0
print_str("\nFile d.txt: ")
li a7 4
ecall

la a0 _b
li a1 26 # длина текста в файле b.txt
jal load_file
mv s1 a0
print_str("\nFile b.txt: ")
# текущая строка - в регистре a0
li a7 4
ecall
li a1 1 # n1 = 1
li a2 25 # n2 = 25
jal reverse_part
mv s1 a0
print_str("\nString after reversing: ")
li a7 4
ecall

la a0 c
li a1 25 # длина текста в файле c.txt
jal load_file
mv s1 a0
print_str("\nFile c.txt: ")
# текущая строка - в регистре a0
li a7 4
ecall
li a1 4 # n1 = 4
li a2 8 # n2 = 8
jal reverse_part
print_str("\nString after reversing: ")
li a7 4
ecall

li a1 25
la a2 c
jal write_string_to_file

la a0 c
li a1 25 # длина текста в файле c.txt
jal load_file
mv s1 a0
print_str("\nFile c.txt: ")
# текущая строка - в регистре a0
li a7 4
ecall

exit


.include "reverse_part.s"
.include "write_string_to_file.s"
.include "load_file.s"
