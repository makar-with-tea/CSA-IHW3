.include "macro-syscalls.m"

# ������ ������ �� �����, ����������� � �������, � ����� �������������� �������
.eqv    NAME_SIZE 256	# ������ ������ ��� ����� �����
.eqv    TEXT_SIZE 512	# ������ ������ ��� ������

.data
prompt:         .asciz "Input file path: "     # ���� �� ��������� �����
er_name_mes:    .asciz "Incorrect file name\n"
er_read_mes:    .asciz "Incorrect read operation\n"
empty: .asciz ""
yes: .asciz "Y"
answer: .space 2
file_name:      .space	NAME_SIZE		# ��� ��������� �����
strbuf:	.space TEXT_SIZE			# ����� ��� ��������� ������


.text

print_str("Show results in the console? Y/N \n")
str_get(answer, 2)
la a0 yes
la a1 answer
jal compare_char
mv s1 a0 # ������� ��������: ���� �� �������� ��������� � �������
newline


print_str ("Input path to file for reading: ") # ����� ���������
# ���� ����� ����� � ������� ���������
str_get(file_name, NAME_SIZE)
load_file_macro(file_name, TEXT_SIZE)
mv s3 a0
mv s6 a1  
beqz s1 input_n1 # ��� ����� 0 ���������� ����� ������ �� �����

print_str("Original string: ")
mv a0 s3
li a7 4
ecall
newline

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

incorrect_n1:
print_str("Incorrect number! Try again!\n")
b input_n1

incorrect_n2:
print_str("Incorrect number! Try again!\n")
b input_n2

end_input_n:
reverse_part_macro(s3, s1, s2)
mv s3 a0


# ���������� ������������ ����� � ������ �����
print_str ("Input path to file for writing: ")
str_get(file_name, NAME_SIZE) # ���� ����� ����� � ������� ���������
write_string_to_file_macro(s3, s6, file_name)  

beqz s1 final # ��� ����� 0 ���������� ����� ������ �� �����
print_str("Final string: ")
mv a0 s3
li a7 4
ecall

final:
# ���������� ���������
exit
   
.include "reverse_part.s"
.include "write_string_to_file.s"
.include "load_file.s"
.include "compare_char.s" 
