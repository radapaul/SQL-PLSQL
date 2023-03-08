REM   Script: EX11
REM   Trigger LMD la nivel de linie , declansat

CREATE OR REPLACE TRIGGER prevent_name_update 
  BEFORE UPDATE ON temployee 
  FOR EACH ROW 
BEGIN 
  -- Raise an error if the name is being modified 
  IF :NEW.name <> :OLD.name THEN 
    RAISE_APPLICATION_ERROR(-20001, 'Cannot update name'); 
  END IF; 
END; 
/

BEGIN 
  UPDATE temployee 
  SET name = 'John' 
  WHERE id = 1; 
END; 
/

SELECT * FROM TEMPLOYEE WHERE ID = 1;

