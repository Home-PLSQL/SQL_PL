
--- (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL
--
-- 1. Извлечение и обработка данных
-- 2. Курсоры
--- 3. Вызовы SQL в PL/SQL-ном блоке
-- 4. Управление изменениями
-- 5. Триггеры

/*
 * Вызовы SQL в PL/SQL-ном блоке:
 *
 * Варианты вызова:
 * - Статический («встроенный» SQL): SQL-операторы формируются на этапе компиляции
 * - Динамический: SQL-операторы формируются во время выполнения (в виде текстовых переменных)
 *   - Если текст запроса заранее не может быть известен
 *   - Если запрос содержит операторы DDL
 */

/*
 * Bind-переменные
 */
DO $BODY$
  BEGIN
    EXECUTE IMMEDIATE 'SELECT поле1 FROM таблица WHERE поле2 = :1' INTO переменная1 USING переменная2;
    OPEN курсор FOR 'SELECT поле1 FROM таблица WHERE поле2 = :1' USING переменная2;
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Динамический SQL — пример
 */
DO $BODY$
  DECLARE
    TYPE MyCursor IS REF CURSOR;
    c1 MyCursor;
    select1 VARCHAR2(100) := 'SELECT * FROM emp';
    where1 VARCHAR2(100);
    emp1 emp%ROWTYPE;
  BEGIN
    where1 := 'WHERE ename = :1';
    EXECUTE IMMEDIATE select1 || ' ' || where1 INTO emp1 USING 'MARTIN';
    DBMS_OUTPUT.PUT_LINE(emp1.ename);
    where1 := 'WHERE deptno = :1';
    OPEN c1 FOR select1 || ' ' || where1 USING 30;
    LOOP
        FETCH c1 INTO emp1;
        EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(emp1.ename);
    END LOOP;
    CLOSE c1;
  END;
$BODY$ LANGUAGE plpgsql;





