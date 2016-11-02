
--- (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL
--
--- 1. Извлечение и обработка данных
-- 2. Курсоры
-- 3. Вызовы SQL в PL/SQL-ном блоке
-- 4. Управление изменениями
-- 5. Триггеры

/*
 * Извлечение одной записи
 */
DO $BODY$
  DECLARE
    переменная1 таблица.поле1%TYPE;
    переменная2 таблица.поле2%TYPE;
  BEGIN
    SELECT поле1, поле2 INTO переменная1, переменная2
      FROM таблица
      WHERE условия_отбора;
    -- Дальнейшие действия с переменными
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Извлечение одной записи
 */
DO $BODY$
  DECLARE
    переменная1 таблица.поле1%TYPE;
    переменная2 таблица.поле2%TYPE;
  BEGIN
    SELECT поле1, поле2 INTO переменная1, переменная2
      FROM таблица
      WHERE условия_отбора;
    -- Дальнейшие действия с переменными
  END;
$BODY$ LANGUAGE plpgsql;


/*
 *Извлечение набора записей
 */
DO $BODY$
  DECLARE
    TYPE тип_коллекция IS TABLE OF таблица.поле%TYPE INDEX BY BINARY_INTEGER;
    переменная тип_коллекция;
  BEGIN
    SELECT поле BULK COLLECT INTO переменная
      FROM таблица
      WHERE условия_отбора;
    -- Дальнейшие действия с коллекцией
  END;
$BODY$ LANGUAGE plpgsql;


DO $BODY$
  DECLARE
    job1 emp.job%TYPE;
    sal1 emp.sal%TYPE;
    emp1 emp%ROWTYPE;
  BEGIN
    SELECT job, sal INTO job1, sal1
        FROM emp
        WHERE ename = 'SCOTT';
    DBMS_OUTPUT.PUT_LINE(job1 || ' ' || sal1);
    SELECT * INTO emp1
        FROM emp
        WHERE ename = 'KING';
    DBMS_OUTPUT.PUT_LINE(emp1.job || ' ' || emp1.sal);
  END;
$BODY$ LANGUAGE plpgsql;


DO $BODY$
  DECLARE
    TYPE MyEmpArray IS TABLE OF emp%ROWTYPE INDEX BY BINARY_INTEGER;
    emp1 MyEmpArray;
  BEGIN
    SELECT * BULK COLLECT INTO emp1
        FROM emp
        WHERE sal > 2000;
    FOR i IN 1..emp1.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(emp1(i).ename || ' ' || emp1(i).job || ' ' || emp1(i).sal);
    END LOOP;
  END;
$BODY$ LANGUAGE plpgsql;



