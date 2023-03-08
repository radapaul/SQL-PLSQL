REM   Script: EX12
REM   Trigger LDD , declansat

DROP TABLE log_table;

CREATE TABLE log_table ( 
  id          NUMBER(10)   PRIMARY KEY, 
  operation   VARCHAR2(10) NOT NULL, 
  name        VARCHAR2(50) NOT NULL, 
  price       NUMBER(10,2) NOT NULL 
);

CREATE OR REPLACE TRIGGER log_product_changes 
  AFTER INSERT OR UPDATE OR DELETE ON tproduct 
  FOR EACH ROW 
BEGIN 
  -- insert, update, or delete 
  IF INSERTING THEN 
    INSERT INTO log_table (operation, id, name, price) VALUES ('INSERT', :NEW.id, :NEW.name, :NEW.price); 
  ELSIF UPDATING THEN 
    INSERT INTO log_table (operation, id, name, price) VALUES ('UPDATE', :NEW.id, :NEW.name, :NEW.price); 
  ELSIF DELETING THEN 
    INSERT INTO log_table (operation, id, name, price) VALUES ('DELETE', :OLD.id, :OLD.name, :OLD.price); 
  END IF; 
END; 
/

INSERT INTO tproduct (id, name, price) VALUES (123, 'Widget', 10.99);

SELECT * FROM log_table;

SELECT * FROM tproduct;

