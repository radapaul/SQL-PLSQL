REM   Script: EX6
REM   Procedura care ia o lista de salariati si calculeaza salariul total si returneaza salariul mediu.

DROP TYPE employee_type FORCE;

DROP TYPE employee_list_type FORCE;

CREATE OR REPLACE TYPE employee_type AS OBJECT (  
  employee_id INTEGER,  
  name VARCHAR2(50),  
  surname VARCHAR2(50),  
  salary NUMBER); 
/

CREATE OR REPLACE TYPE employee_list_type AS VARRAY(10) OF employee_type;  
/

DROP PROCEDURE calculate_average_salary;

CREATE PROCEDURE calculate_average_salary  
AS  
  v_total_salary NUMBER := 0;  
  v_average_salary NUMBER;  
  v_employees employee_list_type;  
BEGIN  
  -- fill v_employees 
  SELECT employee_type(id, name,surname, salary)  
  BULK COLLECT INTO v_employees  
  FROM temployee;  
    
  -- calculate total salary 
  FOR i IN 1 .. v_employees.COUNT  
  LOOP  
    v_total_salary := v_total_salary + v_employees(i).salary;  
  END LOOP;  
    
  -- calculate average salary  
  v_average_salary := v_total_salary / v_employees.COUNT;  
    
  -- print average salary  
    DBMS_OUTPUT.PUT_LINE('The average salary is: ' || v_average_salary);  
  RETURN;  
END;  
/

BEGIN  
  calculate_average_salary;  
END;  
/

