REM   Script: EX7
REM   Procedura care returneaza numele si salariul celor care au salariul mai mare decat parametrul acesteia.

DROP PROCEDURE get_high_paid_sales_employees;

CREATE OR REPLACE PROCEDURE get_high_paid_sales_employees (p_salary IN NUMBER) 
AS 
  CURSOR employees_cursor IS 
    SELECT * FROM temployee; 
 
  CURSOR high_paid_cursor (c_salary NUMBER) IS 
    SELECT salary FROM temployee WHERE salary > c_salary; 
 
  l_employee temployee%ROWTYPE; 
  l_salary NUMBER; 
BEGIN 
  OPEN employees_cursor; 
  LOOP 
    FETCH employees_cursor INTO l_employee; 
    EXIT WHEN employees_cursor%NOTFOUND; 
 
    OPEN high_paid_cursor(p_salary); 
    FETCH high_paid_cursor INTO l_salary; 
    CLOSE high_paid_cursor; 
 
    IF l_employee.salary > p_salary THEN 
      DBMS_OUTPUT.PUT_LINE(l_employee.surname || ' ' || l_employee.name || ' has a salary of ' || l_employee.salary); 
    END IF; 
  END LOOP; 
  CLOSE employees_cursor; 
END; 
/

BEGIN 
get_high_paid_sales_employees(20000); 
END; 
/

