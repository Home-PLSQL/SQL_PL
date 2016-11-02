
/*
 * Триггеры — это реакция программы на события:
 * - Триггеры на DML-события (на строку/на операцию)
 * - Триггеры на DDL-события
 * - Триггеры на события уровня схемы/БД
 * - Триггеры на Update-события
 *
 * Исключения:
 * - Предопределенные исключения
 *   -- NO_DATA_FOUND
 *   -- TOO_MANY_ROWS
 *   -- ZERO_DIVIDE
 *   -- INVALID_CURSOR
 *   -- VALUE_ERROR
 * - Отождествление исключения с ошибкой Oracle
 * - Принудительная генерация исключения (собственное исключение)
 */

CREATE OR REPLACE TRIGGER tbui_emp
    BEFORE INSERT OR UPDATE ON emp
    FOR EACH ROW
BEGIN
    :NEW.hiredate := NVL(:NEW.hiredate, SYSDATE);
END;


BEGIN
  -- Код программы, в котором ожидается возникновение ошибки
EXCEPTION WHEN исключение THEN -- Идентификатор перехватываемого исключения
  -- Обработка исключения
END;

/*
 * Обработка ошибок — пример
 */
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

DECLARE
  исключение EXCEPTION;
  PRAGMA EXCEPTION_INIT(исключение, код_ошибки); -- Отождествление исключения с ошибкой Oracle
BEGIN
  -- Код программы, в котором ожидается возникновение ошибки с кодом «код_ошибки»
  RAISE исключение; -- Принудительная генерация исключения (собственное исключение)
EXCEPTION WHEN исключение THEN -- Обработка исключения
END;
