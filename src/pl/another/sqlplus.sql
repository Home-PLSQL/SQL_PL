
--- (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL
--
-- Утилита SQL*Plus: позволяет выполнять команды SQL и блоки PL/SQL.
-- sqlplus — работа в окне командной строки
-- sqlplusw — оконная версия


/*
 * Коротко об sqlplus — пример
 * script.sql
 */
-- Определить код возврата при ошибке
WHENEVER SQLERROR EXIT -1 ROLLBACK
-- Подключиться к БД (параметризовано)
CONNECT &1/&2@ORAXE;
-- Включить вывод
SET SERVEROUTPUT ON;
-- Логировать действия в файл
SPOOL test.log;
-- Объявить и присвоить bind-переменную
var v_cnt NUMBER;
EXEC :v_cnt := 30;
-- Выполнить команду SQL
SELECT * FROM emp WHERE deptno = :v_cnt;
-- Выполнить блок PL/SQL
BEGIN
    dbms_output.put_line('Listed employees for deptno '|| :v_cnt);
END;

-- Выйти с кодом "успешно"
EXIT 0;