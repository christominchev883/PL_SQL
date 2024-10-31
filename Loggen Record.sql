CREATE OR REPLACE FUNCTION log_test_person (id_input IN cmi_test_person.id%TYPE) RETURN VARCHAR2 IS output_name VARCHAR2(6000);


person_rec cmi_test_person%ROWTYPE;
BEGIN
  SELECT * INTO person_rec
  FROM cmi_test_person
  WHERE cmi_test_person.id = id_input;
  output_name := person_rec.vorname || ', ' || person_rec.geburtsdatum || ', ' || person_rec.taetigkeit || ', ' || person_rec.id_familien;
  RETURN output_name;
  --dbms_output.put_line(person_rec.ID);
 -- dbms_output.put_line(person_rec.vorname);
 -- dbms_output.put_line(person_rec.geburtsdatum);
 -- dbms_output.put_line(person_rec.taetigkeit);
  --dbms_output.put_line(person_rec.id_familien);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL; -- или можете да върнете стойност, която указва, че няма намерен запис
    WHEN OTHERS THEN
        RETURN NULL;
  END;
  
  DECLARE
  output VARCHAR2(40);
  BEGIN
    output := log_test_person(12);
    dbms_output.put_line(output);
    END;
    


    
  
