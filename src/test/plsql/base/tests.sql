
-- >> (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL

-- ---------------------------------------------------------------------------------------------------------------------[ 1-4 ]
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



-- ---------------------------------------------------------------------------------------------------------------------[ 2-4 ]
CURSOR курсор1 IS SELECT поле1, поле2 FROM таблица WHERE условия_отбора; -- --- Объявление явного курсора
TYPE имя_типа_курсора IS REF CURSOR; -- --------------------------------------- Объявление типа-указателя
курсор2 имя_типа_курсора; -- -------------------------------------------------- Объявление переменной курсора

OPEN курсор1; -- -------------------------------------------------------------- Открытие (явного) курсора
LOOP
  FETCH курсор1 INTO переменная1, переменная2; -- ----------------------------- Получение данных текущей записи
  EXIT WHEN курсор1%NOTFOUND; -- ---------------------------------------------- Записи в курсоре закончились - выход из цикла
END LOOP;
FOR запись IN курсор1 LOOP
  -- запись.поле1, запись.поле2
END LOOP;
CLOSE курсор1; -- ------------------------------------------------------------- Закрыть (явный) курсор

OPEN курсор2 FOR SELECT поле1, поле2 FROM таблица WHERE условия_отбора;
LOOP
  -- Цикл по найденным записям
END LOOP;
CLOSE курсор2;



-- ---------------------------------------------------------------------------------------------------------------------[ 3-4 ]
PROCEDURE процедура (параметр1 тип1, параметр2 IN OUT тип2, параметр3 тип3 := значение3) AS -- -------------------------------------- Процедура
CREATE OR REPLACE PROCEDURE процедура (параметр1 тип1, параметр2 IN OUT тип2, параметр3 тип3 := значение3) AS -- -------------------- Хранимая процедура
  -- Объявление переменных, типов, курсоров и проч.
BEGIN
  -- Код процедуры (обязательная часть подпрограммы)
EXCEPTION
  -- Обработка исключений
END процедура;

FUNCTION функция (параметр1 тип1, параметр2 IN OUT тип2, параметр3 тип3 := значение3) RETURN тип_значения AS -- --------------------- Функция
CREATE OR REPLACE FUNCTION функция (параметр1 тип1, параметр2 IN OUT тип2, параметр3 тип3 := значение3) RETURN тип_значения AS -- --- Хранимая функция
  -- Объявление переменных, типов, курсоров и проч.
BEGIN
  -- Код функции (обязательная часть подпрограммы)
EXCEPTION
  -- Обработка исключений
END функция;

CREATE OR REPLACE TRIGGER тригер BEFORE INSERT OR UPDATE ON табли FOR EACH ROW -- --------------------------------------------------- Триггер

исключение EXCEPTION; -- ------------------------------------------------------------------------------------------------------------ Объявление исключения
PRAGMA EXCEPTION_INIT(исключение, код_ошибки); -- ----------------------------------------------------------------------------------- Отождествление исключения с ошибкой

RAISE исключение; -- ---------------------------------------------------------------------------------------------------------------- Принудительно выбрасываем (собственное) исключение

EXCEPTION WHEN исключение THEN -- --------------------------------------------------------------------------------------------------- Обработка (идентификатор) перехватываемого исключения

CREATE OR REPLACE PACKAGE пакет AS TYPE какой_то_тип AS; -- ------------------------------------------------------------------------- Пакет
  какая_то_переменная тип;
  PROCEDURE какая_то_процедура;
  FUNCTION какая_то_функция RETURN тип;
END пакет;

CREATE OR REPLACE PACKAGE BODY пакет AS PROCEDURE какая_то_процедура AS -- ---------------------------------------------------------- Пакет
    -- Реализация
  END какая_то_процедура;
  FUNCTION какая_то_функция RETURN тип AS
    -- Реализация
  END какая_то_функция;
  -- ...
BEGIN
  -- Блок инициализации
END пакет;


FUNCTION get_emp(a_ename VARCHAR2) RETURN VARCHAR2 AS
    l_sal emp.sal%TYPE;
    l_job emp.job%TYPE;
BEGIN
    SELECT job, sal INTO l_job, l_sal
        FROM emp
        WHERE ename = a_ename;
    RETURN a_ename ||' '|| l_job ||' '|| l_sal;
EXCEPTION WHEN NO_DATA_FOUND THEN
    RETURN a_ename ||' - не найден';
END get_emp;

get_dept('SCOTT', l_dept);


CREATE OR REPLACE FUNCTION get_bonus(a_sal NUMBER) RETURN NUMBER AS
BEGIN
    IF a_sal < 2000 THEN
        RETURN 500;
    ELSIF a_sal BETWEEN 2000 AND 4000 THEN
        RETURN 1000;
    ELSE
        RETURN 0;
    END IF;
END get_bonus;

get_bonus(155);


CREATE OR REPLACE PACKAGE pk_emp AS
    FUNCTION get_name(a_empno NUMBER) RETURN VARCHAR2;
    FUNCTION get_dept(a_empno NUMBER) RETURN VARCHAR2;
END pk_emp;

CREATE OR REPLACE PACKAGE BODY pk_emp AS
    TYPE TStringArray IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    la_emp TStringArray;
    la_dept TStringArray;
    FUNCTION get_name(a_empno NUMBER) RETURN VARCHAR2
    AS
    BEGIN
        IF NOT la_emp.EXISTS(a_empno) THEN
            SELECT ename INTO la_emp(a_empno)
                FROM emp
                WHERE empno = a_empno;
        END IF;
        RETURN la_emp(a_empno);
    END get_name;
    FUNCTION get_dept(a_empno NUMBER) RETURN VARCHAR2
    AS
    BEGIN
        RETURN la_dept(a_empno);
    END get_dept;
BEGIN
    FOR lc IN (SELECT empno, dname FROM emp e, dept d WHERE d.deptno = e.deptno)
    LOOP
        la_dept(lc.empno) := lc.dname;
    END LOOP;
END pk_emp;



-- ---------------------------------------------------------------------------------------------------------------------[ 4-4 ]
-- --- Рекурсивный вызов
FUNCTION функция (параметры) RETURN тип_значения AS
BEGIN
  IF условие_выхода THEN
    RETURN значение;
  ELSE
    RETURN функция(параметры_след_уровня); -- вызов подпрограммы из тела этой же подпрограммы.
  END IF;
END функция;

-- --- Перегрузка функций
DECLARE
    l_dept VARCHAR2(100);
    FUNCTION get_dept_name(a_deptno NUMBER) RETURN VARCHAR2 AS -- по типу, количеству, порядку параметров; по типу самой подпрограммы (процедура/функция);
        l_dept VARCHAR2(100);
    BEGIN
        SELECT dname INTO l_dept
            FROM dept
            WHERE deptno = a_deptno;
        RETURN l_dept;
    END get_dept;
    FUNCTION get_dept_name(a_ename VARCHAR2) RETURN VARCHAR2 AS -- по типу, количеству, порядку параметров; по типу самой подпрограммы (процедура/функция);
        l_deptno NUMBER;
    BEGIN
        SELECT deptno INTO l_deptno
            FROM emp WHERE ename = a_ename;
        RETURN get_dept_name(l_deptno);
    END get_dept;
BEGIN
    l_dept := get_dept_name(30);
    dbms_output.put_line(l_dept);
    l_dept := get_dept_name('SCOTT');
    dbms_output.put_line(l_dept);
END;



-- ----------------------------------------------------------------------------------------- Механизм заданий (jobs) ... Пакет dbms_job
-- --- Создание задания
DECLARE
    l_job NUMBER;
BEGIN
    dbms_job.submit(l_job,
              'PL/SQL тело задания',
               дата_старта,
              'вычисление_след_старта');
    COMMIT;
END;

-- --- Принудительный запуск задания
BEGIN
    dbms_job.run(номер_задания);
END;

-- --- Остановка задания
BEGIN
    dbms_job.broken(номер_задания, TRUE); -- true = остановить; false = возобновить
END;
