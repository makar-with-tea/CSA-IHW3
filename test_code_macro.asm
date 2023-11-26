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
load_file_macro(a, 10)
mv s1 a0
print_str("File a.txt: ")
# текущая строка - в регистре a0
li a7 4
ecall
li t1 1 # n1 = 1
li t2 3 # n2 = 3
reverse_part_macro(s1, t1, t2)
print_str("\nString after reversing: ")
li a7 4
ecall

mv s1 a0
li t1 10
write_string_to_file_macro(s1, t1, d)


load_file_macro(d, 10)
mv s1 a0
print_str("\nFile d.txt: ")
li a7 4
ecall

load_file_macro(_b, 26)
mv s1 a0
print_str("\nFile b.txt: ")
# текущая строка - в регистре a0
li a7 4
ecall
mv t0 a0
li t1 1 # n1 = 1
li t2 25 # n2 = 25
reverse_part_macro(t0, t1, t2)
mv s1 a0
print_str("\nString after reversing: ")
li a7 4
ecall

load_file_macro(c, 25)
mv s1 a0
print_str("\nFile c.txt: ")
# текущая строка - в регистре a0
li a7 4
ecall
li t1 4
li t2 8
reverse_part_macro(s1, t1, t2)
print_str("\nString after reversing: ")
li a7 4
ecall

li t1 25
write_string_to_file_macro(s1, t1, c)
load_file_macro(c, 25)
mv s1 a0
print_str("\nFile c.txt: ")
# текущая строка - в регистре a0
li a7 4
ecall

exit

.include "reverse_part.s"
.include "write_string_to_file.s"
.include "load_file.s"
