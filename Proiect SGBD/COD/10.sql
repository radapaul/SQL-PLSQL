REM   Script: EX10
REM   Trigger LMD la nivel de comanda , de asemenea declansat

CREATE OR REPLACE TRIGGER prevent_salary_update 
  BEFORE UPDATE OF salary ON temployee 
  FOR EACH ROW 
BEGIN 
  -- error if the salary is being modified 
  RAISE_APPLICATION_ERROR(-20001, 'Cannot update salary'); 
END; 
/

BEGIN 
  UPDATE temployee 
  SET salary = salary + 1000 
  WHERE id = 1; 
END;
/

