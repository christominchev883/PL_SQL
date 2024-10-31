CREATE OR REPLACE PROCEDURE insert_person(
       c_name IN cmi_test_person.vorname%TYPE, 
       c_geburtstagdatum IN cmi_test_person.geburtsdatum%TYPE, 
       c_taetigkeit IN cmi_test_person.taetigkeit%TYPE, 
       c_id_familen IN cmi_test_person.id_familien%TYPE 
       ) IS
  
       c_id cmi_test_person.id%TYPE;

BEGIN
  
  IF c_name IS NULL THEN
    dbms_output.put_line('Fehler');
     RETURN;
    END IF;
     
     SELECT NVL(MAX(ID), 0) + 1 INTO c_id FROM cmi_test_person;
     
     INSERT INTO cmi_test_person(ID, vorname, geburtsdatum, taetigkeit, id_familien)
     VALUES (c_id, c_name, c_geburtstagdatum, c_taetigkeit, c_id_familen);
     
     COMMIT;
     
     dbms_output.put_line('Datensatz erfolgreich eingefügt mit ID: ' || c_id);
END insert_person;
