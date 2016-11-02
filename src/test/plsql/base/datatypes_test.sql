
DO $BODY$
  DECLARE
    num1 NUMBER;
    char1 VARCHAR2(10);
    date1 DATE;
  BEGIN
    num1 := 50;
    char1 := num1; -- Неявное приведение
    DBMS_OUTPUT.PUT_LINE('char1 = ' || char1);
    char1 := '15.03.2010';
    date1 := TO_DATE(char1, 'DD.MM.YYYY'); -- Явное приведение типов (по маске)
    DBMS_OUTPUT.PUT_LINE('date1 = ' || date1);
    char1 := TO_CHAR(date1, 'YYYY.MM.DD');
    DBMS_OUTPUT.PUT_LINE('char1 = ' || char1);
  END;
$BODY$ LANGUAGE plpgsql;

