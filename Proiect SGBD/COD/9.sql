REM   Script: EX9
REM   Procedura  care printeaza informatii despre un angajat avand ca parametru ID-ul acestuia (numele , emailul , numarul de telefon . titlul jobului al unui angajat , dar si numele CEO-ului si companiei pentru care lucreaza). Daca angajatul nu exista sau sunt gasiti mai multi -> exceptie.

CREATE OR REPLACE PROCEDURE get_employee_info ( 
  p_employee_id IN NUMBER, 
  p_employee_name OUT VARCHAR2, 
  p_employee_email OUT VARCHAR2, 
  p_employee_phone OUT VARCHAR2, 
  p_job_title OUT VARCHAR2, 
  p_company_name OUT VARCHAR2, 
  p_company_ceo OUT VARCHAR2 
) 
AS 
BEGIN 
  SELECT e.name, e.email, e.phone_number, j.title, c.name, c.ceo 
  INTO p_employee_name, p_employee_email, p_employee_phone, p_job_title, p_company_name, p_company_ceo 
  FROM temployee e 
  INNER JOIN tjobhistory jh ON e.id_job_history = jh.id 
  INNER JOIN tjob j ON jh.id_job = j.id 
  INNER JOIN tstore s ON e.id_store = s.id 
  INNER JOIN tcompany c ON s.id_company = c.id 
  WHERE e.id = p_employee_id; 
EXCEPTION 
  WHEN NO_DATA_FOUND THEN 
    p_employee_name := NULL; 
    p_employee_email := NULL; 
    p_employee_phone := NULL; 
    p_job_title := NULL; 
    p_company_name := NULL; 
    p_company_ceo := NULL; 
  WHEN TOO_MANY_ROWS THEN 
    RAISE_APPLICATION_ERROR(-20001, 'Multiple employees found with the same ID'); 
END; 
/

DECLARE 
l_name VARCHAR2(100); 
l_email VARCHAR2(100); 
l_phone VARCHAR2(100); 
l_job_title VARCHAR2(100); 
l_company_name VARCHAR2(100); 
l_company_ceo VARCHAR2(100); 
 
BEGIN 
  FOR i in 0..10 LOOP 
  get_employee_info(i, l_name, l_email, l_phone, l_job_title, l_company_name, l_company_ceo); 
   
  IF l_name IS NULL THEN 
    DBMS_OUTPUT.PUT_LINE('Employee not found'||CHR(10)); 
  ELSE 
    DBMS_OUTPUT.PUT_LINE('Name: ' || l_name); 
    DBMS_OUTPUT.PUT_LINE('Email: ' || l_email); 
    DBMS_OUTPUT.PUT_LINE('Phone: ' || l_phone); 
    DBMS_OUTPUT.PUT_LINE('Job title: ' || l_job_title); 
  DBMS_OUTPUT.PUT_LINE('Company name: ' || l_company_name); 
  DBMS_OUTPUT.PUT_LINE('Company CEO: ' || l_company_ceo||CHR(10)); 
  END IF; 
  END LOOP; 
EXCEPTION 
  WHEN OTHERS THEN 
    -- other errors 
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM); 
END; 
/

