CREATE OR REPLACE TYPE number_array AS TABLE OF NUMBER;
CREATE OR REPLACE FUNCTION ort_loeschen(p_ort_id IN number_array) RETURN NUMBER IS
v_geloeschte_zahl NUMBER := 0;

BEGIN
    
  DELETE FROM cmi_test_eltern e
  WHERE e.id_vater IN (
  SELECT p.id
  FROM cmi_test_person p
  JOIN cmi_test_familien f ON p.id_familien = f.id
  JOIN cmi_test_ort o ON f.id_ort = o.id
  WHERE o.id MEMBER OF p_ort_id
  )
  OR e.id_mutter IN (
  SELECT p.id 
  FROM cmi_test_person p
  JOIN cmi_test_familien f ON p.id_familien = f.id
  JOIN cmi_test_ort o ON f.id_ort = o.id
  WHERE o.id MEMBER OF p_ort_id
  );
  
  DELETE FROM cmi_test_person p
  WHERE p.id_familien IN (
  SELECT f.id
  FROM cmi_test_familien f
  JOIN cmi_test_ort o ON f.id_ort = o.id
  WHERE o.id MEMBER OF p_ort_id);
  
  DELETE FROM cmi_test_familien f
  WHERE f.id_ort IN (
  SELECT o.id
  FROM cmi_test_ort o
  JOIN cmi_test_familien f ON f.id_ort = o.id
  WHERE o.id MEMBER OF p_ort_id);
  
    FOR i IN p_ort_id.first..p_ort_id.last LOOP
  DELETE FROM cmi_test_ort o
  WHERE o.id = p_ort_id(i);
  v_geloeschte_zahl := v_geloeschte_zahl + SQL%ROWCOUNT;
  END LOOP;
  
  COMMIT;
  
  RETURN v_geloeschte_zahl;
  END; 
  
  
    
