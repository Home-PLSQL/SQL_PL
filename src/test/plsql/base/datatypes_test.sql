
/*
 * Простые типы:
 * - INTEGER — целое число
 * - NUMBER(точность, масштаб) — число с плавающей точкой
 * - CHAR2(размер) — строка постоянной длины
 * - VARCHAR2(макс_размер) — строка переменной длины
 * - DATE — дата (со временем)
 * - BOOLEAN — логическое значение
 *
 * Составные типы:
 * - VARRAY — массив
 * - TABLE — коллекция
 * - RECORD — запись
 *
 * Ссылочные типы:
 * - REF CURSOR — ссылка на объект
 *
 * LOB типы:
 * - CLOB — внутренний символьный объект
 * - BLOB — внутренний двоичный объект
 * - BFILE — внешний двоичный файл
 *
 *
 * Атрибуты типизации:
 * - %TYPE
 *   -- Объявление переменной с типом другой переменной
 *   -- Объявление переменной с типом поля таблицы в БД
 * - %ROWTYPE
 *   -- Объявление переменной типа запись, по структуре соответствующей строке таблицы в БД
 */

/*
 * риведение типов:
 * - Явное
 *   -- TO_NUMBER()
 *   -- TO_CHAR()
 *   -- TO_DATE()
 *   -- ...
 * - Неявное
 */

/*
 * Методы работы с коллекциями:
 * - EXISTS(индекс_элемента) — существует ли элемент по индексу?
 * - COUNT — количество элементов в коллекции.
 * - LIMIT — размер varray-массива.
 * - DELETE(с_элемента, по_элемент) — удалить элементы: все; один; диапазон.
 * - FIRST, LAST — индексы первого и последнего элемента.
 * - PRIOR(индекс_элемента), NEXT(индекс_элемента) — индексы следующего и предыдущего элемента.
 */

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


DECLARE
    TYPE MyEmployee IS RECORD (ename VARCHAR2(10), job VARCHAR2(10));
    emp1 MyEmployee;
BEGIN
    emp1.ename := 'SCOTT';
    emp1.job := 'ANALYST';
    DBMS_OUTPUT.PUT_LINE(emp1.ename || ' ' || emp1.job);
END;





