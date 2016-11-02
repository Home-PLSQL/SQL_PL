/*
 * (Задачи по PL/SQL) http://wikisandbox.custis.ru/Курс_по_SQL_и_PL/SQL/Задачи_по_PL
 *
 * Пакет реализует API доступа к данным сотрудников:
 * - получение имени сотрудника по его номеру
 * - получение названия подразделения сотрудника по его номеру
 * Обращения к БД кешируются.
 */
CREATE OR REPLACE PACKAGE pk_emp AS
    FUNCTION get_name(a_empno NUMBER) RETURN VARCHAR2;
    FUNCTION get_dept(a_empno NUMBER) RETURN VARCHAR2;
END pk_emp;

CREATE OR REPLACE PACKAGE BODY pk_emp AS
    TYPE TStringArray IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
    la_emp TStringArray;
    la_dept TStringArray;
    FUNCTION get_name(a_empno NUMBER) RETURN VARCHAR2
    AS
    BEGIN
        IF NOT la_emp.EXISTS(a_empno) THEN
            SELECT ename INTO la_emp(a_empno)
                FROM emp
                WHERE empno = a_empno;
        END IF;
        RETURN la_emp(a_empno);
    END get_name;
    FUNCTION get_dept(a_empno NUMBER) RETURN VARCHAR2
    AS
    BEGIN
        RETURN la_dept(a_empno);
    END get_dept;
BEGIN
    FOR lc IN (SELECT empno, dname FROM emp e, dept d WHERE d.deptno = e.deptno)
    LOOP
        la_dept(lc.empno) := lc.dname;
    END LOOP;
END pk_emp;
