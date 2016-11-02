
--- (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL
--
--- 1. Функции, процедуры
--- 2. Параметры
--- 3. Перегрузка функций, процедур
--- 4. Рекурсивный вызов
-- 5. Управление правами выполнения

/*
 * Подпрограмма — это именованный блок PL/SQL, который может иметь параметры вызова.
 * Подпрограммы, аналогично анонимным блокам, тоже могут быть вложенными.
 */

/*
 * Процедура
 */
DO $BODY$
  PROCEDURE процедура (параметры)
  AS
    -- Объявление переменных, типов, курсоров и проч
  BEGIN
    -- Код процедуры (обязательная часть подпрограммы)
  EXCEPTION
    -- Обработка исключений
  END процедура;
$BODY$ LANGUAGE plpgsql;


/*
 * Функция:
 * - Возвращает некоторое значение
 */
DO $BODY$
  FUNCTION функция (параметры)
    RETURN тип_значения
  AS
    -- Объявление переменных, типов, курсоров и проч
  BEGIN
    -- Код функции (обязательная часть подпрограммы)
  EXCEPTION
    -- Обработка исключений
  END функция;
$BODY$ LANGUAGE plpgsql;


/*
 * «Хранимые» функции, процедуры
 */
DO $BODY$
  CREATE OR REPLACE FUNCTION функция ...
  CREATE OR REPLACE PROCEDURE процедура ...
$BODY$ LANGUAGE plpgsql;


/*
 * Параметры характеризуются:
 * - Имя
 * - Режим использования (IN, OUT, IN OUT)
 * - Тип значения
 * - Значение по умолчанию
 */
DO $BODY$
  PROCEDURE процедура (
      параметр1 тип1,
      параметр2 IN OUT тип2,
      параметр3 тип3 := значение3
    )
  AS
    -- Объявление переменных, типов, курсоров и проч
  BEGIN
    -- Код процедуры (обязательная часть подпрограммы)
  EXCEPTION
    -- Обработка исключений
  END процедура;
$BODY$ LANGUAGE plpgsql;


/*
 * Рекурсия — вызов подпрограммы из тела этой же подпрограммы.
 *
 * - Обход структуры в виде дерева
 * - Математические вычисления
 * - ...
 * - Важно определить условие выхода из рекурсии
 */
DO $BODY$
  FUNCTION функция (параметры)
    RETURN тип_значения
  AS
  BEGIN
    -- Некая обработка
    IF условие_выхода THEN
      RETURN значение;
    ELSE
      RETURN функция(параметры_след_уровня);
    END IF;
  END функция;
$BODY$ LANGUAGE plpgsql;


/*
 * Функции, процедуры — пример #1
 */
DO $BODY$
  DECLARE
      emp1 VARCHAR2(100);
      FUNCTION my_func(a_ename VARCHAR2) RETURN VARCHAR2
      AS
          sal1 emp.sal%TYPE;
          job1 emp.job%TYPE;
      BEGIN
          SELECT job, sal INTO job1, sal1
              FROM emp
              WHERE ename = a_ename;
          RETURN a_ename || ' ' || job1 || ' ' || sal1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
          RETURN a_ename || ' - не найден';
      END my_func;
  BEGIN
      emp1 := my_func('SCOTT');
      DBMS_OUTPUT.PUT_LINE(emp1);
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Функции, процедуры — пример #2
 */
DO $BODY$
CREATE OR REPLACE FUNCTION get_bonus(sal1 NUMBER) RETURN NUMBER
AS
BEGIN
    IF sal1 < 2000 THEN
        RETURN 500;
    ELSIF sal1 BETWEEN 2000 AND 4000 THEN
        RETURN 1000;
    ELSE
        RETURN 0;
    END IF;
END get_bonus;
$BODY$ LANGUAGE plpgsql;


/*
 * Параметры — пример #3
 */
DO $BODY$
  DECLARE
      dept1 VARCHAR2(100);
      PROCEDURE my_func2(a_ename VARCHAR2, a_dept OUT VARCHAR, a_needed BOOLEAN := FALSE)
      AS
      BEGIN
          SELECT dname INTO a_dept
              FROM dept
              WHERE deptno = (SELECT deptno FROM emp WHERE ename = a_ename);
      EXCEPTION WHEN NO_DATA_FOUND THEN
          IF a_needed THEN
              RAISE;
          END IF;
      END my_func2;
  BEGIN
      my_func2('SCOTT', dept1);
      DBMS_OUTPUT.PUT_LINE(dept1);
      my_func2('SKOTT', a_needed => TRUE, a_dept => dept1);
      DBMS_OUTPUT.PUT_LINE(dept1);
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Перегрузка функций — пример #4
 */
DO $BODY$
  DECLARE
      dept3 VARCHAR2(100);
      FUNCTION my_func3(a_deptno NUMBER) RETURN VARCHAR2
      AS
        dept3 VARCHAR2(100);
        BEGIN
            SELECT dname INTO dept3
                FROM dept
                WHERE deptno = a_deptno;
            RETURN dept3;
        END my_func3;
      FUNCTION my_func3(a_ename VARCHAR2) RETURN VARCHAR2
        AS
        deptno3 NUMBER;
        BEGIN
            SELECT deptno INTO deptno3
                FROM emp WHERE ename = a_ename;
            RETURN my_func3(deptno3);
        END my_func3;
  BEGIN
      dept3 := my_func3(30);
      DBMS_OUTPUT.PUT_LINE(dept3);
      dept3 := my_func3('SCOTT');
      DBMS_OUTPUT.PUT_LINE(dept3);
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Рекурсивный вызов — пример #5
 */
DO $BODY$
  DECLARE
      PROCEDURE print_bosses(a_empno NUMBER)
      AS
          mgr1 NUMBER;
          name1 VARCHAR2(100);
          job1 VARCHAR2(100);
      BEGIN
          SELECT ename, job, mgr INTO name1, job1, mgr1
              FROM emp
              WHERE empno = a_empno;
          DBMS_OUTPUT.PUT_LINE('Ищем босса для:' || name1 || ' ' || job1);
          IF mgr1 IS NOT NULL THEN
              print_bosses(mgr1);
          ELSE
              DBMS_OUTPUT.PUT_LINE('Не нашли...');
          END IF;
      END print_bosses;
  BEGIN
      print_bosses(7369);
  END;
$BODY$ LANGUAGE plpgsql;

