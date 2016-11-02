
--- (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL
--
-- 1. Извлечение и обработка данных
-- 2. Курсоры
-- 3. Вызовы SQL в PL/SQL-ном блоке
-- 4. Управление изменениями
--- 5. Триггеры

/*
 * Триггеры
 *
 * Триггеры на события DML (на строку/на операцию)
 * Триггеры INSTEAD OF
 * Триггеры на события DDL
 * Триггеры на события уровня схемы/БД
 */
DO $BODY$
  CREATE OR REPLACE TRIGGER tbui_emp
      BEFORE INSERT OR UPDATE ON emp
      FOR EACH ROW
  BEGIN
      :NEW.hiredate := NVL(:NEW.hiredate, SYSDATE);
  END;
$BODY$ LANGUAGE plpgsql;

/*
 * Исключения:
 * - Обработка ошибок (исключение — ошибка времени выполнения):
 *   -- Нормальное выполнение блока прекращается
 *   -- Управление возвращается внешнему (вызвавшему) блоку
 *   -- ...до тех пор, пока исключение не будет «перехвачено» и обработано:
 *      --- выдано user-friendly сообщение пользователю
 *      --- записано в лог
 *      --- проигнорировано
 *      --- ...
 * - Предопределенные исключения
 *   -- NO_DATA_FOUND
 *   -- TOO_MANY_ROWS
 *   -- ZERO_DIVIDE
 *   -- INVALID_CURSOR
 *   -- VALUE_ERROR
 *   -- ...
 *   -- OTHERS — перехват всех исключений, не обработанных ранее.
 * - Объявление исключений (собственное исключение)
 */
DO $BODY$
  BEGIN
    -- Код программы, в котором ожидается возникновение ошибки
  EXCEPTION WHEN исключение THEN -- Идентификатор перехватываемого исключения
    -- Обработка исключения
  END;
$BODY$ LANGUAGE plpgsql;


/*
 * Обработка ошибок — пример
 */
DO $BODY$
  DECLARE
      ename1 VARCHAR2(100) := 'SKOTT';
      job1 VARCHAR2(100);
  BEGIN
    SELECT job INTO job1
        FROM emp
        WHERE ename = ename1;
    DBMS_OUTPUT.PUT_LINE(ename1 || ' ' || job1);
  EXCEPTION WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(ename1 || ' - не найден');
  END;
$BODY$ LANGUAGE plpgsql;


DO $BODY$
  DECLARE
    исключение EXCEPTION;
    PRAGMA EXCEPTION_INIT(исключение, код_ошибки); -- Отождествление исключения с ошибкой Oracle
  BEGIN
    -- Код программы, в котором ожидается возникновение ошибки с кодом «код_ошибки»
    RAISE исключение; -- Принудительная генерация исключения (собственное исключение)
  EXCEPTION WHEN исключение THEN -- Обработка исключения
  END;
$BODY$ LANGUAGE plpgsql;




