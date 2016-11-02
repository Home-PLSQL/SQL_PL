
--- (Курс по SQL и PL/SQL/Основы PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Основы_PL/SQL
--
-- 1. Структура пакета
--    Тело — реализация.
-- 2. Доступ к элементам пакета
--      Вызов: имя_пакета.имя_элемента
--      Спецификация: Объявления всех элементов пакета, к которым должен быть доступ извне
--      Тело: внутренние данные, к которым можно обратиться только изнутри пакета
-- 3. Инициализация данных пакета
--      Необязательный блок BEGIN-END в теле пакета
--      Выполняется при первом обращении пользователя к элементу пакета
--      Можно заполнить переменные пакета (например из БД), которые затем будут использоваться в подпрограммах пакета

/*
 * Пакет — хранимый объект, объединяющий логически близкие типы, данные, подпрограммы
 * - Спецификация — «интерфейс» пакета
 */
DO $BODY$
  CREATE OR REPLACE PACKAGE пакет AS
    TYPE какой_то_тип AS /*...*/;
    какая_то_переменная тип;
    PROCEDURE какая_то_процедура;
    FUNCTION какая_то_функция RETURN тип;
    /*...*/
  END пакет;
$BODY$ LANGUAGE plpgsql;


/*
 * Структура пакета
 */
DO $BODY$
  CREATE OR REPLACE PACKAGE BODY пакет AS
    PROCEDURE какая_то_процедура AS
      -- Реализация
    END какая_то_процедура;
    FUNCTION какая_то_функция RETURN тип AS
      -- Реализация
    END какая_то_функция;
    /*...*/
  BEGIN
    -- Блок инициализации
  END пакет;
$BODY$ LANGUAGE plpgsql;


/*
 * Пакеты PL/SQL — пример

 * Пакет реализует API доступа к данным сотрудников:
 * - получение имени сотрудника по его номеру
 * - получение названия подразделения сотрудника по его номеру
 * Обращения к БД кешируются
 */
DO $BODY$
  CREATE OR REPLACE PACKAGE pk_emp AS
      FUNCTION get_name(a_empno NUMBER) RETURN VARCHAR2;
      FUNCTION get_dept(a_empno NUMBER) RETURN VARCHAR2;
  END pk_emp;
$BODY$ LANGUAGE plpgsql;

DO $BODY$
  CREATE OR REPLACE PACKAGE BODY pk_emp AS
      TYPE MyStringArray IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
      emp1 MyStringArray;
      dept1 MyStringArray;
      FUNCTION get_name(a_empno NUMBER) RETURN VARCHAR2
      AS
      BEGIN
          IF NOT emp1.EXISTS(a_empno) THEN
              SELECT ename INTO emp1(a_empno)
                  FROM emp
                  WHERE empno = a_empno;
          END IF;
          RETURN emp1(a_empno);
      END get_name;
      FUNCTION get_dept(a_empno NUMBER) RETURN VARCHAR2
      AS
      BEGIN
          RETURN dept1(a_empno);
      END get_dept;
  BEGIN
      FOR c1 IN (SELECT empno, dname FROM emp e, dept d WHERE d.deptno = e.deptno)
      LOOP
          dept1(c1.empno) := c1.dname;
      END LOOP;
  END pk_emp;
$BODY$ LANGUAGE plpgsql;