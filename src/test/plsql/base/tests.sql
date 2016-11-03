
-- >> (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL

имя_переменной1 тип_переменной1; -- --------------------- Объявление переменной заданного типа
имя_переменной2 тип_переменной2 := значение2; -- -------- Объявление переменной с (иннициалаизацией) присвоением значения
имя_константы CONSTANT тип_константы := значение; -- ---- Объявление к онстанты с иннициалаизацией

integer1 INTEGER := 100; -- ----------------------------- целое число
num1 NUMBER := 50.55; -- -------------------------------- число с плавающей точкой
char1 CHAR2(10) := 'Hello'; -- -------------------------- строка постоянной длины
char2 VARCHAR2(100) := 'Hello my friend'; -- ------------ строка переменной длины
date1 DATE := TO_DATE('20.09.1978', 'DD.MM.YYYY'); -- --- дата/время
boolean1 BOOLEAN := TRUE; -- ---------------------------- логическое значение


TYPE имя_типа_записи IS RECORD(поле1 тип1, поле2 тип2,...); -- ----------------- Объявление нового типа Записи
TYPE имя_типа_массива IS VARRAY(макс_размер) OF тип_элемента; -- --------------- Объявление нового типа Массива
TYPE имя_типа_коллекции IS TABLE OF тип_элемента INDEX BY BINARY_INTEGER; -- --- Объявление нового типа Таблицы (коллекции)
имя_переменной1 имя_типа_записи;
имя_переменной2 имя_типа_массива;
имя_переменной3 имя_типа_коллекции;

TYPE TEmployeeObject IS RECORD(ename VARCHAR2(10), job VARCHAR2(10)); -- ------- тип Запись
lr_emp TEmployeeObject;
lr_emp.ename := 'SCOTT';
lr_emp.job := 'ANALYST';

TYPE TStringArray IS VARRAY(100) OF VARCHAR2(10);
la_elements TStringArray;
la_elements(1) := 'Первый элемент';
la_elements(2) := 'Второй элемент';
la_elements(3) := 'Третий элемент';
--DBMS_OUTPUT.PUT_LINE(la_elements(1));

TYPE TStringCollection IS TABLE OF VARCHAR2(10) INDEX BY BINARY_INTEGER; -- ---- тип Таблица (коллекция)
la_elements TStringCollection;
la_elements(1) := 'Первый элемент';
la_elements(2) := 'Второй элемент';
la_elements(3) := 'Третий элемент';
l_index := la_elements.FIRST;
LOOP
    --DBMS_OUTPUT.PUT_LINE(la_elements(l_index));
    l_index := la_elements.NEXT(l_index);
    EXIT WHEN l_index IS NULL;
END LOOP;


имя_переменной1 тип_переменной1; -- --------------
имя_переменной2 имя_переменной1%TYPE; -- --------- Объявление переменной с типом другой переменной (атрибуты типизации)
имя_переменной3 имя_таблицы1.имя_поля%TYPE; -- --- Объявление переменной с типом поля таблицы (атрибуты типизации)
имя_переменной4 имя_таблицы2%ROWTYPE; -- --------- Объявление переменной, соответствующей строке таблицы (атрибуты типизации)

l_name emp.ename%TYPE;
l_job emp.job%TYPE;
lr_emp emp%ROWTYPE;
lr_emp.ename := 'JONES';
lr_emp.job := 'MANAGER';


