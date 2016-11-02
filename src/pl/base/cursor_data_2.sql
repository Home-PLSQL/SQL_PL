
--- (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL
--
-- 1. Извлечение и обработка данных
--- 2. Курсоры
-- 3. Вызовы SQL в PL/SQL-ном блоке
-- 4. Управление изменениями
-- 5. Триггеры

/*
 * Курсор — получаемый при выполнении запроса результирующий набор записей плюс привязанный к нему указатель текущей записи.
 *
 * Курсоры:
 * - Явные (объявляются разработчиком)
 * - Неявные (не требуют объявления, управляются автоматически)
 *
 * Состояние курсора — атрибуты:
 * - %ISOPEN
 * - %FOUND
 * - %NOTFOUND
 * - %ROWCOUNT
 */

/*
 * Организация работы с явным курсором
 */
DO $BODY$
  DECLARE
    CURSOR курсор IS
      SELECT поле1, поле2
        FROM таблица
        WHERE условия_отбора; -- Объявление курсора
    переменная1 таблица.поле1%TYPE;
    переменная2 таблица.поле2%TYPE;
  BEGIN
    OPEN курсор; -- Открытие курсора
    LOOP -- Цикл по найденным записям
      FETCH курсор INTO переменная1, переменная2; -- Получение данных текущей записи
      EXIT WHEN курсор%NOTFOUND; -- Записи в курсоре закончились - выход из цикла
      -- Дальнейшие действия с переменными
    END LOOP;
    CLOSE курсор; -- Закрыть курсор
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Использование типа REF CURSOR
 */
DO $BODY$
  DECLARE
    TYPE тип_курсора IS REF CURSOR; -- Объявление типа-указателя
    курсор тип_курсора; -- Объявление переменной курсора
  BEGIN
    OPEN курсор FOR
        SELECT поле1, поле2
          FROM таблица
          WHERE условия_отбора;
    LOOP
      -- Цикл по найденным записям
    END LOOP;
    CLOSE курсор;
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Цикл FOR-LOOP
 */
DO $BODY$
  DECLARE
    CURSOR курсор IS
      SELECT поле1, поле2
        FROM таблица
        WHERE условия_отбора; -- Объявление курсора
  BEGIN
    FOR запись IN курсор LOOP -- Цикл по найденным записям
      -- Действия с записью в виде:
      -- запись.поле1, запись.поле2
    END LOOP;
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Цикл FOR-LOOP — и даже проще
 */
DO $BODY$
  BEGIN
    FOR запись IN (
        SELECT поле1, поле2
          FROM таблица
          WHERE условия_отбора
      )
    LOOP -- Цикл по найденным записям
      -- Действия с записью в виде:
      -- запись.поле1, запись.поле2
    END LOOP;
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Курсоры — пример
 */
DO $BODY$
  DECLARE
    TYPE MyCursor IS REF CURSOR;
    c2 MyCursor;
    emp2 emp%ROWTYPE;
  BEGIN
    -- #1
    FOR emp1 IN (SELECT * FROM emp WHERE deptno = 30) LOOP
        DBMS_OUTPUT.PUT_LINE(emp1.ename);
    END LOOP;
    FOR emp1 IN (SELECT * FROM emp WHERE job = 'ANALYST') LOOP
        DBMS_OUTPUT.PUT_LINE(emp1.ename);
    END LOOP;

    -- #2
    OPEN c2 FOR SELECT * FROM emp WHERE deptno = 30;
    LOOP
      FETCH c2 INTO emp2;
      EXIT WHEN c2%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(emp2.ename);
    END LOOP;
    CLOSE c2;
    OPEN c2 FOR SELECT * FROM emp WHERE job = 'ANALYST';
    LOOP
      FETCH c2 INTO emp2;
      EXIT WHEN c2%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(emp2.ename);
    END LOOP;
    CLOSE c2;
  END;
$BODY$ LANGUAGE plpgsql;

