REM   Script: EX8
REM   Functie care calculeaza valoarea totala a pretului de baza a produselor care exista intr-un magazin folosind o comanda SQL cu 3 tabele . Totodata am definit 2 exceptii .

CREATE OR REPLACE FUNCTION get_total_product_value_by_store_id (store_id IN INTEGER) 
RETURN NUMBER 
AS 
  total_value NUMBER; 
  store_not_found EXCEPTION; 
  no_products_sold EXCEPTION; 
  cnt INTEGER; 
BEGIN 
  -- total value of products sold at the store 
  SELECT SUM(p.price) INTO total_value 
  FROM tproduct p 
  INNER JOIN tproductstorerelation r ON p.id = r.id_product 
  INNER JOIN tstore s ON r.id_store = s.id 
  WHERE s.id = store_id; 
 
  -- if id doesnt exists or if no products were sold, exception 
  IF total_value IS NULL THEN 
    SELECT COUNT(*) INTO cnt FROM tstore WHERE id = store_id; 
    IF cnt = 0 THEN 
      RAISE store_not_found; 
    ELSE 
      RAISE no_products_sold; 
    END IF; 
  END IF; 
 
  RETURN total_value; 
EXCEPTION 
  WHEN store_not_found THEN 
    RAISE_APPLICATION_ERROR(-20001, 'Store with ID ' || store_id || ' not found'); 
  WHEN no_products_sold THEN 
    RAISE_APPLICATION_ERROR(-20002, 'No products sold at store with ID ' || store_id); 
END; 
/

BEGIN 
  DBMS_OUTPUT.PUT_LINE(get_total_product_value_by_store_id(1)); 
END; 
/

BEGIN 
  DBMS_OUTPUT.PUT_LINE(get_total_product_value_by_store_id(2)); 
END; 
/

BEGIN 
  DBMS_OUTPUT.PUT_LINE(get_total_product_value_by_store_id(11)); 
END; 
/

