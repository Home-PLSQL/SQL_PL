
--- (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL
--
-- (Using PostgreSQL Anonymous Code Blocks) http://nixmash.com/postgresql/using-postgresql-anonymous-code-blocks/
--                                          http://stackoverflow.com/questions/26014166/print-the-output-of-execution-of-do-anonymous-block
--                                          http://nixmash.com/postgresql/using-postgresql-anonymous-code-blocks/
--
-- (Manuals → PostgreSQL 9.3) https://www.postgresql.org/docs/9.3/static/plpgsql-structure.html
--
--                        http://www.onlamp.com/pub/a/onlamp/2006/05/11/postgresql-plpgsql.html
--                        http://forums.enterprisedb.com/posts/list/4619.page
-- (Creating a Procedure) https://www.enterprisedb.com/docs/en/9.4/oracompat/Database_Compatibility_for_Oracle_Developers_Guide.1.132.html
--                        http://forums.devshed.com/postgresql-help-21/postgresql-syntax-error-declaring-variable-anonymous-block-866528.html


/*
 * Составные части блока:
 * - секция объявлений;
 * - тело блока (обязательная часть);
 * - обработчики исключений;
 */

DO $BODY$
  DECLARE
    -- Объявление переменных, типов, курсоров и проч.
  BEGIN
    -- Код программы (обязательная часть блока)
    -- Простейший блок, реализующий вывод сообщения Hello world!
    DBMS_OUTPUT.PUT_LINE('Hello world!');
  EXCEPTION
    -- Обработка исключений
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Переменные:
 * - Могут иметь тип данных SQL или PL/SQL
 * - Объявляются в секциях объявлений блоков PL/SQL
 * - Видны внутри блока, в котором они объявлены
 * - Получают тип данных при объявлении
 * - Могут быть проинициализированы значением при объявлении
 */

DO $BODY$
  DECLARE
    -- имя_переменной1 тип_переменной1; -- Переменная заданного типа
    -- имя_переменной2 тип_переменной2 := значение2; -- С присвоением значения
    -- имя_константы CONSTANT тип_константы := значение; -- Константы
    message1 VARCHAR2 (100) := 'Первое сообщение';
    message2 VARCHAR2 (100) := 'Второе сообщение';
  BEGIN
    DECLARE
      message1 VARCHAR2 (100) := 'Сообщение вложенного блока!';
    BEGIN
      DBMS_OUTPUT.PUT_LINE(message1);
    END;
    DBMS_OUTPUT.PUT_LINE(message1);
    DBMS_OUTPUT.PUT_LINE(message2);
  EXCEPTION
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Простые (скалярные) типы (простые значения без внутренних составляющих):
 * - NUMBER(точность, масштаб) — число с плавающей точкой
 * - CHAR2(размер) — строка постоянной длины
 * - VARCHAR2(макс_размер) — строка переменной длины
 * - DATE — дата (со временем)
 * - BOOLEAN — логическое значение
 * - ...
 *
 * Составные типы (структуры из определенных компонент):
 * - TABLE — коллекция
 * - VARRAY — массив
 * - RECORD — запись
 *
 * Ссылочные типы:
 * - ссылка на объект, например REF CURSOR

 * LOB типы: «локатор», определяющий расположение больших объектов данных (графика, файлы,...):
 * - BFILE — внешний двоичный файл
 * - BLOB — внутренний двоичный объект
 * - CLOB — внутренний символьный объект
 *
 * Приведение типов:
 * - Явное
 *   -- TO_NUMBER()
 *   -- TO_CHAR()
 *   -- TO_DATE()
 *   -- ...
 * - Неявное
 *
 * Методы работы с коллекциями:
 * - EXISTS(индекс_элемента) — существует ли элемент по индексу?
 * - COUNT — количество элементов в коллекции.
 * - LIMIT — размер varray-массива.
 * - DELETE(с_элемента, по_элемент) — удалить элементы: все; один; диапазон.
 * - FIRST, LAST — индексы первого и последнего элемента.
 * - PRIOR(индекс_элемента), NEXT(индекс_элемента) — индексы следующего и предыдущего элемента.
 *
 * Атрибуты типизации:
 * - %TYPE
 *   -- Объявление переменной с типом другой переменной.
 *   -- Объявление переменной с типом поля таблицы в БД.
 * - %ROWTYPE
 *   -- Объявление переменной типа запись, по структуре соответствующей строке таблицы в БД.
 */

DO $BODY$
  DECLARE
    num1 NUMBER;
    char1 VARCHAR2(10);
    date1 DATE;
  BEGIN
    num1 := 50;
    char1 := num1; -- Неявное приведение
    DBMS_OUTPUT.PUT_LINE('char1 = ' || char1);
    char1 := '15.03.2010';
    date1 := TO_DATE(char1, 'DD.MM.YYYY'); -- Явное приведение типов (по маске)
    DBMS_OUTPUT.PUT_LINE('date1 = ' || date1);
    char1 := TO_CHAR(date1, 'YYYY.MM.DD');
    DBMS_OUTPUT.PUT_LINE('char1 = ' || char1);
  END;
$BODY$ LANGUAGE plpgsql;


DO $BODY$
  DECLARE
    TYPE имя_нового_типа_массив    IS VARRAY (макс_размер) OF тип_элемента;                         -- Объявление нового типа-массива
    TYPE имя_нового_типа_коллекция IS TABLE                OF тип_элемента INDEX BY BINARY_INTEGER; -- Объявление нового типа-коллекции
    TYPE имя_нового_типа_запись    IS RECORD (поле1 тип1, поле2 тип2, ...);                         -- Объявление нового типа-записи
    переменная1 имя_нового_типа_массива;   -- Объявление переменной этого типа
    переменная2 имя_нового_типа_коллекции; -- Объявление переменной этого типа
    переменная3 имя_нового_типа_запись;    -- Объявление переменной этого типа
  BEGIN
  END;
$BODY$ LANGUAGE plpgsql;


DO $BODY$
  DECLARE
    TYPE MyStringArray IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    elements1 MyStringArray;
    index1 NUMBER;
  BEGIN
    elements1(1) := 'Первый элемент';
    elements1(2) := 'Второй элемент';
    elements1(3) := 'Третий элемент';
    FOR i IN 1..elements1.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE(elements1(i));
    END LOOP;
    elements1(10) := 'Десятый элемент';
    index1 := elements1.FIRST;
    LOOP
      DBMS_OUTPUT.PUT_LINE(elements1(index1));
      index1 := elements1.NEXT(index1);
      EXIT WHEN index1 IS NULL;
    END LOOP;
  END;
$BODY$ LANGUAGE plpgsql;


DO $BODY$
  DECLARE
      TYPE MyEmployee IS RECORD (ename VARCHAR2(10), job VARCHAR2(10));
      emp1 MyEmployee;
  BEGIN
      emp1.ename := 'SCOTT';
      emp1.job := 'ANALYST';
      DBMS_OUTPUT.PUT_LINE(emp1.ename || ' ' || emp1.job);
  END;
$BODY$ LANGUAGE plpgsql;


DO $BODY$
  DECLARE
    -- имя_переменной1 тип_переменной1;
    -- имя_переменной2 имя_переменной1%TYPE; -- Объявление переменной с типом другой переменной
    -- имя_переменной3 имя_таблицы1.имя_поля%TYPE; -- Объявление переменной с типом поля таблицы
    -- имя_переменной4 имя_таблицы2%ROWTYPE; -- Объявление переменной, соответствующей строке таблицы
    name1 emp.ename%TYPE;
    job1 emp.job%TYPE;
    emp1 emp%ROWTYPE;
  BEGIN
    name1 := 'JONES';
    job1 := 'MANAGER';
    emp1.ename := name1;
    emp1.job := job1;
    DBMS_OUTPUT.PUT_LINE(emp1.ename ||' '|| emp1.job);
  END;
$BODY$ LANGUAGE plpgsql;

