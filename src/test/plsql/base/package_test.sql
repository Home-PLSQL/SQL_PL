
/*
 * Пакет — хранимый объект, объединяющий логически близкие типы, данные, подпрограммы
 */

CREATE OR REPLACE PACKAGE pk_emp AS
    FUNCTION get_name(a_empno NUMBER) RETURN VARCHAR2;
    FUNCTION get_dept(a_empno NUMBER) RETURN VARCHAR2;
END pk_emp;

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