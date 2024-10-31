CREATE OR REPLACE PROCEDURE personen_nach_ort (v_ort IN cmi_test_ort.name%TYPE, ergebnis OUT VARCHAR2) IS
v_ergebnis VARCHAR2(4000) := '';
v_count NUMBER;

BEGIN
  
SELECT COUNT(*)
INTO   v_count
FROM   cmi_test_person   p
      ,cmi_test_familien f
      ,cmi_test_ort      o
WHERE  p.id_familien = f.id
AND    f.id_ort = o.id
AND    o.name = v_ort;

DBMS_OUTPUT.PUT_LINE('Anzahl der Perosonen ' || v_ort || ': ' || v_count);

IF v_count > 0 THEN

    FOR rec IN (SELECT p.vorname
                      ,f.familienname
                FROM   cmi_test_person   p
                      ,cmi_test_familien f
                      ,cmi_test_ort      o
                WHERE  p.id_familien = f.id
                AND    f.id_ort = o.id
                AND    o.name = v_ort) LOOP
    
        v_ergebnis := v_ergebnis || rec.vorname || ' ' || rec.familienname || ', ';
    END LOOP;

    ergebnis := v_ergebnis;

ELSE
    raise_application_error(-20001, 'Keine Personen von diesem Ort.');
END IF;

END personen_nach_ort;

///
--

DECLARE

    v_result VARCHAR(4000) := '';

BEGIN
    personen_nach_ort('Berlin', v_result);
    DBMS_OUTPUT.PUT_LINE('result: ' || v_result);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;
