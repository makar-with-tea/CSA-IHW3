# Макаревич Мария, БПИ228
Индивидуальное домашнее задание 3 по дисциплине "Архитектура вычислительных систем".
**Работа выполнена на 9.5 баллов.**
## Вариант 1. Условие:
ASCII–строка — строка, содержащая символы таблицы кодировки ASCII. (https://ru.wikipedia.org/wiki/ASCII). Размер строки может быть достаточно большим, чтобы вмещать многостраничные тексты, например, главы из книг, если задача связана с использованием файлов или строк, порождаемых генератором случайных чисел. Тексты при этом могут не нести смыслового содержания. Для обработки в программе предлагается использовать данные, содержащие символы только из первой половины таблицы (коды в диапазоне 0–12710), что связано с использованием кодировки UTF-8 в ОС Linux в качестве основной. Символы, содержащие коды выше 12710, должны отсутствовать во входных данных кроме оговоренных специально случаев.

Разработанная программа должна:
- читать обрабатываемый текст из файла
- загружать полученные результаты также в файл.
- Ввод имен входного и выходного файлов должен осуществляться с использованием консоли.

Аналогичным образом осуществляет ввод остальных параметров, необходимых для выполнения программы.

Индивидуальное условие варианта: Разработать программу, которая «переворачивает» заданную позициями N1–N2 часть ASCII–строки символов (N1, N2 вводятся как параметры). Преобразование осуществляется внутри введенной строки.
## Критерии на 4-5 баллов
- Приведено решение программы на ассемблере. Программа из файла читает данные. Результаты записываются в другой файл.
- Все изменяемые параметры программы вводятся с консоли.
- В программе присутствуют комментарии, поясняющие выполняемые ей действия.
- Обработка данных, полученных из файла, сформирована в виде отдельной подпрограммы.
- В подкаталоге данных присутствуют файлы, используемые для тестирования.
- Буфер для текста программы имеет фиксированный размер размером не менее 4096 байт, допускающий ввод без искажений только тексты, ограниченные этим размером.
- При чтении файла размером, превышающим размер буфера, не должно происходить падения программы. Программа должна корректно обработать введенный «урезанный» текст.
- Сформирован отчет с результатами тестовых прогонов и описанием используемых опций компиляции, проведенных модификаций ассемблерной программы.

Реализованы ввод данных с клавиатуры, считывание данных из файла и вывод данных на дисплей. Комментарии в программе присутствуют. Реализованы подпрограммы:

- load_file - чтение текста из файла с помощью буфера ограниченного размера (см. критерии на 6-7 баллов)
- reverse_part - "переворот" части строки, ограниченной заданными индексами
- write_string_to_file - запись строки в файл
- compare_char - сравнение двух символов

В каталоге "data" присутствуют используемые для тестирования файлы.

Требование для буфера не выполняется, так как реализован другой вариант чтения информации из файла (см. критерии на 6-7 баллов)

Тесты программы присутствуют в папке [tests](tests). В конце отчета приведены скриншоты, показывающие корректную работу программы на тестах 1-4.
## Критерии на 6-7 баллов
- Внутри функций необходимо использовать регистровые или локальные (при нехватке) переменные.
- Для чтения текста из файла реализовать буфер ограниченного размера, равного 512 байтам. При этом программа должна читать файлы размером до 10 килобайт.
- Реализовать ввод исходных данных, их обработку, вывод результатов через соответствующие подпрограммы. Подпрограммы должны получать необходимые им данные через параметры в соответствии с принятым соглашением о передаче параметров.
- Возвращаемые из подпрограмм значения должны возвращаться через параметры в соответствии с общепринятыми соглашениями.

Во всех подпрограммах использованы регистровые переменные в регистрах t0-t7.

Буфер размером 512 байтов реализован.

Ввод, вывод и обработка данных реализованы через подпрограммы. Также реализована передача аргументов через параметры во всех вышеуказанных подпрограммах.

- В load_file через параметры подаются имя и размер файла, а возвращаются через параметры адрес начала буфера, в который считывался текст, и его длина
- В reverse_part через параметры подаются начальная строка и индексы переворачиваемой подстроки, а возвращается через параметр сама строка
- Во write_string_to_file через параметры подаются адрес начала буфера, размер и название файла, а возвращаются через параметры дескриптор, адрес начала буфера и размер считываемой порции
- В compare_char через параметры подаются два символа для сравнения, а возвращается через параметр булевое значение - результат этого сравнения
## Критерии на 8 баллов
- Добавить в программу возможность дополнительного вывода результатов на консоль. Выводить или нет, решает пользователь, отвечая «Y» или «N» на соответствующий вопрос компьютерной программы. Данная возможность полезна при быстром отображении коротких данных. Вывод программы при этом должен полностью соответствовать выводу результатов в файл.
- Реализовать дополнительную тестовую программу, которая осуществляет многократный вызов процедур, обеспечивающих ввод файлов, их обработку и вывод для различных исходных данных, расположенных в каталоге с исходными тестовыми данными.

Возможность вывода результатов на консоль добавлена.

Отдельная тестовая программа создана: [test_code.asm](test_code.asm), в ней рассмотрены 3 файла, отличных от хранящихся в папке tests. Для них применяются подпрограммы чтения, "переворота" части строки и сохранения. Ниже в секции "Тесты" приведены скриншоты выполнения данной программы.

## Критерии на 9 баллов
- Добавить в программу использование макросов для реализации ввода, вывода, и обработки данных. Макросы должны поддерживать повторное использование с различными массивами и другими параметрами. Внутри макросов должны быть расположены вызовы соответствующих подпрограмм.
- Реализовать дополнительную тестовую программу, которая вызывает выполняемые подпрограммы через макросы, реализуя ту же функциональность, что и предыдущая тестовая программа. Это должна быть дополнительная тестовая программа.

Макросы были добавлены в программу. Дополнительная тестовая программа: [test_code_macro.asm](test_code_macro.asm). Она является аналогом предыдущей тестовой программы, однако использет макросы.

## Критерии на 10 баллов
- Программа должна быть разбита на несколько единиц компиляции. При этом подпрограммы ввода–вывода должны составлять унифицированные модули, используемые повторно как в программе, осуществляющей ввод исходных данных, так и в программе, осуществляющей тестовое покрытие.
- Макросы должны быть выделены в отдельную автономную библиотеку.
- Использовать дополнительные графические диалоговые окна для ввода и отображения диалогов, предоставляемые симулятором RARS.

Программа разбита на несколько единиц компиляции. Тестирующая программа test_code.asm использует те же функции, что и основная программа. Макросы выделены в отдельную библиотеку macro-syscalls.m.
Дополнительные графические диалоговые окна не реализованы.
## Тесты
Корректность работы программы подтверждается прохождением 4 тестов из папки tests, а также верными результатами работы тестирующей программы на 6 других тестах из [tests.asm](code/tests.asm).

Скриншоты работы программы на тестах 1-4:
![image](https://github.com/makar-with-tea/CSA-IHW3/assets/79705001/33bfa2c1-9914-4437-a50b-4ea20869c596)
![image](https://github.com/makar-with-tea/CSA-IHW3/assets/79705001/da72b98f-2854-45c4-a25e-7757c8a4f772)
![image](https://github.com/makar-with-tea/CSA-IHW3/assets/79705001/cfc3aa38-43d7-4a28-a711-c4b9ee62d2bc)
![image](https://github.com/makar-with-tea/CSA-IHW3/assets/79705001/9b62b766-2c06-41d0-80b1-2fb29165fcd9)


Скриншот работы тестирующей программы:
![image](https://github.com/makar-with-tea/CSA-IHW3/assets/79705001/d8336901-44f5-425c-82e9-66d498aba548)

Скриншот работы тестирующей программы для макросов:
![image](https://github.com/makar-with-tea/CSA-IHW3/assets/79705001/134c185c-764d-41ab-92c7-9d2d45ba0760)



## Котики
![image](https://github.com/makar-with-tea/CSA-IHW3/assets/79705001/8da1c4ed-0bcb-495f-a4d4-5407edd440ef)

